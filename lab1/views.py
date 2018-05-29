from django.shortcuts import render

from .models import Criterion

from .models import Mark

from .models import CriteriaType


def get_criteria(request):
    return render(request, 'criteria.html',
                  {'criteria_list': SelectCriteriaModel(Criterion.objects.all()).criteria_list})


def select_criterion(request):
    return ''


class SelectCriteriaModelItem:
    def __init__(self, criterion):
        self.criterion = criterion
        self.mark_list = [MarkModel(m, criterion) for m in Mark.objects.filter(crit_id=criterion.id)]


class MarkModel:
    def __init__(self, mark, criterion):
        self.id = mark.id
        self.label = mark.num_equiv if criterion.type == CriteriaType.QT.name else mark.name


class SelectCriteriaModel:
    def __init__(self, criteria_list):
        self.criteria_list = [SelectCriteriaModelItem(c) for c in criteria_list]
