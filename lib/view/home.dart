import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:health_scanner/repository/db_helper.dart';
import 'package:health_scanner/repository/entity/scan_result.dart';
import 'package:health_scanner/util/constant.dart';
import 'package:health_scanner/util/health_mapper.dart';
import 'package:health_scanner/view/common/widget_provider.dart';
import 'package:health_scanner/view/healthinfo.dart';
import 'package:health_scanner/view/scan_history.dart';
import 'package:health_scanner/view/settings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scan/scan.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MenuItem {
  FaIcon icon;
  String text;
  int id;

  MenuItem(this.icon, this.text, this.id);
}

final List<MenuItem> _menuItems = [
  MenuItem(
    const FaIcon(
      FontAwesomeIcons.pencil,
      color: Colors.black,
    ),
    '건강수치 입력',
    Screen.inputHealth,
  ),
  MenuItem(
    const FaIcon(
      FontAwesomeIcons.barcode,
      color: Colors.black,
    ),
    '스캔 내역',
    Screen.viewHistory,
  ),
  MenuItem(
    const FaIcon(
      FontAwesomeIcons.gear,
      color: Colors.black,
    ),
    '설정',
    Screen.settings,
  ),
  MenuItem(
    const FaIcon(
      FontAwesomeIcons.houseMedical,
      color: Colors.black,
    ),
    '종합검진센터 가기',
    Screen.goMedicalCheck,
  ),
];

class ScannerHome extends StatefulWidget {
  const ScannerHome({Key? key}) : super(key: key);

  @override
  _ScannerHomeState createState() => _ScannerHomeState();
}

class _ScannerHomeState extends State<ScannerHome> {
  ScanController controller = ScanController();
  String capturedData = '';
  bool scanViewLoad = false;
  bool capturePaused = false;

  // BannerAd? banner;
  final String iOSBannerId = 'ca-app-pub-3940256099942544/2934735716';
  final String iOSFullId = 'ca-app-pub-3940256099942544/4411468910';
  final String androidBannerId = 'ca-app-pub-9075644019401216/6391836077';
  final String androidFullId = 'ca-app-pub-9075644019401216/7485425898';
  String description = '';
  int fullScreenAdView = 0;

