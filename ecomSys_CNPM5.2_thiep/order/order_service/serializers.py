from rest_framework import serializers

from order_service.models import Order, OrderItem

class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = ['quantity', 'type', 'price', 'sale', 'product_id']

class OrderSerializer(serializers.ModelSerializer):
    order_items = OrderItemSerializer(many=True, read_only=True)

    class Meta:
        model = Order
        fields = ['user_id', 'date_ordered', 'total', 'status', 'is_cancel' 'order_items']

class OrderAddSerializer(serializers.ModelSerializer):
    order_items = OrderItemSerializer(many=True)

    class Meta:
        model = Order
        fields = ['id', 'user_id', 'order_items']

    def create(self, validated_data):
        order_items_data = validated_data.pop('order_items')
        total = 0

        # Tính tổng số tiền từ các order item
        for item_data in order_items_data:
            price = item_data['price']
            sale = item_data['sale']
            quantity = item_data['quantity']
            total += price * quantity - sale

        # Tạo đơn hàng với tổng số tiền đã tính
        order = Order.objects.create(total=total, **validated_data)

        # Tạo các order item và liên kết với đơn hàng
        order_items = []
        for item_data in order_items_data:
            order_item = OrderItem.objects.create(**item_data)
            order_items.append(order_item)
        # Thiết lập mối quan hệ ManyToMany
        order.order_items.add(*order_items)

        return order
