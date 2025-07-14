from django import forms
from .models import Note, Question, Topic, Comment, ChatMessage, UserProfile

class NoteForm(forms.ModelForm):
    topics = forms.ModelMultipleChoiceField(
        queryset=Topic.objects.all(),
        widget=forms.SelectMultiple(attrs={'class': 'select2 form-control'}),  # 'select2' class added
        label="Select Topics",
        required=True
    )

    class Meta:
        model = Note
        fields = ['topics', 'title', 'content']


class QuestionForm(forms.ModelForm):
    topics = forms.ModelMultipleChoiceField(
        queryset=Topic.objects.all(),
        widget=forms.SelectMultiple(attrs={'class': 'select2 form-control'}),  # 'select2' class added
        label="Select Topics",
        required=True
    )

    class Meta:
        model = Question
        fields = ['topics', 'content']

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ['content']

class ChatMessageForm(forms.ModelForm):
    class Meta:
        model = ChatMessage
        fields = ['receiver', 'content']

class UserProfileForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = ['bio', 'pfp']  # Fields that you want to allow users to edit
        widgets = {
            'bio': forms.Textarea(attrs={'class': 'form-control', 'rows': 3, 'placeholder': 'Enter your bio...'}),
            'pfp': forms.ClearableFileInput(attrs={'class': 'form-control-file'}),
        }