import 'dart:convert';
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:health_scanner/repository/entity/health_item.dart';
import 'package:health_scanner/util/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper get instance => DatabaseHelper._();

  void initialize() async {
    String initData = await rootBundle.loadString('assets/sample.csv');
    Iterable<String> list = LineSplitter.split(initData);
    for (var element in list) {
      List<String> row = element.split(',').toList();
      await Hive.box<HealthItem>(healthInfoBox).put(
          row[2].substring(0, row[2].length - 1), // make barcode as key
          HealthItem(
              id: int.parse(row[0]),
              name: row[1],
              barcode: row[2],
              cholesterol: int.parse(row[3]),
              bloodGlucose: int.parse(row[4]),
              fat: int.parse(row[5]),
              protein: int.parse(row[6]),
              natrium: int.parse(row[7]),
              calorie: int.parse(row[8])));
    }
    log('box init : ${Hive.box<HealthItem>(healthInfoBox).toMap().toString()}');
  }

  Future<HealthItem?> search(String barcode) async {
    HealthItem? item = Hive.box<HealthItem>(healthInfoBox).get(barcode);
    return item;
  }

// Future<HealthItem?> search(String barcode) async {
//   List<Map<String, dynamic>> result = await database.query(tableName,
//       columns: ['barcode'], where: 'barcode = ?', whereArgs: [barcode]);
//   List<HealthItem> resultValues = List.generate(result.length, (index) {
//     return HealthItem(
//         id: result[index]['id'],
//         name: result[index]['name'],
//         barcode: result[index]['barcode'],
//         cholesterol: result[index]['cholesterol'],
//         bloodGlucose: result[index]['bloodGlucose'],
//         fat: result[index]['fat'],
//         protein: result[index]['protein'],
//         natrium: result[index]['natrium'],
//         calorie: result[index]['calorie']);
//   });
//
//   return resultValues.isNotEmpty ? resultValues.first : null;
// }
}
