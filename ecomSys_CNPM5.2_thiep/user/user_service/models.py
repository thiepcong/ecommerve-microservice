from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    phone_number = models.CharField(max_length=20)
    email = models.EmailField(max_length=255, unique=True)
    username = models.CharField(max_length=100, unique=False, null=True, default=None)
    
    USERNAME_FIELD = 'email' 
    REQUIRED_FIELDS = ['username'] 

    def __str__(self):
        return self.email
