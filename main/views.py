from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from .models import Subject, Topic, Note, Question, Comment, UserProfile, ChatMessage
from .forms import NoteForm, QuestionForm, CommentForm, UserProfileForm
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.forms import UserCreationForm
from django.contrib import messages
from django.http import JsonResponse, HttpResponseBadRequest
from django.db.models import Q
from django.contrib.auth.models import User
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from .serializers import AddressSerializer
from django.views.decorators.csrf import ensure_csrf_cookie
from django.views.decorators.csrf import csrf_exempt



def get_data(request, query):
    if request.method == 'GET':
        if query:
            # Optimize queries by combining related filters and selecting only required fields
            filtered_subjects = Subject.objects.filter(
                Q(name__icontains=query)
            ).only('name', 'auto_slug')

            filtered_topics = Topic.objects.filter(
                Q(name__icontains=query) |
                Q(subject__name__icontains=query) |
                Q(subject__description__icontains=query)
            ).only('name', 'auto_slug', 'subject__name')

            filtered_notes = Note.objects.filter(
                Q(title__icontains=query) |
                Q(topics__name__icontains=query) |
                Q(topics__subject__name__icontains=query)
            ).distinct().prefetch_related('topics__subject').only('title', 'auto_slug', 'uploaded_by__username')

            filtered_questions = Question.objects.filter(
                Q(title__icontains=query) |
                Q(topics__name__icontains=query) |
                Q(topics__subject__name__icontains=query)
            ).distinct().only('title', 'auto_slug', 'added_by__username')

            # Prepare the data to be returned in JSON format
            data = {
                'subjects': list(filtered_subjects.values('name', 'auto_slug')),
                'topics': list(filtered_topics.values('name', 'auto_slug', 'subject__auto_slug')),
                'notes': [
                    {
                        'title': note.title,
                        'auto_slug': note.auto_slug,
                        'uploaded_by': note.uploaded_by.username,
                        'topics': [
                            {
                                'name': topic.name,
                                'topic_slug': topic.auto_slug,
                                'subject_slug': topic.subject.auto_slug,  # Get subject slug here
                            }
                            for topic in note.topics.all()
                        ]
                    }
                    for note in filtered_notes
                ],
                'questions': list(filtered_questions.values('title', 'auto_slug', 'added_by__username'))
            }

            return JsonResponse(data)
        else:
            return JsonResponse({'error': 'Query parameter is required'}, status=400)
    else:
        return JsonResponse({'error': 'Invalid request method'}, status=405)

def signup_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password1 = request.POST.get('password1')
        password2 = request.POST.get('password2')

        if password1 != password2:
            return JsonResponse({'success': False, 'error': 'Passwords do not match.'}, status=400)

        form = UserCreationForm({
            'username': username,
            'email': email,
            'password1': password1,
            'password2': password2
        })

        if form.is_valid():
            user = form.save()
            login(request, user)
            return JsonResponse({'success': True})
        else:
            return JsonResponse({'success': False, 'error': 'Form is not valid.'}, status=400)

    else:
        form = UserCreationForm()
    return render(request, 'signup.html', {'form': form})

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return JsonResponse({'success': True})
        else:
            return JsonResponse({'success': False, 'error': 'Invalid username or password.'}, status=400)
    
    return render(request, 'login.html')

@csrf_exempt
def logout_view(request):
    logout(request)
    return redirect('login')  # Redirect to the login page after logout

def home(request):
    return render(request, "home.html")

# List all subjects
def subjects(request):
    subjects = Subject.objects.all()
    return render(request, 'subjects.html', {'subjects': subjects})

# Detail view of a subject including its topics
def topics(request, slug):
    subject = get_object_or_404(Subject, auto_slug=slug)
    topics = subject.topics.all()
    return render(request, 'topics.html', {'subject': subject, 'topics': topics})

# Detail view of a topic including notes and questions
def topic_detail(request, subject_slug, topic_slug):
    topic = get_object_or_404(Topic, auto_slug=topic_slug)
    subject = get_object_or_404(Subject, auto_slug=subject_slug)
    notes = Note.objects.filter(topics=topic)
    questions = Question.objects.filter(topics=topic)

    # Fetch all comments related to the notes and questions
    notes_comments = Comment.objects.filter(note__in=notes)
    questions_comments = Comment.objects.filter(question__in=questions)

    # Create dictionaries to store comments for each note and question
    notes_comments_dict = {note.id: [] for note in notes}
    questions_comments_dict = {question.id: [] for question in questions}

    # Populate dictionaries with comments
    for comment in notes_comments:
        notes_comments_dict[comment.note.id].append(comment)
    
    for comment in questions_comments:
        questions_comments_dict[comment.question.id].append(comment)

    context = {
        'topic': topic,
        'subject': subject,
        'notes': notes,
        'questions': questions,
        'notes_comments': notes_comments_dict,
        'questions_comments': questions_comments_dict,
    }

    return render(request, 'topic_detail.html', context)

