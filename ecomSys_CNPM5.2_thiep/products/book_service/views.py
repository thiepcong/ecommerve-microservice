import requests
from djongo.models import Q
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import Category, Book, Author, Publisher
from .serializers import CategorySerializer, BookSerializer, BookInfoSerializer, UpdateBookSerializer, AuthorSerializer, PublisherSerializer

class CreateCategoryView(APIView):
    def post(self, request):
        serializer = CategorySerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CreateAuthorView(APIView):
    def post(self, request):
        serializer = AuthorSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CreatePublisherView(APIView):
    def post(self, request):
        serializer = PublisherSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class AddBookView(APIView):
    def post(self, request):
        serializer = BookSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CategoryListView(APIView):
    def get(self, request):
        categories = Category.objects.filter(is_active__in=[True]).all()
        serializer = CategorySerializer(categories, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
class BookListView(APIView):
    def get(self, request):
        books = Book.objects.filter(is_active__in=[True]).all()
        serializer = BookInfoSerializer(books, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
class BookListofCategoryView(APIView):
    def get(self, request, category_id):
        books = Book.objects.filter(category_id=category_id, is_active__in=[True])
        serializer = BookInfoSerializer(books, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

class SearchBookListView(APIView):
    def get(self, request, key):
        books = Book.objects.filter(Q(title__icontains=key), is_active__in=[True])
        serializer = BookInfoSerializer(books, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

class UpdateBookView(APIView):
    def put(self, request, book_id):
        try:
            book = Book.objects.get(book_id=book_id)
        except Book.DoesNotExist:
            return Response({'error': 'Book not found'}, status=status.HTTP_404_NOT_FOUND)
        serializer = UpdateBookSerializer(book, data=request.data, context={'request': request})
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class DeleteCategory(APIView):
    def delete(self, request, category_id):
        try:
            category = Category.objects.get(category_id=category_id)
        except Category.DoesNotExist:
            return Response({'error': 'Category not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = CategorySerializer()
        serializer.destroy(category)
        
        return Response({'message': 'Category soft deleted'}, status=status.HTTP_204_NO_CONTENT)

class DeleteAuthor(APIView):
    def delete(self, request, author_id):
        try:
            author = Author.objects.get(author_id=author_id)
        except Author.DoesNotExist:
            return Response({'error': 'Author not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = AuthorSerializer()
        serializer.destroy(author)
        
        return Response({'message': 'Author soft deleted'}, status=status.HTTP_204_NO_CONTENT)

class DeletePublisher(APIView):
    def delete(self, request, publisher_id):
        try:
            publisher = Publisher.objects.get(publisher_id=publisher_id)
        except Publisher.DoesNotExist:
            return Response({'error': 'Publisher not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = PublisherSerializer()
        serializer.destroy(publisher)
        
        return Response({'message': 'Publisher soft deleted'}, status=status.HTTP_204_NO_CONTENT)

class DeleteBook(APIView):
    def delete(self, request, book_id):
        try:
            book = Book.objects.get(book_id=book_id)
        except Book.DoesNotExist:
            return Response({'error': 'Book not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = BookSerializer()
        serializer.destroy(book)
        
        return Response({'message': 'Book soft deleted'}, status=status.HTTP_204_NO_CONTENT)

class BookDetailView(APIView):
    def get(self, request, book_id):
        book = Book.objects.filter(book_id=book_id, is_active__in=[True]).first()
        serializer = BookInfoSerializer(book)
        return Response(serializer.data, status=status.HTTP_200_OK)