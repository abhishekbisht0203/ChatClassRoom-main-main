from django.urls import path
from . import views
from django.views.generic import TemplateView

urlpatterns = [
    path("", views.home, name="home"),
    path('subjects/', views.subjects, name='subjects'),
    path('topics/<str:slug>/', views.topics, name='topics'),
    path('topics/<str:subject_slug>/detail/<str:topic_slug>/', views.topic_detail, name='topic_detail'),
    path('notes/<str:subject_slug>/<str:topic_slug>/<str:note_slug>/', views.note_detail, name='note_detail'),
    path('questions/<str:subject_slug>/<str:topic_slug>/<str:question_slug>/', views.question_detail, name='question_detail'),
    path('create_note/', views.create_note, name='create_note'),
    path('create_question/', views.create_question, name='create_question'),
    path('notes/<int:note_pk>/comments/create/', views.create_comment_note, name='create_comment_note'),
    path('questions/<int:question_pk>/comments/create/', views.create_comment_question, name='create_comment_question'),
    path('chat/<str:room_name>/', views.chat, name='chat'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('note/<int:topic_id>/comment/', views.add_note_comment, name='add_note_comment'),
    path('question/<int:topic_id>/comment/', views.add_question_comment, name='add_question_comment'),
    path('edit-profile/', views.edit_profile, name='edit_profile'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('signup/', views.signup_view, name='signup'),
    path('get_data/<str:query>/', views.get_data, name='get_data'),
    path('chat/get_messages/<int:user_id>/', views.get_messages, name='get_user_messages'),
    path('send_message/', views.send_message, name='send_message'),
    path('users/', views.users, name='users'),
    path('recent_notes/', views.recent_notes, name='recent_notes'),
    # path('serviceworker.js', TemplateView.as_view(template_name="serviceworker.js", content_type='application/javascript')),
]
