from djongo import models

class Producer(models.Model):
    producer_id = models.CharField(max_length=7, primary_key=True)
    name = models.CharField(max_length=100, unique=True)
    is_active = models.BooleanField(default=True)
    des = models.TextField(null=True)

    def __str__(self):
        return self.name

class Type(models.Model):
    type_id = models.CharField(max_length=7, primary_key=True)
    name = models.CharField(max_length=100, unique=True)
    is_active = models.BooleanField(default=True)
    des = models.TextField(null=True)

    def __str__(self):
        return self.name

class Mobile(models.Model):
    mobile_id = models.CharField(max_length=7, primary_key=True)
    title = models.CharField(max_length=100)
    image = models.ImageField(upload_to='image/mobiles/')
    price = models.FloatField()
    sale = models.FloatField()
    quantity = models.IntegerField()
    color = models.CharField(max_length=50)
    size = models.CharField(max_length=50)
    memory = models.CharField(max_length=50)
    ram = models.CharField(max_length=50)
    cpu = models.CharField(max_length=50)
    pin = models.CharField(max_length=50)
    is_active = models.BooleanField(default=True)
    des = models.TextField(null=True)

    producer = models.ForeignKey(Producer, on_delete=models.CASCADE)
    type = models.ForeignKey(Type, on_delete=models.CASCADE)

    def __str__(self):
        return self.title