from django.db import models

# Create your models here.
class Clothes(models.Model):
    clothes_id = models.CharField(max_length=7, primary_key=True)
    title = models.CharField(max_length=100)
    quantity = models.IntegerField()
    image = models.ImageField(upload_to='image/clothes/')
    price = models.FloatField(default=0.0)
    sale = models.FloatField(default=0.0)
    des = models.TextField(null=True)

    def __str__(self):
        return self.title