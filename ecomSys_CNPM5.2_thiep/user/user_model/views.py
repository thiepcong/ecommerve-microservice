from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from user_model.models import User
from user_model.serializers import UserSerializer

class UserDetailView(APIView):
    def get(self, request, user_id):
        try:
            user = User.objects.get(pk=user_id)
            return Response(UserSerializer(user).data, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND)