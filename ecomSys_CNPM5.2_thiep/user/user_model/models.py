from django.db import models

class FullName(models.Model):
    fname = models.CharField(max_length=50)
    lname = models.CharField(max_length=50)
    
class Account(models.Model):
    email = models.CharField(max_length=50, unique=True)
    password = models.CharField(max_length=256)

class Address(models.Model):
    street = models.CharField(max_length=50)
    ward = models.CharField(max_length=50)
    district = models.CharField(max_length=50)
    province = models.CharField(max_length=50)

class User(models.Model):
    id = models.CharField(max_length=7, primary_key=True)
    mobile = models.CharField(max_length=12)
    address = models.CharField(max_length=200)
    dob = models.DateField()
    is_active = models.BooleanField(default=True)
    position = models.IntegerField()
    address = models.ForeignKey(Address, on_delete=models.CASCADE)
    account = models.ForeignKey(Account, on_delete=models.CASCADE)
    full_name = models.ForeignKey(FullName, on_delete=models.CASCADE)
    
    def __str__(self):
        return self.fname + " " + self.lname