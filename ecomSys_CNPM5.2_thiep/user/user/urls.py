"""user URL Configuration

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

from user_service.views import LoginView, RegisterView, UserInfoView, ChangePasswordView, UpdateProfileView, VerifyTokenView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/ecomSys/user/register/', RegisterView.as_view(), name='register'),
    path('api/ecomSys/user/login/', LoginView.as_view(), name='login'),
    path('api/ecomSys/user/info/', UserInfoView.as_view(), name='user-detail'),
    path('api/ecomSys/user/change/', ChangePasswordView.as_view(), name='change'),
    path('api/ecomSys/user/update/', UpdateProfileView.as_view(), name='update'),
     path('api/ecomSys/user/verify-token/', VerifyTokenView.as_view(), name='verify-token'),
]
