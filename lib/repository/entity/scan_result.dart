import 'package:hive_flutter/hive_flutter.dart';

part 'scan_result.g.dart';

@HiveType(typeId: 1)
class ScanResult {
  @HiveField(0)
  DateTime time;
  @HiveField(1)
  String barcode;
  @HiveField(2)
  String result;

  ScanResult({required this.time, required this.barcode, required this.result});

  @override
  String toString() {
    return 'ScanResult ($time, $barcode, $result)';
  }
}
