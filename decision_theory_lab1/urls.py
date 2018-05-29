from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('lab1/', include('lab1.urls')),
    path('admin/', admin.site.urls),
]

admin.site.site_header = "Decision Theory Labs"
admin.site.site_title = "Decision Theory Labs"
admin.site.index_title = "Decision Theory Labs"