# Detail view of a note
def note_detail(request, subject_slug, topic_slug, note_slug):
    note = get_object_or_404(Note, auto_slug=note_slug)

    # Get the topic associated with the note
    topic = get_object_or_404(Topic, auto_slug=topic_slug)

    # Get the subject associated with the topic
    subject = get_object_or_404(Subject, auto_slug=subject_slug)

    # Get the previous note
    previous_note = Note.objects.filter(id__lt=note.id).order_by('-id').first()

    # Get the next note
    next_note = Note.objects.filter(id__gt=note.id).order_by('id').first()

    context = {
        'topic': topic,
        'subject': subject,
        'note': note,
        'previous_note': previous_note,
        'next_note': next_note,
    }
    return render(request, 'note_detail.html', context)

def question_detail(request, subject_slug, topic_slug, question_slug):
    question = get_object_or_404(Question, auto_slug=question_slug)

    # Get the topic associated with the question
    topic = get_object_or_404(Topic, auto_slug=topic_slug)

    # Get the subject associated with the topic
    subject = get_object_or_404(Subject, auto_slug=subject_slug)

    # Get the previous question
    previous_question = Question.objects.filter(id__lt=question.id).order_by('-id').first()

    # Get the next question
    next_question = Question.objects.filter(id__gt=question.id).order_by('id').first()

    context = {
        'topic': topic,
        'subject': subject,
        'question': question,
        'previous_note': previous_question,
        'next_note': next_question,
    }
    return render(request, 'question_detail.html', context)

def chat(request):
    return render(request, 'chat.html')

@login_required
def add_note_comment(request, topic_id):
    if request.method == 'POST':
        content = request.POST.get('content')
        note_id = request.POST.get('note_id')
        note = get_object_or_404(Note, id=note_id)
        comment = Comment(content=content, commented_by=request.user, note=note)
        comment.save()
        return redirect('topic_detail', topic_id=topic_id)
    return redirect('topic_detail', topic_id=topic_id)

@login_required
def add_question_comment(request, topic_id):
    if request.method == 'POST':
        content = request.POST.get('content')
        question_id = request.POST.get('question_id')
        question = get_object_or_404(Question, id=question_id)
        comment = Comment(content=content, commented_by=request.user, question=question)
        comment.save()
        return redirect('topic_detail', topic_id=topic_id)
    return redirect('topic_detail', topic_id=topic_id)

@login_required
def create_note(request):
    if request.method == 'POST':
        form = NoteForm(request.POST)
        if form.is_valid():
            note = form.save(commit=False)
            # Retrieve selected topics from form data
            topics_ids = request.POST.getlist('topics')
            note.uploaded_by = request.user
            note.save()
            note.topics.set(topics_ids)  # Set many-to-many relationships
            return redirect('dashboard')  # Redirect to dashboard or appropriate page
    else:
        form = NoteForm()
    topics = Topic.objects.all()
    return render(request, 'note_form.html', {'form': form, 'topics': topics})

@login_required
def create_question(request):
    if request.method == 'POST':
        form = QuestionForm(request.POST)
        if form.is_valid():
            question = form.save(commit=False)
            # Retrieve selected topics from form data
            topics_ids = request.POST.getlist('topics')
            question.added_by = request.user
            question.save()
            question.topics.set(topics_ids)  # Set many-to-many relationships
            return redirect('dashboard')  # Redirect to dashboard or appropriate page
    else:
        form = QuestionForm()
    topics = Topic.objects.all()
    return render(request, 'question_form.html', {'form': form, 'topics': topics})

# Create a new comment on a note
@login_required
def create_comment_note(request, note_pk):
    """
    Creates a comment for a specific note.

    Args:
        request (HttpRequest): The HTTP request object.
        note_pk (int): The primary key of the note.

    Returns:
        HttpResponse: The HTTP response object.

    Raises:
        Http404: If the note with the given primary key does not exist.

    """
    note = get_object_or_404(Note, pk=note_pk)
    if request.method == 'POST':
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.note = note
            comment.commented_by = request.user
            comment.save()
            return redirect('note_detail', pk=note.pk)
    else:
        form = CommentForm()
    return render(request, 'comment_form.html', {'form': form})

# Create a new comment on a question
@login_required
def create_comment_question(request, question_pk):
    question = get_object_or_404(Question, pk=question_pk)
    if request.method == 'POST':
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.question = question
            comment.commented_by = request.user
            comment.save()
            return redirect('question_detail', pk=question.pk)
    else:
        form = CommentForm()
    return render(request, 'comment_form.html', {'form': form})

def dashboard(request):
    notes = Note.objects.filter(uploaded_by = request.user)
    questions = Question.objects.filter(added_by = request.user)
    return render(request, 'dashboard.html', {"notes":notes, "questions": questions})

