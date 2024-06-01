import re
from rest_framework import serializers

def validate_password(password):
    if len(password) < 8:
        raise serializers.ValidationError("Mật khẩu phải có ít nhất 8 ký tự.")
    if not re.findall('[a-z]', password):
        raise serializers.ValidationError("Mật khẩu phải có ít nhất một ký tự thường.")
    if not re.findall('[A-Z]', password):
        raise serializers.ValidationError("Mật khẩu phải có ít nhất một ký tự hoa.")
    if not re.findall('[0-9]', password):
        raise serializers.ValidationError("Mật khẩu phải có ít nhất một chữ số.")
    if not re.findall('[^a-zA-Z0-9]', password):
        raise serializers.ValidationError("Mật khẩu phải có ít nhất một ký tự đặc biệt.")
