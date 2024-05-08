from rest_framework import serializers
from .models import Producer, Type, Mobile

class ProducerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Producer
        fields = ['producer_id' ,'name', 'des']
        
    def destroy(self, instance):
        instance.is_active = False
        instance.save()
        return instance

class TypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Type
        fields = ['type_id' ,'name', 'des']
        
    def destroy(self, instance):
        instance.is_active = False
        instance.save()
        return instance

class MobileSerializer(serializers.ModelSerializer):
    producer_id = serializers.CharField(write_only=True)
    type_id = serializers.CharField(write_only=True)

    class Meta:
        model = Mobile
        fields = ['mobile_id', 'title', 'image', 'price', 'sale', 'quantity', 'color', 'size', 'memory', 'ram', 'cpu', 'pin', 'des', 'producer_id', 'type_id']
    
    def create(self, validated_data):
        producer_id = validated_data.pop('producer_id', None)
        type_id = validated_data.pop('type_id', None)
        image = validated_data.pop('image', None)
        request = self.context.get('request')

        if producer_id:
            producer_instance = Producer.objects.filter(is_active__in=[True], producer_id=producer_id).first()
            if producer_instance:
                validated_data['producer'] = producer_instance
            else:
                raise serializers.ValidationError('Producer does not exits')
        print(type_id)
        if type_id:
            type_instance = Type.objects.filter(is_active__in=[True], type_id=type_id).first()
            if type_instance:
                validated_data['type'] = type_instance
            else:
                raise serializers.ValidationError('Type does not exits')
        return Mobile.objects.create(image=request.FILES.get('image'), **validated_data)
    
    def destroy(self, instance):
        instance.is_active = False
        instance.save()
        return instance
    

class MobileInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Mobile
        fields = ['mobile_id', 'title', 'image', 'price', 'sale', 'quantity', 'color', 'size', 'memory', 'ram', 'cpu', 'pin', 'des', 'producer', 'type']

class UpdateMobileSerializer(serializers.ModelSerializer):
    producer_id = serializers.CharField(write_only=True)

    class Meta:
        model = Mobile
        fields = ['image', 'price', 'sale', 'quantity', 'des', 'producer_id']

    def update(self, instance, validated_data):
        request = self.context.get('request')

        instance.image = request.FILES.get('image')
        instance.price = validated_data.get('price')
        instance.sale = validated_data.get('sale')
        instance.quantity = validated_data.get('quantity')
        producer_id = validated_data.pop('producer_id')
        producer_instance = Producer.objects.filter(is_active__in=[True], producer_id=producer_id).first()
        if producer_instance:
            instance.producer = producer_instance
        else:
            raise serializers.ValidationError('Producer does not exist')
        instance.des = validated_data.get('des')

        instance.save()
        return instance
