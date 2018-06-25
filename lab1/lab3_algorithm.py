from django.db import connection

from lab1.models import Criterion, CriterionRange, Lpr


def find_main_criteria():
    total_voters = get_total_voters()
    min_votes = int(total_voters / 2 + 1)
    print("min votes to win: " + str(min_votes))
    lpr_ranges = get_lpr_with_ranges()
    criteria_to_votes = get_initial_votes(lpr_ranges)
    print('Crit with max val: ' + str(criteria_to_votes[0]))
    print('Crit with second max val: ' + str(criteria_to_votes[1]))
    crit1 = 0
    crit2 = 0
    index2 = 0
    while crit1 < min_votes and crit2 < min_votes:
        index2 += 1
        crit1 = 0
        crit2 = 0
        for item in lpr_ranges:
            range1 = next(r for c, r in item.ranges.items() if c == criteria_to_votes[0][0])
            range2 = next(r for c, r in item.ranges.items() if c == criteria_to_votes[index2][0])
            print(item.lpr.name + ' ' + str(range1) + ' ' + str(range2))
            if range1 < range2:
                crit1 += 1
            else:
                crit2 += 1
        print(criteria_to_votes[0][0].name + ' ' + str(crit1))
        print(criteria_to_votes[index2][0].name + ' ' + str(crit2))
    if crit1 > crit2:
        return criteria_to_votes[0][0]
    else:
        return criteria_to_votes[index2][0]


def get_lpr_with_ranges():
    return [LprRange(l) for l in Lpr.objects.all() if len(CriterionRange.objects.filter(lpr=l)) > 0]


def get_initial_votes(lpr_ranges):
    criteria_to_votes = create_empty_crit_to_votes()
    for item in lpr_ranges:
        first_item = next(crit for crit, range in item.ranges.items() if range == 1)
        criteria_to_votes[first_item] += 1
    return sorted(criteria_to_votes.items(), key=lambda kv: kv[1], reverse=True)


def create_empty_crit_to_votes():
    return {c: 0 for c in Criterion.objects.all()}


class LprRange:
    def __init__(self, lpr):
        self.lpr = lpr
        ranges = {}
        for item in CriterionRange.objects.filter(lpr=lpr):
            ranges[item.criterion] = item.range
        self.ranges = ranges


def get_total_voters():
    return list(next(query_to_dicts('SELECT COUNT(DISTINCT(lpr_id)) FROM crit_range')).values())[0]


def query_to_dicts(query_string, *query_args):
    cursor = connection.cursor()
    cursor.execute(query_string, query_args)
    col_names = [desc[0] for desc in cursor.description]
    while True:
        row = cursor.fetchone()
        if row is None:
            break
        row_dict = dict(zip(col_names, row))
        yield row_dict
    return
