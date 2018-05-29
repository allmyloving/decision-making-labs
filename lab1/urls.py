from django.urls import path

from . import views

urlpatterns = [
    path('criteria', views.get_criteria, name='criteria'),
]
