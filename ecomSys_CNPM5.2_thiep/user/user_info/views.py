from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from django.contrib.auth.hashers import make_password, check_password
from user_model.models import User
from user_model.serializers import UserSerializer, AddressSerializer, FullNameSerializer 

class ChangePasswordView(APIView):
    def post(self, request, user_id):
        data = request.data
        try:
            user = User.objects.get(id=user_id)
            account = user.account
            if check_password(data['old_password'], account.password):
                account.password = make_password(data['new_password'])
                account.save()
                return Response({'message': 'Password updated successfully'}, status=status.HTTP_200_OK)
            return Response({'error': 'Old password is incorrect'}, status=status.HTTP_400_BAD_REQUEST)
        except User.DoesNotExist:
            return Response({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND)

class ChangeProfileView(APIView):
    def put(self, request, user_id):
        data = request.data
        try:
            user = User.objects.get(id=user_id)
            user.mobile = data.get('mobile', user.mobile)
            user.dob = data.get('dob', user.dob)
            user.position = data.get('position', user.position)
            
            if 'address' in data:
                address_data = data['address']
                address_serializer = AddressSerializer(user.address, data=address_data, partial=True)
                if address_serializer.is_valid():
                    address_serializer.save()
                else:
                    return Response(address_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            
            if 'full_name' in data:
                full_name_data = data['full_name']
                full_name_serializer = FullNameSerializer(user.full_name, data=full_name_data, partial=True)
                if full_name_serializer.is_valid():
                    full_name_serializer.save()
                else:
                    return Response(full_name_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            
            user.save()
            return Response(UserSerializer(user).data, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND)