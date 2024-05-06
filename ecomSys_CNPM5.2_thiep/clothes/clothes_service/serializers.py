from rest_framework import serializers
from .models import Clothes

class ClothesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Clothes
        fields = ['clothes_id', 'title',  'quantity', 'des','price','sale','image']
