class CritToCritModel:
    def __init__(self, crit1, crit2, sign, times):
        self.crit1_id = crit1
        self.crit2_id = crit2
        self.sign = sign
        self.times = times

    def __str__(self):
        return str(self.crit1_id) + " " + str(self.crit2_id) + " " + self.sign + " " + str(self.times)


def get_coeff(pair, other_coeff):
    if pair.sign == '=':
        return other_coeff
    elif pair.sign == '>':
        return other_coeff / pair.times
    elif pair.sign == '<':
        return other_coeff * pair.times


def get_coeff1(pair, other_coeff):
    if pair.sign == '=':
        return other_coeff
    elif pair.sign == '>':
        return other_coeff * pair.times
    elif pair.sign == '<':
        return other_coeff / pair.times


def get_criteria_weights(crit_to_crit_model, criteria_amount):
    crit_to_coef = {crit_to_crit_model[0].crit1_id: 1.0}

    processed_elem = 0
    while processed_elem < criteria_amount:
        for pair in crit_to_crit_model:
            if pair.crit1_id in crit_to_coef:
                crit_to_coef[pair.crit2_id] = get_coeff(pair, crit_to_coef[pair.crit1_id])
                processed_elem += 1
            elif pair.crit2_id in crit_to_coef:
                crit_to_coef[pair.crit1_id] = get_coeff1(pair, crit_to_coef[pair.crit2_id])
                processed_elem += 1
    total_coef = sum(crit_to_coef.values())
    coef = 1.0 / total_coef
    weights = {}
    for crit, num in crit_to_coef.items():
        weights[crit] = coef * num
    return weights
