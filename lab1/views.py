from django.shortcuts import render

from lab1.decision_making import CritToCritModel
from lab1.decision_making import get_criteria_weights
from lab1.electre import compute_agreement_matrix, get_crit_weight, compute_disagreement_matrix, find_best_alternative
from .models import Criterion, Lpr, LprMark, Vector, Alternative


def get_times(request, key):
    times = next(request.POST[x] for x in request.POST if key[:3] + '_times' in x)
    if times == '':
        times = 1
    return int(times)


class CriterionToWeightModel:
    def __init__(self, crit_id, coef):
        self.criteria = Criterion.objects.get(pk=int(crit_id))
        self.coefficient = coef


def save_results(lpr_id, weights):
    lpr = Lpr.objects.get(pk=lpr_id)
    for crit_id, coef in weights.items():
        LprMark.objects.create(lpr=lpr, criterion=Criterion.objects.get(pk=crit_id), weight=coef)


def process_form(request):
    models = []
    for key in request.POST:
        if '_sign' in key:
            models.append(CritToCritModel(key[0], key[2], request.POST[key], get_times(request, key)))
    weights = get_criteria_weights(models, len(Criterion.objects.all()))
    save_results(request.POST['lpr_id'], weights)
    return render(request, 'weight.html',
                  {'models': [CriterionToWeightModel(k, v) for k, v in weights.items()]})


def get_criteria(request):
    if request.method == 'GET':
        return render(request, 'criteria.html',
                      {'select_criteria_model': SelectCriteriaModel(Lpr.objects.all(),
                                                                    Criterion.objects.all())})
    else:
        return process_form(request)


def get_agreement_indices(request):
    agr_matrix = compute_agreement_matrix()
    disagr_matrix = compute_disagreement_matrix()
    return render(request, 'electre_indexes.html', {'indexes': agr_matrix,
                                                    'dis_indexes': disagr_matrix,
                                                    'best_alternatives': find_best_alternative(agr_matrix, disagr_matrix),
                                                    'vector': VectorViewItem()})


class CriteriaToWeightModel:
    def __init__(self, crit):
        self.name = crit.name
        self.weight = get_crit_weight(crit.id)


class AlternativeToMarkModel:
    def __init__(self, alternative):
        self.alt = alternative
        self.marks = [v.mark.norm_mark for v in Vector.objects.filter(alt_id=alternative.id).order_by('mark__crit__id')]


class VectorViewItem:
    def __init__(self):
        self.criteria_list = [CriteriaToWeightModel(crit) for crit in Criterion.objects.order_by('id')]
        self.alternatives = [AlternativeToMarkModel(alt) for alt in Alternative.objects.all()]


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
