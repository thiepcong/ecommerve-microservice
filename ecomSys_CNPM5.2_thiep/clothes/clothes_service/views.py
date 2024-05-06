from django.shortcuts import render
from rest_framework.decorators import APIView
from rest_framework import status
import requests
from .serializers import ClothesSerializer
from .models import Clothes
from rest_framework.response import Response
from djongo.models import Q

# Create your views here.
class AddClothesView(APIView):
    def post(self, request):
        token_verification_url = "http://localhost:4001/api/ecomSys/manager/verify-token/"
        headers = {'Authorization': request.headers.get('Authorization')}
        response = requests.get(token_verification_url, headers=headers)
        
        if response.status_code == 200:
            serializer = ClothesSerializer(data=request.data, context={'request': request})
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        return Response({'error': 'Invalid token.'}, status=status.HTTP_401_UNAUTHORIZED)
    
class SearchClothesListView(APIView):
    def get(self, request, key):
        clothes = Clothes.objects.filter(Q(title__icontains=key))
        serializer = ClothesSerializer(clothes, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class ClothesDetailView(APIView):
    def get(self, request, clothes_id):
        clothes = Clothes.objects.filter(clothes_id=clothes_id).first()
        serializer = ClothesSerializer(clothes)
        return Response(serializer.data, status=status.HTTP_200_OK)
