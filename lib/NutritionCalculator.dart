import 'package:musclecalc/Macronutrients.dart';

import 'Gender.dart';
import 'PhysicalActivityLevel.dart';

class NutritionCalculator {
  double _weightCoefficientForMale = 13.397;
  double _tallCoefficientForMale = 4.799;
  double _ageCoefficientForMale = 5.677;
  double _fixedConstantForMale = 88.362;

  double _tdeeWeightCoefficientForFemale = 9.247;
  double _tallCoefficientForFemale = 3.098;
  double _ageCoefficientForFemale = 4.33;
  double _fixedConstantForFemale = 447.593;

  double _sedentaryCoefficient = 1.2;
  double _lightlyActiveCoefficient = 1.375;
  double _moderatelyActiveCoefficient = 1.55;
  double _veryActiveCoefficient = 1.725;
  double _extraActiveCoefficient = 1.9;

  double calcBmr(final Gender gender, final int age, final double tall, final double weight) {
    double weightCoefficient;
    double tallCoefficient;
    double ageCoefficient;
    double fixedConstant;

    switch (gender) {
      case Gender.Male:
        weightCoefficient = _weightCoefficientForMale;
        tallCoefficient = _tallCoefficientForMale;
        ageCoefficient = _ageCoefficientForMale;
        fixedConstant = _fixedConstantForMale;
        break;
      case Gender.Female:
        weightCoefficient = _tdeeWeightCoefficientForFemale;
        tallCoefficient = _tallCoefficientForFemale;
        ageCoefficient = _ageCoefficientForFemale;
        fixedConstant = _fixedConstantForFemale;
        break;
    }

    return weightCoefficient * weight + tallCoefficient * tall - ageCoefficient * age + fixedConstant;
  }

  double calcTdee(final Gender gender, final int age, final double tall, final double weight, final PhysicalActivityLevel physicalActivityLevel) {
    double activeLevelCoefficient;

    switch (physicalActivityLevel) {
      case PhysicalActivityLevel.Sedentary:
        activeLevelCoefficient = _sedentaryCoefficient;
        break;
      case PhysicalActivityLevel.LightlyActive:
        activeLevelCoefficient = _lightlyActiveCoefficient;
        break;
      case PhysicalActivityLevel.ModeratelyActive:
        activeLevelCoefficient = _moderatelyActiveCoefficient;
        break;
      case PhysicalActivityLevel.VeryActive:
        activeLevelCoefficient = _veryActiveCoefficient;
        break;
      case PhysicalActivityLevel.ExtraActive:
        activeLevelCoefficient = _extraActiveCoefficient;
        break;
    }

    final bmr = calcBmr(gender, age, tall, weight);
    return bmr * activeLevelCoefficient;
  }

  double calcLimitationDayCalorie(final double tdee, final double weight, final double loseWeightRatePerWeek) {
    return tdee - ((7000 * weight * loseWeightRatePerWeek) / 5);
  }

  Macronutrients calcMacronutrients(final double calorieIntake, final double weight, final double proteinPerWight, final double fatPerWeight) {
    final protein = weight * proteinPerWight;
    final fat = weight * fatPerWeight;
    final carbohydrate = (calorieIntake - protein * 4 - fat * 9) / 4;

    return Macronutrients(protein, fat, carbohydrate);
  }
}
