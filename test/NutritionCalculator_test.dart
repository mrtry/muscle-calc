import 'package:musclecalc/Gender.dart';
import 'package:musclecalc/NutritionCalculator.dart';
import 'package:musclecalc/PhysicalActivityLevel.dart';
import "package:test/test.dart";

void main() {
  test('NutritionCalculator.calcBmr()', () {
    var answer = NutritionCalculator().calcBmr(Gender.Male, 27, 176, 65);
    expect(answer.ceil(), 1651);
  });

  test('NutritionCalculator.calcTdee()', () {
    var answer = NutritionCalculator().calcTdee(Gender.Male, 27, 176, 65, PhysicalActivityLevel.LightlyActive);
    expect(answer.ceil(), 2270);
  });

  test('NutritionCalculator.calcLimitationDayCalorie()', () {
    var tdee = NutritionCalculator().calcTdee(Gender.Male, 27, 176, 65, PhysicalActivityLevel.LightlyActive);
    var answer = NutritionCalculator().calcLimitationDayCalorie(tdee, 65, 0.01);
    expect(answer.ceil(), 1360);
  });

  test('NutritionCalculator.calcMacronutrients()', () {
    var tdee = NutritionCalculator().calcTdee(Gender.Male, 27, 176, 65, PhysicalActivityLevel.LightlyActive);
    var answer = NutritionCalculator().calcMacronutrients(tdee, 65, 2.0, 0.6);
    expect(answer.protein.ceil(), 130);
    expect(answer.fat.ceil(), 39);
    expect(answer.carbohydrate.ceil(), 350);
  });
}
