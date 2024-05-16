from rest_framework import serializers
from .models import FullName, Account, Address, User

class FullNameSerializer(serializers.ModelSerializer):
    class Meta:
        model = FullName
        fields = ['fname', 'lname']

class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['email', 'password']

class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = ['street', 'ward', 'district', 'province']

class UserSerializer(serializers.ModelSerializer):
    full_name = FullNameSerializer()
    account = AccountSerializer()
    address = AddressSerializer()
    
    class Meta:
        model = User
        fields = ['id', 'mobile', 'dob', 'is_active', 'position', 'address', 'account', 'full_name']
