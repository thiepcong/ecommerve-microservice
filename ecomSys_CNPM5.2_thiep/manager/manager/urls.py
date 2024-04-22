"""
URL configuration for manager project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
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
from manager_service.views import LoginView, AddManagerView, ManagerInfoView, ChangePasswordView, UpdateProfileView, VerifyTokenView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/ecomSys/manager/add/', AddManagerView.as_view(), name='register'),
    path('api/ecomSys/manager/login/', LoginView.as_view(), name='login'),
    path('api/ecomSys/manager/info/', ManagerInfoView.as_view(), name='manager-detail'),
    path('api/ecomSys/manager/change/', ChangePasswordView.as_view(), name='change'),
    path('api/ecomSys/manager/update/', UpdateProfileView.as_view(), name='update'),
    path('api/ecomSys/manager/verify-token/', VerifyTokenView.as_view(), name='verify-token'),
]
