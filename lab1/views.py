from django.http import HttpResponse

from lab1.models import Mark


def index(request):
    return HttpResponse("Hello, world. You're at index.")
