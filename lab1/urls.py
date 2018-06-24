from django.urls import path

from . import views

urlpatterns = [
    path('lab2', views.get_criteria, name='lab2'),
    path('indexes', views.get_agreement_indices, name='indexes'),
    path('weights', views.get_weights, name='weights'),
]
