from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from django.contrib.auth.hashers import make_password, check_password
from user_model.models import User, Account
from user_model.serializers import FullNameSerializer, AddressSerializer, AccountSerializer, UserSerializer

class RegisterView(APIView):
    def post(self, request):
        data = request.data
        full_name_serializer = FullNameSerializer(data=data['full_name'])
        account_serializer = AccountSerializer(data=data['account'])
        address_serializer = AddressSerializer(data=data['address'])
        
        full_name_is_valid = full_name_serializer.is_valid()
        account_is_valid = account_serializer.is_valid()
        address_is_valid = address_serializer.is_valid()
        
        if full_name_is_valid and account_is_valid and address_is_valid:
            full_name = full_name_serializer.save()
            account_data = account_serializer.validated_data
            account = Account.objects.create(
                email=account_data['email'],
                password=make_password(account_data['password'])
            )
            address = address_serializer.save()
            
            user = User.objects.create(
                id=data['id'],
                mobile=data['mobile'],
                dob=data['dob'],
                position=data['position'],
                address=address,
                account=account,
                full_name=full_name
            )
            
            return Response(UserSerializer(user).data, status=status.HTTP_201_CREATED)
        
        return Response({
            'full_name_errors': full_name_serializer.errors if not full_name_is_valid else {},
            'account_errors': account_serializer.errors if not account_is_valid else {},
            'address_errors': address_serializer.errors if not address_is_valid else {},
        }, status=status.HTTP_400_BAD_REQUEST)

class LoginView(APIView):
    def post(self, request):
        data = request.data
        try:
            account = Account.objects.get(email=data['email'])
            if check_password(data['password'], account.password):
                user = User.objects.get(account=account)
                return Response(UserSerializer(user).data, status=status.HTTP_200_OK)
            return Response({'error': 'Invalid password'}, status=status.HTTP_400_BAD_REQUEST)
        except Account.DoesNotExist:
            return Response({'error': 'Account does not exist'}, status=status.HTTP_404_NOT_FOUND)
