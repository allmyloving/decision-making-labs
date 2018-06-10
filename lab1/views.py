from django.shortcuts import render

from .models import Criterion, Lpr
# import the logging library
import logging

# Get an instance of a logger
logger = logging.getLogger(__name__)


def get_times(request, key):
    return next(request.POST[x] for x in request.POST if key[:3] + '_times' in x)


def process_form(request):
    models = []
    for key in request.POST:
        if '_sign' in key:
            models.append(CritToCritModel(key[0], key[2], request.POST[key], get_times(request, key)))
    return render(request, 'weight.html', {'models': models})


class CritToCritModel:
    def __init__(self, crit1, crit2, sign, times):
        self.crit1_id = crit1
        self.crit2_id = crit2
        self.sign = sign
        self.times = times


# 1 2 > 2
# 2 3 = 1

# 1 = z
# 2 = z/2
# 3 = z/2

# 2_3_times
# 1_2_times
# 2_4_sign
# 3_4_times
# 3_6_sign
# 1_6_times
# 3_4_sign
# 2_6_sign
# 4_6_sign

def get_criteria(request):
    if request.method == 'GET':
        return render(request, 'criteria.html',
                      {'select_criteria_model': SelectCriteriaModel(Lpr.objects.all(),
                                                                    Criterion.objects.all())})
    else:
        return process_form(request)


class LprModelItem:
    def __init__(self, lpr):
        self.id = lpr.id
        self.name = lpr.name


class SelectCriteriaModel:
    def __init__(self, lpr_list, criteria_list):
        self.lpr_list = [LprModelItem(c) for c in lpr_list]
        self.criteria_list = get_criteria_to_criteria(criteria_list, criteria_list.count())
        self.range = range(criteria_list.count())


class CriteriaPairModel:
    def __init__(self, crit1, crit2):
        self.crit1 = crit1
        self.crit2 = crit2


def get_criteria_to_criteria(criteria_list, count):
    result = []
    for i in range(count):
        for j in range(i + 1, count):
            result.append(CriteriaPairModel(criteria_list[i], criteria_list[j]))
    return result
