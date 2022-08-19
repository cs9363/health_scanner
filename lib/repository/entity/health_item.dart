import 'package:hive_flutter/hive_flutter.dart';

part 'health_item.g.dart';

@HiveType(typeId: 0)
class HealthItem {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String barcode;
  @HiveField(3)
  int cholesterol;
  @HiveField(4)
  int bloodGlucose;
  @HiveField(5)
  int fat;
  @HiveField(6)
  int protein;
  @HiveField(7)
  int natrium;
  @HiveField(8)
  int calorie;

  HealthItem(
      {required this.id,
      required this.name,
      required this.barcode,
      required this.cholesterol,
      required this.bloodGlucose,
      required this.fat,
      required this.protein,
      required this.natrium,
      required this.calorie});

  @override
  String toString() {
    return 'HealthItem ($id, $name, $barcode, $cholesterol, $bloodGlucose, $fat, $protein, $natrium, $calorie)';
  }
}
