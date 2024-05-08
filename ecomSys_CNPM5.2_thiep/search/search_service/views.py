import requests
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from .serializers import SearchSerializer
from .models import Search

class SearchView(APIView):
    def post(self, request):
        key = request.query_params.get('key', '')
        user_id = request.query_params.get('user_id', '')
        if not key:
            return Response({'message': 'Key is required.'}, status=status.HTTP_400_BAD_REQUEST)
        if user_id:
            Search.objects.create(key=key, user_id=user_id)

        result = []
        result += self.search_book(key)
        result += self.search_mobile(key)
        result += self.search_clothes(key)

        return Response(result, status=status.HTTP_200_OK)
        
    def search_book(self, key):
        book_service_url = "http://localhost:4002/api/ecomSys/book/search/{}/".format(key)

        book_response = requests.get(book_service_url)
        if book_response.status_code == 200:
            return book_response.json()
        return []
    
    def search_mobile(self, key):
        mobile_service_url = "http://localhost:4002/api/ecomSys/mobile/search/{}/".format(key)

        mobile_response = requests.get(mobile_service_url)
        if mobile_response.status_code == 200:
            return mobile_response.json()
        return []
    
    def search_clothes(self, key):
        clothes_service_url = "http://localhost:4002/api/ecomSys/clothes/search/{}/".format(key)

        clothes_response = requests.get(clothes_service_url)
        if clothes_response.status_code == 200:
            return clothes_response.json()
        return []
            
class ShowSearchView(APIView):
    def get(self, request, user_id):
        if user_id:
            searchs_instance = Search.objects.filter(is_active__in=[True], user_id=user_id).all()
            serializer = SearchSerializer(searchs_instance, many=[True])
            return Response(serializer.data, status=status.HTTP_200_OK)

class DeleteSearchView(APIView):
    def delete(self, request, key, user_id):
        if user_id:
            try:
                search = Search.objects.get(user_id=user_id, key=key, is_active__in=[True])
            except Search.DoesNotExist:
                return Response({'error': 'Search not found'}, status=status.HTTP_404_NOT_FOUND)
            
            serializer = SearchSerializer()
            serializer.destroy(search)
            
            return Response({'message': 'Search soft deleted'}, status=status.HTTP_204_NO_CONTENT)






