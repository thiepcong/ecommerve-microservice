from djongo import models

class Style(models.Model):
    style_id = models.CharField(max_length=7, primary_key=True)
    name = models.CharField(max_length=100, unique=True)
    is_active = models.BooleanField(default=True)
    des = models.TextField(null=True)

    def __str__(self):
        return self.name
    
class Producer(models.Model):
    producer_id = models.CharField(max_length=7, primary_key=True)
    name = models.CharField(max_length=100, unique=True)
    is_active = models.BooleanField(default=True)
    des = models.TextField(null=True)

    def __str__(self):
        return self.name

class Clothes(models.Model):
    clothes_id = models.CharField(max_length=7, primary_key=True)
    title = models.CharField(max_length=100)
    image = models.ImageField(upload_to='image/clothes/')
    price = models.FloatField()
    sale = models.FloatField()
    quantity = models.IntegerField()
    color = models.CharField(max_length=50)
    is_active = models.BooleanField(default=True)
    des = models.TextField(null=True)

    style = models.ForeignKey(Style, on_delete=models.CASCADE)
    producer = models.ForeignKey(Producer, on_delete=models.CASCADE)
