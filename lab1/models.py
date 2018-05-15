from django.db import models


class Alternative(models.Model):
    id = models.BigAutoField(primary_key=True)
    description = models.CharField(max_length=100)

    class Meta:
        db_table = 'alternative'

    def __str__(self):
        return self.description


OPTIMALITY_TYPE = ('max', 'Max'), ('min', 'Min')
TYPE = ('quantitative', 'Quantitative'), ('qualitative', 'Qualitative')


class Criterion(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=50)
    range = models.PositiveIntegerField()
    weight = models.PositiveIntegerField()
    type = models.CharField(max_length=12, choices=TYPE)
    optimality_type = models.CharField(db_column='optimalityType', max_length=12,
                                       choices=OPTIMALITY_TYPE)  # Field name made lowercase.
    unit_of_measurement = models.CharField(db_column='unitOfMeasurement', max_length=20)  # Field name made lowercase.

    class Meta:
        db_table = 'criterion'

    def __str__(self):
        return self.name + ', type: ' + self.type \
               + ', optimality: ' + self.optimality_type \
               + ', unit of measurement: ' + self.unit_of_measurement


class Lpr(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=50)
    range = models.IntegerField()

    class Meta:
        db_table = 'lpr'


class Mark(models.Model):
    id = models.BigAutoField(primary_key=True)
    crit = models.ForeignKey(Criterion, models.DO_NOTHING)
    name = models.CharField(max_length=50)
    range = models.FloatField()
    num_equiv = models.DecimalField(max_digits=10, decimal_places=2)
    norm_mark = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        db_table = 'mark'

    def __str__(self):
        return self.name + ', criteria name: ' + self.crit.name


class Result(models.Model):
    id = models.BigAutoField(primary_key=True)
    lpr = models.ForeignKey(Lpr, models.DO_NOTHING)
    alt = models.ForeignKey(Alternative, models.DO_NOTHING)
    range = models.PositiveIntegerField()
    alt_weight = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        db_table = 'result'


class Vector(models.Model):
    id = models.BigAutoField(primary_key=True)
    alt = models.ForeignKey(Alternative, models.DO_NOTHING)
    mark = models.ForeignKey(Mark, models.DO_NOTHING)

    class Meta:
        db_table = 'vector'

    def __str__(self):
        return 'Alternative: ' + self.alt.description \
               + ', criteria: ' + self.mark.crit.name \
               + ', mark: ' + self.mark.name
