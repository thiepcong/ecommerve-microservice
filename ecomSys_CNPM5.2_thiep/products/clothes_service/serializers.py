from rest_framework import serializers

from clothes_service.models import Producer, Style, Clothes

class StyleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Style
        fields = ['style_id' ,'name', 'des']
        
    def destroy(self, instance):
        instance.is_active = False
        instance.save()
        return instance

class ProducerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Producer
        fields = ['producer_id' ,'name', 'des']
        
    def destroy(self, instance):
        instance.is_active = False
        instance.save()
        return instance
    
class ClothesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Clothes
        fields = ['clothes_id', 'title', 'image', 'price', 'sale', 'quantity', 'color', 'des', 'style', 'producer']

    def create(self, validated_data):
        style = validated_data.pop('style', None)
        producer = validated_data.pop('producer', None)
        image = validated_data.pop('image', None)
        request = self.context.get('request')

        style_id = style.style_id
        style_instance = Style.objects.filter(is_active__in=[True], style_id=style_id).first()
        if style_instance:
            validated_data['style'] = style_instance
        else:
            raise serializers.ValidationError('Style does not exist')
        
        producer_id = producer.producer_id
        producer_instance = Producer.objects.filter(is_active__in=[True], producer_id=producer_id).first()
        if producer_instance:
            validated_data['producer'] =  producer_instance
        else:
            raise serializers.ValidationError('Producer does not exist')
        
        return Clothes.objects.create(image=request.FILES.get('image'), **validated_data)
    
    def destroy(self, instance):
        instance.is_active = False
        instance.save()
        return instance

class UpdateClothesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Clothes
        fields = ['image', 'price', 'sale', 'quantity', 'color', 'des', 'style', 'producer']
    
    def update(self, instance, validated_data):
        request = self.context.get('request')

        instance.image = request.FILES.get('image')
        instance.price = validated_data.get('price')
        instance.sale = validated_data.get('sale')
        instance.quantity = validated_data.get('quantity')
        instance.des = validated_data.get('des')

        style = validated_data.pop('style', None)
        producer = validated_data.pop('producer', None)

        style_id = style.style_id
        style_instance = Style.objects.filter(is_active__in=[True], style_id=style_id).first()
        if style_instance:
            instance.style = style_instance
        else:
            raise serializers.ValidationError('Style does not exist')
        
        producer_id = producer.producer_id
        producer_instance = Producer.objects.filter(is_active__in=[True], producer_id=producer_id).first()
        if producer_instance:
            instance.producer = producer_instance
        else:
            raise serializers.ValidationError('Producer does not exist')
        
        instance.save()
        return instance
