from rest_framework import serializers
from .models import User

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'fname', 'lname', 'email', 'mobile', 'password', 'address', 'dob', 'position']
    def destroy(self, instance):
        instance.is_active = False
        instance.save()
        return instance

class UserUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['fname', 'lname', 'mobile', 'address', 'dob']
    
    def update(self, instance, validated_data):
        instance.fname = validated_data.get('fname', instance.fname)
        instance.lname = validated_data.get('lname', instance.lname)
        instance.mobile = validated_data.get('mobile', instance.mobile)
        instance.address = validated_data.get('address', instance.address)
        instance.dob = validated_data.get('dob', instance.dob)
        instance.save()
        return instance

class ChangePasswordSerializer(serializers.ModelSerializer):
    old_password = serializers.CharField()
    new_password = serializers.CharField()

class UserLoginSerializer(serializers.Serializer):
    email = serializers.CharField()
    password = serializers.CharField(write_only=True) 

    def validate(self, data):
        email = data.get('email', None)
        password = data.get('password', None)

        if not email or not password:
            raise serializers.ValidationError('Email and password are required.')

        user = User.objects.filter(email=email, is_active=True).first()
        if user and user.password == password:
            return user
        else:
            raise serializers.ValidationError('User does not exist.')