@login_required
def edit_profile(request):
    # Get the user's profile or create one if it doesn't exist
    profile, created = UserProfile.objects.get_or_create(user=request.user)
    
    if request.method == 'POST':
        form = UserProfileForm(request.POST, request.FILES, instance=profile)
        if form.is_valid():
            form.save()
            messages.success(request, 'Your profile has been updated!')
            return redirect('dashboard')  # Redirect to the profile page or any other page
        else:
            messages.error(request, 'Please correct the error below.')
    else:
        form = UserProfileForm(instance=profile)
    
    context = {
        'form': form,
    }
    return render(request, 'edit_profile.html', context)


def users(request):
    all_users = User.objects.exclude(id=request.user.id)
    users_with_room = []
    
    for user in all_users:
        room_name = get_room_name(request.user.id, user.id)
        users_with_room.append([user, room_name])
    
    context = {
        'users_with_room': users_with_room
    }
    return render(request, 'users.html', context)

def chat(request, room_name):
    # Split room_name into user_id_1 and user_id_2
    try:
        prefix, user_id_1, user_id_2 = room_name.split('_')
        if prefix != "room":  # Ensure room name format starts with "room"
            return HttpResponseBadRequest("Invalid room name format")
    except ValueError:
        return HttpResponseBadRequest("Invalid room name format")
    
    # Ensure both user IDs are integers
    try:
        user_id_1 = int(user_id_1)
        user_id_2 = int(user_id_2)
    except ValueError:
        return HttpResponseBadRequest("Invalid user IDs in room name")

    # Identify the other user
    if request.user.id == user_id_1:
        other_user_id = user_id_2
    elif request.user.id == user_id_2:
        other_user_id = user_id_1
    else:
        return HttpResponseBadRequest("Current user not part of this room")

    # Fetch the other user
    try:
        other_user = User.objects.get(id=other_user_id)
    except User.DoesNotExist:
        return HttpResponseBadRequest("Other user does not exist")

    # Retrieve chat messages between both users
    messages = ChatMessage.objects.filter(
        sender__in=[request.user, other_user],
        receiver__in=[request.user, other_user]
    ).order_by('sent_at')

    # Pass the room name, other user, and messages to the template
    context = {
        'room_name': room_name,
        'user': other_user,
        'messages': messages
    }
    return render(request, 'chat.html', context)

# It will provide a common room to to both the users
def get_room_name(id1, id2):
    if id1 < id2:
        return f'room_{id1}_{id2}'
    else:
        return f'room_{id2}_{id1}'

def get_messages(request, user_id):
    # Fetch the selected user
    selected_user = User.objects.get(id=user_id)
    
    # Fetch messages between the current user and the selected user
    messages = ChatMessage.objects.filter(
        sender__in=[request.user, selected_user],
        receiver__in=[request.user, selected_user]
    ).order_by('sent_at')

    # Serialize the messages to send via JSON
    chat_messages = [
        {
            'sender': msg.sender.username,
            'receiver': msg.receiver.username,
            'content': msg.content,
            'sent_at': msg.sent_at.strftime('%H:%M'),
            'sender_pfp': msg.sender.userprofile.pfp.url if msg.sender.userprofile.pfp else '',
            'receiver_pfp': msg.receiver.userprofile.pfp.url if msg.receiver.userprofile.pfp else ''
        }
        for msg in messages
    ]

    # User details for the header (you can customize the details you want to send)
    user_details = {
        'username': selected_user.username,
        'first_name': selected_user.first_name,
        'last_name': selected_user.last_name,
        'profile_pic': selected_user.userprofile.pfp.url if selected_user.userprofile.pfp else '',
    }

    return JsonResponse({'messages': chat_messages, 'user': user_details})

def send_message(request):
    if request.method == 'POST':
        sender = request.user
        receiver = User.objects.get(id=request.POST.get('receiver_id'))
        content = request.POST.get('content')
        ChatMessage.objects.create(sender=sender, receiver=receiver, content=content)
        return JsonResponse({'success': True})
    else:
        return JsonResponse({'success': False})


def recent_notes(request):
    # Fetch the 10 most recent notes
    notes = Note.objects.prefetch_related('topics').order_by('-created_at')[:10]
    
    # Prepare data with slugs for template
    note_data = []
    for note in notes:
        # Get the first associated topic for simplicity (or adapt as needed)
        topic = note.topics.first()
        if topic:
            note_data.append({
                'title': note.title,
                'content': note.content,
                'created_at': note.created_at,
                'note_slug': note.auto_slug,
                'topic_slug': topic.auto_slug,
                'subject_slug': topic.subject.auto_slug,  # Access related subject
                'category': "General",  # You can adapt this based on your use case
            })

    return render(request, 'recent.html', {'notes': note_data})
