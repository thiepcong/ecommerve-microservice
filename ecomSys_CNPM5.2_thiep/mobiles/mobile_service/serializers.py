from rest_framework import serializers
from .models import Mobile

class MobileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Mobile
        fields = ['mobile_id', 'title',  'quantity', 'des','price','sale','image']
