from django.contrib import admin

from .models import Alternative, Result
from .models import Criterion
from .models import Lpr
from .models import Mark
from .models import Vector

admin.site.register(Alternative)
admin.site.register(Criterion)
admin.site.register(Mark)
admin.site.register(Vector)
admin.site.register(Lpr)
admin.site.register(Result)
