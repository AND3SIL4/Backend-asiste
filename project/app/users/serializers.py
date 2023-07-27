from django.contrib.auth import get_user_model, authenticate
from rest_framework import serializers 

class UserSerializers(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()
        fields = [
            'document',
            'name', 
            'role',
        ]
        extra_kwargs = {
            'password': {'write_<PASSWORD>': True} # make password field write only for security
        }
    def create(self, validate_data):
        return get_user_model().objects.create_user(**validate_data)
    
    def update(self, instance, validate_data):
        password = validate_data.pop('password', None)
        user = super().update(instance, validate_data)

        if password:
            user.set_password(password)
            user.save()
            
        return user
    
class AuthTokenSerializer(serializers.Serializer):
    document = serializers.IntegerField()
    password = serializers.CharField(style={'input_type':'password'})

    def validate(self, data):
        document = data.get('document')
        password = data.get('password')
        user = authenticate(
            request=self.context.get('request'),
            username=document,
            password=password
        )
        
        if not user:
            raise serializers.ValidationError('No se pudo autenticar', code='authorization')
        data['user'] = user
        return data 