"""books URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

from book_service.views import CreateCategoryView, AddBookView, CategoryListView, BookListView, BookListofCategoryView, SearchBookListView, UpdateBookView, DeleteBook, DeleteCategory, BookDetailView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/ecomSys/category/add/', CreateCategoryView.as_view()),
    path('api/ecomSys/book/add/', AddBookView.as_view()),
    path('api/ecomSys/category/all/', CategoryListView.as_view()),
    path('api/ecomSys/book/all/', BookListView.as_view()),
    path('api/ecomSys/book/detail/<str:book_id>/', BookDetailView.as_view()),
    path('api/ecomSys/book/category/<str:category_id>/', BookListofCategoryView.as_view()),
    path('api/ecomSys/book/search/<str:key>/', SearchBookListView.as_view()),
    path('api/ecomSys/book/edit/<str:book_id>/', UpdateBookView.as_view()),
    path('api/ecomSys/book/delete/<str:book_id>/', DeleteBook.as_view()),
    path('api/ecomSys/category/delete/<str:category_id>/', DeleteCategory.as_view()),
]
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)