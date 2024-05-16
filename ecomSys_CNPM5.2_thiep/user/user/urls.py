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

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/ecomSys/user/register/', RegisterView.as_view()),
    path('api/ecomSys/user/login/', LoginView.as_view()),
    path('api/ecomSys/user/info/<str:user_id>', UserDetailView.as_view()),
    path('api/ecomSys/user/change/<str:user_id>', ChangePasswordView.as_view()),
    path('api/ecomSys/user/update/<str:user_id>', ChangeProfileView.as_view()),
]
