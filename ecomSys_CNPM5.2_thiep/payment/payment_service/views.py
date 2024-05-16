from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from paypal.standard.forms import PayPalPaymentsForm
from django.urls import reverse
from django.shortcuts import render
from django.conf import settings
from payment_service.models import Payment, PaymentMethod
from payment_service.serializer import PaymentMethodSerializer, PaymentSerializer

class PaymentMethodView(APIView):
    def get(self, request):
        payment_all = PaymentMethod.objects.filter(is_active=True)
        serializer = PaymentMethodSerializer(payment_all, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
     
    def post(self, request):
        serializer = PaymentMethodSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
   
    def delete(self, request, id):
        try:
            payment_method = PaymentMethod.objects.get(pk=id)
        except PaymentMethod.DoesNotExist:
            return Response({'error': 'PaymentMethod not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = PaymentMethodSerializer()
        serializer.destroy(payment_method)
        return Response({'message': 'PaymentMethod soft deleted'}, status=status.HTTP_204_NO_CONTENT)

class PaymentView(APIView):
    def post(self, request):
        serializer = PaymentSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def put(self, request, id):
        try:
            payment = Payment.objects.get(pk=id)
        except Payment.DoesNotExist:
            return Response({'error': 'Payment not found'}, status=status.HTTP_404_NOT_FOUND)
        serializer = PaymentSerializer(payment ,data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class PaymentProcessAPIView(APIView):
    def post(self, request, *args, **kwargs):
        paypal_dict = {
            "business": settings.PAYPAL_RECEIVER_EMAIL,
            "amount": "5.00",
            "item_name": "Item Name",
            "invoice": "unique-invoice-id",
            "notify_url": request.build_absolute_uri(reverse('paypal-ipn')),
            "return": request.build_absolute_uri('/payment/success/'),
            "cancel_return": request.build_absolute_uri('/payment/cancel/'),
        }

        form = PayPalPaymentsForm(initial=paypal_dict)
        approval_url = form.render()
        return Response({'approval_url': approval_url}, status=status.HTTP_200_OK)

class PaymentSuccessAPIView(APIView):
    def get(self, request, *args, **kwargs):
        return Response({'message': 'Payment successful'}, status=status.HTTP_200_OK)

class PaymentCancelAPIView(APIView):
    def get(self, request, *args, **kwargs):
        return Response({'message': 'Payment cancelled'}, status=status.HTTP_200_OK)
    
def view_that_asks_for_money(request):

           # What you want the button to do.
           paypal_dict = {
               "business": "receiver_email@example.com",
               "amount": "10000000.00",
               "item_name": "name of the item",
               "invoice": "unique-invoice-id",
               "notify_url": request.build_absolute_uri(reverse('paypal-ipn')),
               "return": request.build_absolute_uri(reverse('your-return-view')),
               "cancel_return": request.build_absolute_uri(reverse('your-cancel-view')),
               "custom": "premium_plan",  # Custom command to correlate to some function later (optional)
           }

           # Create the instance.
           form = PayPalPaymentsForm(initial=paypal_dict)
           form_html = form.as_p() 
           
           redirect_url = form_html.split('action="')[1].split('" method=')[0]
           return Response({'redirect_url': redirect_url}, status=status.HTTP_200_OK)