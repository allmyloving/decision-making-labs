from django.db.models import Sum

from lab1.models import Alternative, Criterion, Vector, LprMark


def compute_agreement_matrix():
    alternatives = Alternative.objects.all()
    result = []
    for alt in alternatives:
        index_rows = []
        for alt2 in alternatives:
            if alt.id != alt2.id:
                index_rows.append(AgreementIndexRowRelation(alt2, compute_agreement_index(alt, alt2)))
        result.append(AgreementIndexRow(alt, index_rows))
        result.sort(key=lambda x: x.alt.id)
    return result


def compute_disagreement_matrix():
    alternatives = Alternative.objects.all()
    result = []
    for alt in alternatives:
        index_rows = []
        for alt2 in alternatives:
            if alt.id != alt2.id:
                index_rows.append(AgreementIndexRowRelation(alt2, compute_disagreement_index(alt, alt2)))
        result.append(AgreementIndexRow(alt, index_rows))
        result.sort(key=lambda x: x.alt.id)
    return result


def get_crit_weight(crit_id):
    lpr_marks = LprMark.objects.filter(criterion_id=crit_id)
    aggregate = lpr_marks.aggregate(Sum('weight'))
    return next(iter(aggregate.values())) / len(lpr_marks)


def compute_agreement_index(alt, alt2):
    alt1_vectors = Vector.objects.filter(alt_id=alt.id)
    alt2_vectors = Vector.objects.filter(alt_id=alt2.id)
    if len(alt1_vectors) != len(alt2_vectors):
        raise Exception('Different amount of vectors for alternatives: ' + str(alt.id) + ' and ' + str(alt2.id))
    total_criteria = sum([get_crit_weight(id) for id in Criterion.objects.values_list('id')])
    gt_criteria_weight = 0
    for vector1 in alt1_vectors:
        vector2 = next(v for v in alt2_vectors if v.mark.crit_id == vector1.mark.crit_id)
        if vector1.mark.norm_mark >= vector2.mark.norm_mark:
            gt_criteria_weight += get_crit_weight(vector1.mark.crit_id)
    return gt_criteria_weight / total_criteria


def compute_disagreement_index(alt, alt2):
    alt1_vectors = Vector.objects.filter(alt_id=alt.id)
    alt2_vectors = Vector.objects.filter(alt_id=alt2.id)
    if len(alt1_vectors) != len(alt2_vectors):
        raise Exception('Different amount of vectors for alternatives: ' + str(alt.id) + ' and ' + str(alt2.id))
    diff = 0
    for vector1 in alt1_vectors:
        vector2 = next(v for v in alt2_vectors if v.mark.crit_id == vector1.mark.crit_id)
        diff_temp = vector2.mark.norm_mark - vector1.mark.norm_mark
        if diff_temp > diff:
            diff = diff_temp
    return diff


class AgreementIndexRowRelation:
    def __init__(self, alt, index):
        self.alt = alt
        self.index = round(index, 2)


# relations is {'alt_id': 'index'}
class AgreementIndexRow:
    def __init__(self, alt, relations):
        self.alt = alt
        self.relations = relations
        self.min = min([x.index for x in relations])
        self.max = max([x.index for x in relations])


def get_same_elements(agree_elem, disagree_elem):
    return [x for x in agree_elem if x in disagree_elem]


def find_best_alternative(agreement_matrix, disagreement_matrix):
    # in agreement matrix all should be > C
    c = 0.5
    # in disagreement matrix all should be < D
    d = 0.5

    result = []
    while True:
        agree_elem = []
        print('c=' + str(c) + ';d=' + str(d))
        for row in agreement_matrix:
            if are_all_relations_gt(row, c):
                agree_elem.append(row.alt)
        print('agree=' + str(agree_elem))
        disagree_elem = []
        for row in disagreement_matrix:
            if are_all_relations_lt(row, d):
                disagree_elem.append(row.alt)
        print('disagree=' + str(disagree_elem))
        result = get_same_elements(agree_elem, disagree_elem)
        if result:
            break
        if not agree_elem or not disagree_elem:
            if not agree_elem:
                c -= 0.1
            if not disagree_elem:
                d += 0.1
        else:
            if not result:
                c -= 0.1
                d += 0.1

    return result


def are_all_relations_gt(row, coef):
    for rel in row.relations:
        if rel.index < coef:
            return False
    return True


def are_all_relations_lt(row, coef):
    for rel in row.relations:
        if rel.index > coef:
            return False
    return True
