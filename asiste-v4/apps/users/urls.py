from django.urls import path
from apps.users import views

urlpatterns = [
    path('create/', views.CreateUserView.as_view()),
    path('token/', views.CreateTokenView.as_view()),
    path('user/', views.RetrieveUpdateUserView.as_view())
]
