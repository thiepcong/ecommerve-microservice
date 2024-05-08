"""order URL Configuration

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

from order_service.views import AddOrderView, AllOrderView, CancelOrderView, ConfirmOrderView, OrderDetailView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/ecomSys/order/add/', AddOrderView.as_view()),
    path('api/ecomSys/order/all/', AllOrderView.as_view()),
    path('api/ecomSys/order/<str:user_id>/', OrderDetailView.as_view()),
    path('api/ecomSys/order/confirm/<str:order_id>/', ConfirmOrderView.as_view()),
    path('api/ecomSys/order/cancel/<str:order_id>/', CancelOrderView.as_view()),
]
