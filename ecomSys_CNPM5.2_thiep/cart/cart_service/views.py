import requests
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import CartItem
from .serializers import CartItemSerializer, UpdateCartItemSerializer

class AddToCartView(APIView):
    def post(self, request):
        user_id = request.data.get('user_id')
        product_id = request.data.get('product_id')
        cart_item = CartItem.objects.filter(is_active=True, user_id=user_id, product_id=product_id).first()
        if cart_item:
            serializer = UpdateCartItemSerializer(instance=cart_item, data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        else:
            serializer = CartItemSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CartView(APIView):
    def post(self, request):
            user_id = request.data.get('user_id')
            cart_items = CartItem.objects.filter(is_active=True, user_id=user_id)
            cart_total = 0
            cart_item_data = []
        
            for cart_item in cart_items:
                product = self.get_product(cart_item.type, cart_item.product_id)
                if product:
                    cart_item_data.append({
                        'quantity': cart_item.quantity,
                        'product': product,
                        'total': cart_item.quantity * product.get('price', 0) * (100-product.get('sale', 0))/100
                    })
                    cart_total += cart_item.quantity * product.get('price', 0 ) * (100-product.get('sale', 0))/100
            response_data = {
                'cart_items': cart_item_data,
                'cart_total': cart_total
            }
            return Response(response_data, status=status.HTTP_200_OK)
    

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

class DeleteCartItemView(APIView):
    def delete(self, request, user_id, product_id):
        try:
            cart_item = CartItem.objects.get(user_id=user_id, product_id=product_id, is_active=True)
        except CartItem.DoesNotExist:
            return Response({'error': 'CartItem not found'}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = CartItemSerializer()
        serializer.destroy(cart_item)
        return Response({'message': 'CartItem soft deleted'}, status=status.HTTP_204_NO_CONTENT)


