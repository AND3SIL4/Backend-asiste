from django.contrib.auth import get_user_model, authenticate
from rest_framework import serializers

# User serializer
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()
        fields = ['document', 'username', 'email', 'user_type', 'password']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):  # Corrected method signature
        return get_user_model().objects.create_user(**validated_data)

    def update(self, instance, validated_data):  # Corrected method signature
        password = validated_data.pop('password', None)
        user = super().update(instance, validated_data)

        if password:
            user.set_password(password)
            user.save()

        return user


class AuthTokenSerializers(serializers.Serializer):
    document = serializers.IntegerField()
    password = serializers.CharField(style={'input_type': 'password'})

    def validate(self, data):
        document = data.get('document')
        password = data.get('password')
        user = authenticate(
            request=self.context.get('request'),
            username=document,
            password=password,
        )

        if not user:
            raise serializers.ValidationError('No se pudo autenticar', code='authorization')

        data['user'] = user
        return data
