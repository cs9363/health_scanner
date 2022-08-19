import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:health_scanner/repository/entity/health_item.dart';
import 'package:health_scanner/repository/entity/scan_result.dart';
import 'package:health_scanner/util/constant.dart';
import 'package:health_scanner/view/home.dart';
import 'package:health_scanner/view/splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HealthItemAdapter());
  Hive.registerAdapter(ScanResultAdapter());
  await Hive.openBox<HealthItem>(healthInfoBox);
  await Hive.openBox<ScanResult>(scanHistoryBox);
  await Hive.openBox(personalInfoBox);

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  // MobileAds.instance.initialize();
  runApp(
    const MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
