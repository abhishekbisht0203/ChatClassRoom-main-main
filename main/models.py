from django.db import models
from django.contrib.auth.models import User
from autoslug import AutoSlugField
from cloudinary.models import CloudinaryField

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    bio = models.TextField(blank=True, null=True)
    pfp = CloudinaryField('pfp', blank=True, null=True)

    def __str__(self):
        return self.user.username

class Subject(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True, default="IDk")
    auto_slug = AutoSlugField(populate_from='name', unique=True, blank=True, max_length=255)

    def __str__(self):
        return self.name

class Topic(models.Model):
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE, related_name='topics')
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    auto_slug = AutoSlugField(populate_from='name', unique=True, blank=True, max_length=255)

    def __str__(self):
        return self.name

class Note(models.Model):
    topics = models.ManyToManyField(Topic, related_name='notes')
    title = models.CharField(max_length=255)
    content = models.TextField()
    uploaded_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='uploaded_notes')
    created_at = models.DateTimeField(auto_now_add=True)
    auto_slug = AutoSlugField(populate_from='title', unique=True, blank=True, max_length=255)

    def __str__(self):
        return self.title

class Question(models.Model):
    topics = models.ManyToManyField(Topic, related_name='questions')
    title = models.CharField(max_length=255, blank=True, editable=False)  # New field for title
    content = models.TextField()
    added_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='added_questions')
    created_at = models.DateTimeField(auto_now_add=True)
    auto_slug = AutoSlugField(populate_from='title', unique=True, blank=True, max_length=255)
    

    def save(self, *args, **kwargs):
        # Check if title is empty or needs to be set
        if not self.title:
            # Get the count of questions already existing
            existing_count = Question.objects.count() + 1  # Increment count for new set
            self.title = f"Question Set {existing_count}"
            
            # Check for uniqueness
            while Question.objects.filter(title=self.title).exists():
                existing_count += 1
                self.title = f"Question Set {existing_count}"
        
        super().save(*args, **kwargs)

    def __str__(self):
        return self.title or self.question_text[:50]  # Return the title or a snippet of the question

class Comment(models.Model):
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    commented_by = models.ForeignKey(User, on_delete=models.CASCADE)
    
    # Make this a generic relation (to be used for both notes and questions)
    note = models.ForeignKey(Note, on_delete=models.CASCADE, null=True, blank=True, related_name='comments')
    question = models.ForeignKey(Question, on_delete=models.CASCADE, null=True, blank=True, related_name='comments')

    def __str__(self):
        return f"Comment by {self.commented_by} on {self.created_at}"

class ChatMessage(models.Model):
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_messages')
    receiver = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_messages')
    content = models.TextField()
    sent_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Message from {self.sender} to {self.receiver}"  # Show a snippet of the message
