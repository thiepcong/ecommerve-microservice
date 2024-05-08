from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from user_model.models import User
from user_model.serializers import ChangePasswordSerializer, UserLoginSerializer, UserSerializer

class LoginView(APIView):
    def post(self, request):
        serializer = UserLoginSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.validated_data 
            user_serializer = UserSerializer(user)
            
            return Response(user_serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ChangePasswordView(APIView):
    def post(self, request, user_id):
        user = User.objects.filter(id=user_id, is_active=True).first()
        if not user:
            return Response({'message': 'User does not exist.'}, status=status.HTTP_404_NOT_FOUND)

        serializer = ChangePasswordSerializer(data=request.data)
        if serializer.is_valid():
            old_password = serializer.validated_data['old_password']
            new_password = serializer.validated_data['new_password']
            if user.password != old_password:
                return Response({'message': 'Incorrect old password.'}, status=status.HTTP_400_BAD_REQUEST)
            user.set_password(new_password)
            user.save()
            return Response({'message': 'Password changed successfully.'}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
