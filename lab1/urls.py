from django.urls import path

from . import views

urlpatterns = [
    path('criteria', views.get_criteria, name='criteria'),
    path('indexes', views.get_agreement_indices, name='indexes'),
]
