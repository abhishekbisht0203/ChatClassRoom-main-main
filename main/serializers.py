from rest_framework import serializers

class AddressSerializer(serializers.Serializer):
    address = serializers.CharField(max_length=255)
