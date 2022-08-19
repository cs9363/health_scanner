// owner value, scanned value , string
import 'package:health_scanner/util/strings.dart';

Map<int, Map<int, String>> cholesterolString = {
  Cholesterol.healthLevel1: {
    ScanLevel.low: ResultString.cholesterolGood,
    ScanLevel.mid: ResultString.cholesterolNotBad,
    ScanLevel.high: ResultString.cholesterolBad,
  },
  Cholesterol.healthLevel2: {
    ScanLevel.low: ResultString.cholesterolBad,
    ScanLevel.mid: ResultString.cholesterolTooBad,
    ScanLevel.high: ResultString.cholesterolTooBad,
  },
  Cholesterol.healthLevel3: {
    ScanLevel.low: ResultString.cholesterolTooBad,
    ScanLevel.mid: ResultString.cholesterolDanger,
    ScanLevel.high: ResultString.cholesterolDanger,
  },
};

Map<int, Map<int, String>> glucoseString = {
  Glucose.healthLevel1: {
    ScanLevel.low: ResultString.glucoseGood,
    ScanLevel.mid: ResultString.glucoseNotBad,
    ScanLevel.high: ResultString.glucoseBad,
  },
  Glucose.healthLevel2: {
    ScanLevel.low: ResultString.glucoseGood,
    ScanLevel.mid: ResultString.glucoseBad,
    ScanLevel.high: ResultString.glucoseTooBad,
  },
  Glucose.healthLevel3: {
    ScanLevel.low: ResultString.glucoseGood,
    ScanLevel.mid: ResultString.glucoseTooBad,
    ScanLevel.high: ResultString.glucoseDanger,
  },
  Glucose.healthLevel4: {
    ScanLevel.low: ResultString.glucoseGood,
    ScanLevel.mid: ResultString.glucoseDanger,
    ScanLevel.high: ResultString.glucoseDanger,
  },
};

Map<int, String> fatString = {
    ScanLevel.low: ResultString.fatGood,
    ScanLevel.mid: ResultString.fatNotBad,
    ScanLevel.high: ResultString.fatBad,
    ScanLevel.highest: ResultString.fatDanger,
};

class Cholesterol {
  static const healthLevel1 = 1;
  static const healthLevel2 = 2;
  static const healthLevel3 = 3;
}

class Glucose {
  static const healthLevel1 = 4;
  static const healthLevel2 = 5;
  static const healthLevel3 = 6;
  static const healthLevel4 = 7;
}

class ScanLevel {
  static const low = 0;
  static const mid = 1;
  static const high = 2;
  static const highest = 3; // fat only
}