  // InterstitialAd? interstitialAd;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.initialize();
    // banner = BannerAd(
    //   size: AdSize.fullBanner,
    //   adUnitId: Platform.isIOS ? iOSBannerId : androidBannerId,
    //   listener: const BannerAdListener(),
    //   request: const AdRequest(),
    // )..load();
  }

  @override
  void dispose() {
    // interstitialAd?.dispose();
    super.dispose();
  }

  // void makeFullScreenAd() {
  //   InterstitialAd.load(
  //     adUnitId: Platform.isIOS ? iOSFullId : androidFullId,
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (InterstitialAd ad) {
  //         interstitialAd = ad;
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         log('InterstitialAd failed to load: $error');
  //       },
  //     ),
  //   );
  // }
  //
  // void showFullScreenAd() {
  //   interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       ad.dispose();
  //     },
  //   );
  //   interstitialAd?.show();
  // }

  void onSelect(MenuItem item) {
    switch (item.id) {
      case Screen.inputHealth:
        controller.pause();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HealthInput()))
            .then((value) => controller.resume());
        break;
      case Screen.viewHistory:
        controller.pause();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ScanHistory()))
            .then((value) => controller.resume());
        break;
      case Screen.settings:
      // controller.pause();
      // Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const Settings()))
      //     .then((value) => controller.resume());
        break;
      case Screen.goMedicalCheck:
        controller.pause();
        launchUrl(Uri.parse("https://komef.org"), mode: LaunchMode.externalApplication);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: WidgetProvider.appBar('건강 스캐너', actions: [
          PopupMenuButton<MenuItem>(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            offset: const Offset(0, 56),
            onSelected: onSelect,
            itemBuilder: (BuildContext context) {
              return _menuItems.map((MenuItem item) {
                return PopupMenuItem<MenuItem>(
                  value: item,
                  child: ListTile(
                    leading: item.icon,
                    title: Text(item.text),
                  ),
                );
              }).toList();
            },
          ),
        ]),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          int cholesterol = Hive.box(personalInfoBox).get(HealthKey.cholesterol, defaultValue: -1);
                          int glucose = Hive.box(personalInfoBox).get(HealthKey.glucose, defaultValue: -1);
                          int fat = Hive.box(personalInfoBox).get(HealthKey.fat, defaultValue: -1);
                          if (cholesterol >= 0 && glucose >= 0 && fat >= 0) {
                            setState(() => scanViewLoad = true);
                          } else {
                            showNoData();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.lime,
                            border: Border.all(color: Colors.lime, width: 2),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.play_arrow),
                              Text('스캔 시작하기')
                            ],
                          ),
                        ),
                      ),
                    ),
                    scanViewLoad
                        ? ScanView(
                      controller: controller,
                      scanAreaScale: 0.8,
                      scanLineColor: Colors.lime,
                      onCapture: (data) {
                        controller.pause();
                        log('captured data : $data');
                        setState(() {
                          capturePaused = true;
                          capturedData = data;
                        });
                        processingData(capturedData);
                      },
                    )
                        : const SizedBox.shrink(),
                    scanViewLoad && capturePaused
                        ? Positioned(
                      bottom: 20,
                      right: 20,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() => capturePaused = false);
                          controller.resume();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('다시 스캔하기'),
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.black),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.lime),
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              Container(
                height: 70,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                alignment: Alignment.center,
                color: Colors.lime,
                child: Text(
                  scanViewLoad
                      ? capturedData.isEmpty
                      ? '바코드를 인식해 주세요.'
                      : capturedData
                      : '스캔 시작하기를 눌러주세요',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 60,
              //   child: AdWidget(
              //     ad: banner!,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void showNoData() {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        content: Text(
          '건강 수치를 먼저 입력해 주세요.',
          textAlign: TextAlign.center,
        ),
        dismissDirection: DismissDirection.down,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void processingData(String codeData) {
    if (fullScreenAdView == 0) {
      // makeFullScreenAd();
    }
    setState(() => fullScreenAdView += 1);
    if (fullScreenAdView == 10) {
      setState(() => fullScreenAdView = 0);
      // showFullScreenAd();
    }
    if (codeData.length >= 13) {
      String data = codeData.substring(codeData.length - 13).substring(0, 12);
      log('Captured : $data');
      int userCholesterol =
      Hive.box(personalInfoBox).get(HealthKey.cholesterol, defaultValue: 0);
      int userGlucose =
      Hive.box(personalInfoBox).get(HealthKey.glucose, defaultValue: 0);
      int userFat =
      Hive.box(personalInfoBox).get(HealthKey.fat, defaultValue: 0);
      description = '건강 스캐너 결과\n\n';
      DatabaseHelper.instance.search(data).then((value) {
        log('search result: $value');
        if (value != null) {
          description += '검색된 식품 : ${value.name}\n';
          int cholesScan = getScanLevel(value.cholesterol);
          if (userCholesterol > 0) {
            if (userCholesterol > 250) {
              description +=
              cholesterolString[Cholesterol.healthLevel3]![cholesScan]!;
            } else if (userCholesterol > 200 && userCholesterol <= 250) {
              description +=
              cholesterolString[Cholesterol.healthLevel2]![cholesScan]!;
            } else if (userCholesterol > 150 && userCholesterol <= 200) {
              description +=
              cholesterolString[Cholesterol.healthLevel1]![cholesScan]!;
            }
            description += '\n';
          }
          int glucoseScan = getScanLevel(value.bloodGlucose);
          if (userGlucose > 0) {
            if (userGlucose > 120) {
              description += glucoseString[Glucose.healthLevel4]![glucoseScan]!;
            } else if (userGlucose > 105 && userGlucose <= 120) {
              description += glucoseString[Glucose.healthLevel3]![glucoseScan]!;
            } else if (userGlucose > 90 && userGlucose <= 105) {
              description += glucoseString[Glucose.healthLevel2]![glucoseScan]!;
            } else if (userGlucose > 70 && userGlucose <= 90) {
              description += glucoseString[Glucose.healthLevel1]![glucoseScan]!;
            }
            description += '\n';
          }
          int fatScan = getFatScanLevel(value.fat);
          description += fatString[fatScan]!;
          Hive.box<ScanResult>(scanHistoryBox).add(ScanResult(
              time: DateTime.now(), barcode: data, result: description));
        } else {
          description += '일치하는 결과가 없습니다. 다시 시도해 주세요.';
        }
        setState(() {});
      });
    } else {
      setState(() {
        description = '바코드가 잘못 인식된 것 같습니다. 다시 시도해 주세요.';
      });
    }
  }

  int getScanLevel(int value) {
    int filtered = value.floor();
    if (filtered == 0) {
      return ScanLevel.low;
    } else if (filtered >= 1 && filtered <= 2) {
      return ScanLevel.mid;
    } else if (filtered >= 3) {
      return ScanLevel.high;
    } else {
      return ScanLevel.low;
    }
  }

  int getFatScanLevel(int value) {
    int filtered = value.floor();
    if (filtered == 0) {
      return ScanLevel.low;
    } else if (filtered >= 1 && filtered <= 10) {
      return ScanLevel.mid;
    } else if (filtered >= 11 && filtered <= 25) {
      return ScanLevel.high;
    } else {
      return ScanLevel.highest;
    }
  }
}
