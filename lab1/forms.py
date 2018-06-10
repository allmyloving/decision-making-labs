from django import forms


class CriteriaWeightForm(forms.Form):
    lpr_id = forms.CharField(label='lpr_id')
