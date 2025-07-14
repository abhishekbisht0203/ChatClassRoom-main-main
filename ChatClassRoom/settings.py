import environ
import os
from pathlib import Path
import cloudinary
import cloudinary.uploader
import cloudinary.api

# Base Directory
BASE_DIR = Path(__file__).resolve().parent.parent

# Initialize environment variables
env = environ.Env(
    DEBUG=(bool, False)
)

# Read .env file
environ.Env.read_env(os.path.join(BASE_DIR, '.env'))

# SECURITY
SECRET_KEY = env("SECRET_KEY")
DEBUG = env("DEBUG")
ALLOWED_HOSTS = env.list("ALLOWED_HOSTS", default=[])

# Application definition
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'cloudinary',
    'crispy_forms',
    'crispy_tailwind',
    'widget_tweaks',
    'main.apps.MainConfig',
    'rest_framework',
    'pwa',
    'django.contrib.sites',
    'allauth',
    'allauth.account',
    'allauth.socialaccount',
    'allauth.socialaccount.providers.google',
    'allauth.socialaccount.providers.github',
    'corsheaders',
]

AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.ModelBackend',
    'allauth.account.auth_backends.AuthenticationBackend',
]

SITE_ID = 1
LOGIN_REDIRECT_URL = '/'
LOGOUT_REDIRECT_URL = '/'

# AllAuth settings
ACCOUNT_EMAIL_VERIFICATION = "none"
ACCOUNT_UNIQUE_EMAIL = True
ACCOUNT_EMAIL_CONFIRMATION_EXPIRE_DAYS = 1
ACCOUNT_LOGIN_ON_EMAIL_CONFIRMATION = False
ACCOUNT_LOGIN_ON_PASSWORD_RESET = True
ACCOUNT_SIGNUP_FIELDS = ['email*', 'username', 'password1', 'password2']
ACCOUNT_LOGIN_METHODS = {'username', 'email'}

# OAuth settings
SOCIALACCOUNT_PROVIDERS = {
    'google': {
        'APP': {
            'client_id': env("GOOGLE_CLIENT_ID"),
            'secret': env("GOOGLE_CLIENT_SECRET"),
            'key': ''
        },
        'SCOPE': ['profile', 'email'],
        'AUTH_PARAMS': {'access_type': 'online'}
    },
    'github': {
        'APP': {
            'client_id': env("GITHUB_CLIENT_ID"),
            'secret': env("GITHUB_CLIENT_SECRET"),
            'key': ''
        }
    }
}

CRISPY_ALLOWED_TEMPLATE_PACKS = "tailwind"
CRISPY_TEMPLATE_PACK = "tailwind"

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    "corsheaders.middleware.CorsMiddleware",
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    "allauth.account.middleware.AccountMiddleware",
]

ROOT_URLCONF = 'ChatClassRoom.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, "templates")],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'ChatClassRoom.wsgi.application'

# Database
DATABASES = {
    'default': env.db(default='sqlite:///' + str(BASE_DIR / 'db.sqlite3'))
}

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator'},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]

# Internationalization
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

# Static and Media files
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'main/static')
MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')

# Cloudinary configuration
cloudinary.config(
    cloud_name=env('CLOUDINARY_CLOUD_NAME'),
    api_key=env('CLOUDINARY_API_KEY'),
    api_secret=env('CLOUDINARY_API_SECRET'),
)
DEFAULT_FILE_STORAGE = 'cloudinary_storage.storage.MediaCloudinaryStorage'

# Email backend
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
EMAIL_HOST_USER = env('EMAIL_HOST_USER')
EMAIL_HOST_PASSWORD = env('EMAIL_HOST_PASSWORD')

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
