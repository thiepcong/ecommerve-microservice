import requests
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Order
from .serializers import OrderAddSerializer

class OrderDetailView(APIView):
    def get(self, request, user_id):
        try:
            orders = Order.objects.filter(user_id=user_id)
            orders_data = []
            for order in orders:
                order_items_data = []
                for order_item in order.order_items.all():
                    product = self.get_product(order_item.type, order_item.product_id)
                    if product:
                        order_items_data.append({
                            'quantity': order_item.quantity,
                            'price': order_item.price,
                            'sale': order_item.sale,
                            'product': product
                        })
                orders_data.append({
                    'id': order.id,
                    'date_ordered': order.date_ordered,
                    'total': order.total,
                    'status': order.status,
                    'is_cancel': order.is_cancel,
                    'order_item': order_items_data
                })
            return Response(orders_data, status=status.HTTP_200_OK)
            
        except Order.DoesNotExist:
            return Response({'message': 'Orders not found.'}, status=status.HTTP_404_NOT_FOUND)
    
    def get_product(self, type, product_id):
        if type == 'book':
            product_url = "http://localhost:4002/api/ecomSys/book/detail/{}/".format(product_id)
        if type == 'mobile':
            product_url = "http://localhost:4002/api/ecomSys/mobile/detail/{}/".format(product_id)
        if type == 'clothes':
            product_url = "http://localhost:4002/api/ecomSys/clothes/detail/{}/".format(product_id)
        response = requests.get(product_url)

        if response.status_code == 200:
            return response.json()
        return None

class AddOrderView(APIView):
    def post(self, request):
        order_data = request.data.get('order', {})
        shipment_data = request.data.get('shipment', {})
        payment_data = request.data.get('payment', {})
        serializer = OrderAddSerializer(data=order_data)
        
        if serializer.is_valid():
            order = serializer.save()
            payment_data["order_id"] = order.id
            payment_data["total"] = order.total
            payment_data["status"] = order.status

            payment = self.add_payment(payment_data)
            if payment:
                payment_status = payment.get('status', None)
                # if payment_status:
                shipment_data['payment_status'] = payment_status
                shipment_data["order_id"] = order.id

                shipment = self.add_shipment(shipment_data)
                if shipment:
                    return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def add_payment(self, payment_data):
        payment_url = "http://localhost:4007/api/ecomSys/payment"
        response = requests.post(payment_url, json=payment_data)
        if response.status_code == 201:
            return response.json()
        return None
    def add_shipment(self, shipment_data):
        shipment_url = "http://localhost:4006/api/ecomSys/shipment"
        response = requests.post(shipment_url, json=shipment_data)
        if response.status_code == 201:
            return response.json()
        return None
    
class AllOrderView(APIView):
    def get(self, request):
        try:
            token_verification_url = "http://localhost:4001/api/ecomSys/manager/verify-token/"
            headers = {'Authorization': request.headers.get('Authorization')}
            response = requests.get(token_verification_url, headers=headers)
            
            if response.status_code != 200:
                return Response({'error': 'Invalid token.'}, status=status.HTTP_401_UNAUTHORIZED)
            orders = Order.objects.all()
            orders_data = []
            for order in orders:
                user = self.get_user(order.user_id)
                order_items_data = []
                if user:
                    for order_item in order.order_items.all():
                        product = self.get_product(order_item.type, order_item.product_id)
                        if product:
                            order_items_data.append({
                                'quantity': order_item.quantity,
                                'price': order_item.price,
                                'sale': order_item.sale,
                                'product': product
                            })
                    orders_data.append({
                        'user': user,
                        'date_ordered': order.date_ordered,
                        'total': order.total,
                        'status': order.status,
                        'is_cancel': order.is_cancel,
                        'order_item': order_items_data
                    })
            return Response(orders_data, status=status.HTTP_200_OK)

        except Order.DoesNotExist:
            return Response({'message': 'Orders not found.'}, status=status.HTTP_404_NOT_FOUND)
    
    def get_product(self, type, product_id):
        if type == 'book':
            product_url = "http://localhost:4002/api/ecomSys/book/detail/{}/".format(product_id)
        if type == 'mobile':
            product_url = "http://localhost:4002/api/ecomSys/mobile/detail/{}/".format(product_id)
        if type == 'clothes':
            product_url = "http://localhost:4002/api/ecomSys/clothes/detail/{}/".format(product_id)
        response = requests.get(product_url)

        if response.status_code == 200:
            return response.json()
        return None
    
    def get_user(self, user_id):
        user_url = "http://localhost:4001/api/ecomSys/user/info/{}".format(user_id)
        response = requests.get(user_url)
        if response.status_code == 200:
            return response.json()
        return None
        
class UpdatePaymentOrderView(APIView):
    def put(self, request, order_id, user_id, product_id):
        try:
            order = Order.objects.get(pk=order_id)
            order.status = True 
            user_url = "http://localhost:4004/api/ecomSys/cart/delete/{}/{}/".format(user_id, product_id)
            requests.delete(user_url)
            order.save()
            return Response({'message': 'Order status updated successfully.'}, status=status.HTTP_200_OK)
        except Order.DoesNotExist:
            return Response({'message': 'Order not found.'}, status=status.HTTP_404_NOT_FOUND)

class ConfirmOrderView(APIView):
    def put(self, request, order_id):
        try:
            order = Order.objects.get(pk=order_id)
            order.status = True 
            order.save()
            return Response({'message': 'Order status updated successfully.'}, status=status.HTTP_200_OK)
        except Order.DoesNotExist:
            return Response({'message': 'Order not found.'}, status=status.HTTP_404_NOT_FOUND)
    
        
class CancelOrderView(APIView):
    def put(self, request, order_id):
        try:
            order = Order.objects.get(pk=order_id)
            order.is_cancel = True 
            order.save()
            return Response({'message': 'Order status updated successfully.'}, status=status.HTTP_200_OK)
        except Order.DoesNotExist:
            return Response({'message': 'Order not found.'}, status=status.HTTP_404_NOT_FOUND)