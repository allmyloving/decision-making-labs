from django.shortcuts import render

from lab1.decision_making import CritToCritModel
from lab1.decision_making import get_criteria_weights
from .models import Criterion, Lpr


def get_times(request, key):
    times = next(request.POST[x] for x in request.POST if key[:3] + '_times' in x)
    if times == '':
        times = 1
    return int(times)


class CriteriaToWeightModel:
    def __init__(self, crit_id, coef):
        self.criteria = Criterion.objects.get(pk=int(crit_id))
        self.coefficient = coef


def process_form(request):
    models = []
    for key in request.POST:
        if '_sign' in key:
            models.append(CritToCritModel(key[0], key[2], request.POST[key], get_times(request, key)))
    weights = get_criteria_weights(models, len(Criterion.objects.all()))
    return render(request, 'weight.html',
                  {'models': [CriteriaToWeightModel(k, v) for k, v in weights.items()]})


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
        self.criteria_list = get_criteria_to_criteria(criteria_list)
        self.range = range(criteria_list.count())


class CriteriaPairModel:
    def __init__(self, crit1, crit2):
        self.crit1 = crit1
        self.crit2 = crit2


def get_criteria_to_criteria(criteria_list):
    result = []
    count = criteria_list.count()
    for i in range(count - 1):
        result.append(CriteriaPairModel(criteria_list[i], criteria_list[i + 1]))
    result.append(CriteriaPairModel(criteria_list[count - 1], criteria_list[0]))
    return result
