from django.db import models

# Create your models here.
class Mobile(models.Model):
    mobile_id = models.CharField(max_length=7, primary_key=True)
    title = models.CharField(max_length=100)
    quantity = models.IntegerField()
    image = models.ImageField(upload_to='image/mobiles/')
    price = models.FloatField(default=0.0)
    sale = models.FloatField(default=0.0)
    des = models.TextField(null=True)

    def __str__(self):
        return self.title