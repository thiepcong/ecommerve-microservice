"""products URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
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

from book_service.views import AddBookView, BookDetailView, BookListView, BookListofCategoryView, CategoryListView, CreateAuthorView, CreateCategoryView, CreatePublisherView, DeleteAuthor, DeleteBook, DeleteCategory, DeletePublisher, SearchBookListView, UpdateBookView
from mobile_service.views import AddMobileView, CreateProducerView, CreateTypeView, DeleteMobile, DeleteProducer, DeleteType, MobileDetailView, MobileListView, MobileListofProducerView, ProducerListView, SearchMobileListView, UpdateMobileView
from clothes_service.views import AddClothesView, ClothesDetailView, ClothesListView, ClothesListofStyleView, CreateStyleView, DeleteClothes, DeleteStyle, SearchClothesListView, StyleListView, UpdateClothesView
from clothes_service.views import CreateProducerView as ProducerClothesView
from clothes_service.views import DeleteProducer as DeleteProducerClothesView

urlpatterns = [
    path('admin/', admin.site.urls),
    #book_service_url
    path('api/ecomSys/book/category/add/', CreateCategoryView.as_view()),
    path('api/ecomSys/book/author/add/', CreateAuthorView.as_view()),
    path('api/ecomSys/book/publisher/add/', CreatePublisherView.as_view()),
    path('api/ecomSys/book/add/', AddBookView.as_view()),
    path('api/ecomSys/book/category/all/', CategoryListView.as_view()),
    path('api/ecomSys/book/all/', BookListView.as_view()),
    path('api/ecomSys/book/detail/<str:book_id>/', BookDetailView.as_view()),
    path('api/ecomSys/book/category/<str:category_id>/', BookListofCategoryView.as_view()),
    path('api/ecomSys/book/search/<str:key>/', SearchBookListView.as_view()),
    path('api/ecomSys/book/edit/<str:book_id>/', UpdateBookView.as_view()),
    path('api/ecomSys/book/delete/<str:book_id>/', DeleteBook.as_view()),
    path('api/ecomSys/book/category/delete/<str:category_id>/', DeleteCategory.as_view()),
    path('api/ecomSys/book/author/delete/<str:author_id>/', DeleteAuthor.as_view()),
    path('api/ecomSys/book/publisher/delete/<str:publisher_id>/', DeletePublisher.as_view()),
    #mobile_service_url
    path('api/ecomSys/mobile/producer/add/', CreateProducerView.as_view()),
    path('api/ecomSys/mobile/type/add/', CreateTypeView.as_view()),
    path('api/ecomSys/mobile/add/', AddMobileView.as_view()),
    path('api/ecomSys/mobile/producer/all/', ProducerListView.as_view()),
    path('api/ecomSys/mobile/all/', MobileListView.as_view()),
    path('api/ecomSys/mobile/detail/<str:mobile_id>/', MobileDetailView.as_view()),
    path('api/ecomSys/mobile/producer/<str:producer_id>/', MobileListofProducerView.as_view()),
    path('api/ecomSys/mobile/search/<str:key>/', SearchMobileListView.as_view()),
    path('api/ecomSys/mobile/edit/<str:mobile_id>/', UpdateMobileView.as_view()),
    path('api/ecomSys/mobile/delete/<str:mobile_id>/', DeleteMobile.as_view()),
    path('api/ecomSys/mobile/producer/delete/<str:producer_id>/', DeleteProducer.as_view()),
    path('api/ecomSys/mobile/type/delete/<str:type_id>/', DeleteType.as_view()),
    #clothes_service_url
    path('api/ecomSys/clothes/style/add/', CreateStyleView.as_view()),
    path('api/ecomSys/clothes/producer/add/', ProducerClothesView.as_view()),
    path('api/ecomSys/clothes/add/', AddClothesView.as_view()),
    path('api/ecomSys/clothes/style/all/', StyleListView.as_view()),
    path('api/ecomSys/clothes/all/', ClothesListView.as_view()),
    path('api/ecomSys/clothes/detail/<str:clothes_id>/', ClothesDetailView.as_view()),
    path('api/ecomSys/clothes/style/<str:style_id>/', ClothesListofStyleView.as_view()),
    path('api/ecomSys/clothes/search/<str:key>/', SearchClothesListView.as_view()),
    path('api/ecomSys/clothes/edit/<str:clothes_id>/', UpdateClothesView.as_view()),
    path('api/ecomSys/clothes/delete/<str:clothes_id>/', DeleteClothes.as_view()),
    path('api/ecomSys/clothes/style/delete/<str:style_id>/', DeleteStyle.as_view()),
    path('api/ecomSys/clothes/producer/delete/<str:producer_id>/', DeleteProducerClothesView.as_view()),
]
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
