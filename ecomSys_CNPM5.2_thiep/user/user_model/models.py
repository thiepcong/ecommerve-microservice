from django.db import models

class User(models.Model):
    id = models.CharField(max_length=7, primary_key=True)
    fname = models.CharField(max_length=50)
    lname = models.CharField(max_length=50)
    email = models.CharField(max_length=50)
    mobile = models.CharField(max_length=12)
    password = models.CharField(max_length=50)
    address = models.CharField(max_length=200)
    dob = models.DateField()
    is_active = models.BooleanField(default=True)
    position = models.IntegerField()
    
    def __str__(self):
        return self.fname + " " + self.lname