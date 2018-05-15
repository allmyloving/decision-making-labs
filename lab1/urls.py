from django.urls import path

from lab1 import admin
from . import views

urlpatterns = [
    path('', views.index, name='index'),
]