from django.shortcuts import render
from rest_framework.decorators import APIView
from rest_framework import status
import requests
from .serializers import MobileSerializer
from .models import Mobile
from rest_framework.response import Response
from djongo.models import Q

# Create your views here.
class AddMobileView(APIView):
    def post(self, request):
        token_verification_url = "http://localhost:4001/api/ecomSys/manager/verify-token/"
        headers = {'Authorization': request.headers.get('Authorization')}
        response = requests.get(token_verification_url, headers=headers)
        
        if response.status_code == 200:
            serializer = MobileSerializer(data=request.data, context={'request': request})
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        return Response({'error': 'Invalid token.'}, status=status.HTTP_401_UNAUTHORIZED)
    
class SearchMobileListView(APIView):
    def get(self, request, key):
        mobiles = Mobile.objects.filter(Q(title__icontains=key) | Q(author__icontains=key), is_active__in=[True])
        serializer = MobileSerializer(mobiles, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class MobileDetailView(APIView):
    def get(self, request, mobile_id):
        book = Mobile.objects.filter(mobile_id=mobile_id).first()
        serializer = MobileSerializer(book)
        return Response(serializer.data, status=status.HTTP_200_OK)
