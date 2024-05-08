import requests
from djongo.models import Q
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import Producer, Mobile,Type
from .serializers import ProducerSerializer, TypeSerializer, MobileSerializer, MobileInfoSerializer, UpdateMobileSerializer

class CreateProducerView(APIView):
    def post(self, request):
        serializer = ProducerSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CreateTypeView(APIView):
    def post(self, request):
        serializer = TypeSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class AddMobileView(APIView):
    def post(self, request):
        serializer = MobileSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ProducerListView(APIView):
    def get(self, request):
        producers = Producer.objects.filter(is_active__in=[True]).all()
        serializer = ProducerSerializer(producers, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
class MobileListView(APIView):
    def get(self, request):
        mobiles = Mobile.objects.filter(is_active__in=[True]).all()
        serializer = MobileInfoSerializer(mobiles, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
class MobileListofProducerView(APIView):
    def get(self, request, producer_id):
        mobiles = Mobile.objects.filter(producer_id=producer_id, is_active__in=[True])
        serializer = MobileInfoSerializer(mobiles, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

class SearchMobileListView(APIView):
    def get(self, request, key):
        mobiles = Mobile.objects.filter(title__icontains=key, is_active__in=[True])
        serializer = MobileInfoSerializer(mobiles, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

class UpdateMobileView(APIView):
    def put(self, request, mobile_id):
        try:
            mobile = Mobile.objects.get(mobile_id=mobile_id)
        except Mobile.DoesNotExist:
            return Response({'error': 'Mobile not found'}, status=status.HTTP_404_NOT_FOUND)
        serializer = UpdateMobileSerializer(mobile, data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class DeleteProducer(APIView):
    def delete(self, request, producer_id):
        try:
            producer = Producer.objects.get(producer_id=producer_id)
        except Producer.DoesNotExist:
            return Response({'error': 'Producer not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = ProducerSerializer()
        serializer.destroy(producer)
        
        return Response({'message': 'Producer soft deleted'}, status=status.HTTP_204_NO_CONTENT)
    
class DeleteType(APIView):
    def delete(self, request, type_id):
        try:
            type = Type.objects.get(type_id=type_id)
        except Type.DoesNotExist:
            return Response({'error': 'Type not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = TypeSerializer()
        serializer.destroy(type)
        
        return Response({'message': 'Type soft deleted'}, status=status.HTTP_204_NO_CONTENT)

class DeleteMobile(APIView):
    def delete(self, request, mobile_id):
        try:
            mobile = Mobile.objects.get(mobile_id=mobile_id)
        except Mobile.DoesNotExist:
            return Response({'error': 'Mobile not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = MobileSerializer()
        serializer.destroy(mobile)
        
        return Response({'message': 'Mobile soft deleted'}, status=status.HTTP_204_NO_CONTENT)

class MobileDetailView(APIView):
    def get(self, request, mobile_id):
        mobile = Mobile.objects.filter(mobile_id=mobile_id, is_active__in=[True]).first()
        serializer = MobileInfoSerializer(mobile)
        return Response(serializer.data, status=status.HTTP_200_OK)