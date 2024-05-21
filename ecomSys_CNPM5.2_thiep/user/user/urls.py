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

from user_info.views import ChangePasswordView, ChangeProfileView
from user_login.views import RegisterView, LoginView
from user_model.views import UserDetailView
from manager_service.views import ManagerLoginView, AddManagerView, ManagerInfoView, ChangePasswordManagerView, UpdateProfileManagerView, VerifyTokenView

urlpatterns = [
    path('admin/', admin.site.urls),
    #user
    path('api/ecomSys/user/register/', RegisterView.as_view()),
    path('api/ecomSys/user/login/', LoginView.as_view()),
    path('api/ecomSys/user/info/<str:user_id>', UserDetailView.as_view()),
    path('api/ecomSys/user/change/<str:user_id>', ChangePasswordView.as_view()),
    path('api/ecomSys/user/update/<str:user_id>', ChangeProfileView.as_view()),
    #manager
    path('api/ecomSys/manager/add/', AddManagerView.as_view(), name='register'),
    path('api/ecomSys/manager/login/', ManagerLoginView.as_view(), name='login'),
    path('api/ecomSys/manager/info/', ManagerInfoView.as_view(), name='manager-detail'),
    path('api/ecomSys/manager/change/', ChangePasswordManagerView.as_view(), name='change'),
    path('api/ecomSys/manager/update/', UpdateProfileManagerView.as_view(), name='update'),
    path('api/ecomSys/manager/verify-token/', VerifyTokenView.as_view(), name='verify-token'),
]
