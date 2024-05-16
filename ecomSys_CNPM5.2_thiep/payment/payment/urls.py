"""payment URL Configuration

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
from django.urls import path, include

from payment_service.views import PaymentMethodView, PaymentView, PaymentProcessAPIView, PaymentSuccessAPIView, PaymentCancelAPIView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/ecomSys/payment/payment-method', PaymentMethodView.as_view()),
    path('api/ecomSys/payment/payment-method/<int:id>', PaymentMethodView.as_view()),
    path('api/ecomSys/payment', PaymentView.as_view()),
    path('api/ecomSys/payment/<int:id>', PaymentView.as_view()),
    path('api/ecomSys/payment/process/', PaymentProcessAPIView.as_view(), name='payment_process'),
    path('api/ecomSys/payment/success/', PaymentSuccessAPIView.as_view(), name='payment_success'),
    path('api/ecomSys/payment/cancel/', PaymentCancelAPIView.as_view(), name='payment_cancel'),
    path('paypal/', include('paypal.standard.ipn.urls')),
]
