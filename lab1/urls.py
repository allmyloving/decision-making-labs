from django.urls import path

from . import views
from . import views_lab3

urlpatterns = [
    path('lab2', views.get_criteria, name='lab2'),
    path('indexes', views.get_agreement_indices, name='indexes'),
    path('weights', views.get_weights, name='weights'),
    path('lab3', views_lab3.get_ranges, name='lab3'),
    path('find_criteria', views_lab3.find_criteria, name='find_criteria'),
]
