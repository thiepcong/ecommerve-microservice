import requests
from djongo.models import Q
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from clothes_service.models import Producer, Style, Clothes
from clothes_service.serializers import ProducerSerializer, StyleSerializer, ClothesSerializer, UpdateClothesSerializer

class CreateStyleView(APIView):
    def post(self, request):
        serializer = StyleSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class CreateProducerView(APIView):
    def post(self, request):
        serializer = ProducerSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class AddClothesView(APIView):
    def post(self, request):
        serializer = ClothesSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class StyleListView(APIView):
    def get(self, request):
        categories = Style.objects.filter(is_active__in=[True]).all()
        serializer = StyleSerializer(categories, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

class ClothesListView(APIView):
    def get(self, request):
        clothes = Clothes.objects.filter(is_active__in=[True]).all()
        serializer = ClothesSerializer(clothes, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
class ClothesListofStyleView(APIView):
    def get(self, request, style_id):
        clothes = Clothes.objects.filter(style_id=style_id, is_active__in=[True])
        serializer = ClothesSerializer(clothes, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

class SearchClothesListView(APIView):
    def get(self, request, key):
        clothes = Clothes.objects.filter(Q(title__icontains=key), is_active__in=[True])
        serializer = ClothesSerializer(clothes, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

class UpdateClothesView(APIView):
    def put(self, request, clothes_id):
        try:
            clothes = Clothes.objects.get(clothes_id=clothes_id)
        except Clothes.DoesNotExist:
            return Response({'error': 'Clothes not found'}, status=status.HTTP_404_NOT_FOUND)
        serializer = UpdateClothesSerializer(clothes, data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class DeleteStyle(APIView):
    def delete(self, request, style_id):
        try:
            style = Style.objects.get(style_id=style_id)
        except Style.DoesNotExist:
            return Response({'error': 'Style not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = StyleSerializer()
        serializer.destroy(style)
        
        return Response({'message': 'Style soft deleted'}, status=status.HTTP_204_NO_CONTENT)
    
class DeleteProducer(APIView):
    def delete(self, request, producer_id):
        try:
            producer = Producer.objects.get(producer_id=producer_id)
        except Producer.DoesNotExist:
            return Response({'error': 'Producer not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = ProducerSerializer()
        serializer.destroy(producer)
        
        return Response({'message': 'Producer soft deleted'}, status=status.HTTP_204_NO_CONTENT)
    
class DeleteClothes(APIView):
    def delete(self, request, clothes_id):
        try:
            clothes = Clothes.objects.get(clothes_id=clothes_id)
        except Clothes.DoesNotExist:
            return Response({'error': 'Clothes not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = ClothesSerializer()
        serializer.destroy(clothes)
        
        return Response({'message': 'Clothes soft deleted'}, status=status.HTTP_204_NO_CONTENT)

class ClothesDetailView(APIView):
    def get(self, request, clothes_id):
        clothes = Clothes.objects.filter(clothes_id=clothes_id, is_active__in=[True]).first()
        serializer = ClothesSerializer(clothes)
        return Response(serializer.data, status=status.HTTP_200_OK)