from django.shortcuts import render, redirect

from lab1.lab3_algorithm import find_main_criteria
from .models import Criterion, Lpr, CriterionRange


def get_ranges(request):
    if request.method == 'GET':
        return render(request, 'lab3.html',
                      {'model': ConstructRangesModel(Lpr.objects.all(), Criterion.objects.all().order_by('id'))})
    else:
        return process_form(request)


def find_criteria(request):
    return render(request, 'main_criterion.html', {'main_criterion': find_main_criteria()})


def process_form(request):
    crit_id_to_range = {}
    for key in request.POST:
        if "_range" in key:
            if request.POST[key] in crit_id_to_range.values():
                raise Exception("All candidates should have different ranges!")
            crit_id_to_range[key.split("_range")[0]] = request.POST[key]
    save_to_db(request.POST['lpr_id'], crit_id_to_range)
    return redirect('lab3')


def save_to_db(lpr_id, crit_id_to_range):
    lpr = Lpr.objects.get(pk=lpr_id)
    if CriterionRange.objects.filter(lpr=lpr):
        print("removing outdated ranges...")
        [c.delete() for c in CriterionRange.objects.filter(lpr=lpr)]
    [CriterionRange.objects.create(criterion=Criterion.objects.get(pk=c),
                                   lpr=lpr,
                                   range=r) for c, r in crit_id_to_range.items()]


class ConstructRangesModel:
    def __init__(self, lprs, criteria):
        self.lpr_list = lprs
        self.criteria_list = criteria
        self.range = range(1, len(criteria) + 1)
        self.lpr_to_range_list = construct_lpr_to_range_list(lprs)


def construct_lpr_to_range_list(lprs):
    return [LprToRangeItem(lpr, CriterionRange.objects.filter(lpr=lpr).order_by('criterion__id')) for lpr in lprs]


class LprToRangeItem:
    def __init__(self, lpr, ranges):
        self.name = lpr.name
        self.range = [r.range for r in ranges]
