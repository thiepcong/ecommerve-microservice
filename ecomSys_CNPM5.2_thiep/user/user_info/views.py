from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from user_model.models import User
from user_model.serializers import UserSerializer, UserUpdateSerializer 

class UserInfoView(APIView):
    def get(self, request, user_id):
        user = get_object_or_404(User, id=user_id, is_active=True)
        serializer = UserSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)

class UpdateProfileView(APIView):
    def put(self, request, user_id):
        user = User.objects.filter(id=user_id, is_active=True).first()
        if not user:
            return Response({'message': 'User does not exist.'}, status=status.HTTP_404_NOT_FOUND)
        serializer = UserUpdateSerializer(instance=user, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)