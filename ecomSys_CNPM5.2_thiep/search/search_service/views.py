import requests
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from .serializers import SearchSerializer
from .models import Search

class SearchView(APIView):
    def post(self, request):
        key = request.query_params.get('key', '')

        token_verification_url = "http://localhost:4000/api/ecomSys/user/info/"
        headers = {'Authorization': request.headers.get('Authorization')}
        response = requests.get(token_verification_url, headers=headers)

        if response.status_code == 200:
            user_id = response.json().get('id')
            Search.objects.create(key=key, user_id=user_id)

        result = []
        result += self.search_book(key)

        return Response(result, status=status.HTTP_200_OK)
        
    def search_book(self, key):
        book_service_url = "http://localhost:4002/api/ecomSys/book/search/{}/".format(key)

        book_response = requests.get(book_service_url)
        if book_response.status_code == 200:
            return book_response.json()
        return []
            
class ShowSearchView(APIView):
    def get(self, request):

        token_verification_url = "http://localhost:4000/api/ecomSys/user/info/"
        headers = {'Authorization': request.headers.get('Authorization')}
        response = requests.get(token_verification_url, headers=headers)
        if response.status_code == 200:
            user_id = response.json().get('id')
            searchs_instance = Search.objects.filter(is_active=True, user_id=user_id).all()
            serializer = SearchSerializer(searchs_instance, many=[True])
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response({'error': 'Invalid token.'}, status=status.HTTP_401_UNAUTHORIZED)

class DeleteSearchView(APIView):
    def delete(self, request, key):
        token_verification_url = "http://localhost:4000/api/ecomSys/user/info/"
        headers = {'Authorization': request.headers.get('Authorization')}
        response = requests.get(token_verification_url, headers=headers)

        if response.status_code == 200:
            user_id = response.json().get('id')

            try:
                search = Search.objects.get(user_id=user_id, key=key, is_active=True)
            except Search.DoesNotExist:
                return Response({'error': 'Search not found'}, status=status.HTTP_404_NOT_FOUND)
            
            serializer = SearchSerializer()
            serializer.destroy(search)
            
            return Response({'message': 'Search soft deleted'}, status=status.HTTP_204_NO_CONTENT)

        return Response({'error': 'Invalid token.'}, status=status.HTTP_401_UNAUTHORIZED)






