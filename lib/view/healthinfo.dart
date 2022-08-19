import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:health_scanner/util/constant.dart';
import 'package:health_scanner/view/common/bottom_button.dart';
import 'package:health_scanner/view/common/style_provider.dart';
import 'package:health_scanner/view/common/widget_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HealthInput extends StatefulWidget {
  const HealthInput({Key? key}) : super(key: key);

  @override
  _HealthInputState createState() => _HealthInputState();
}

class _HealthInputState extends State<HealthInput> {
  TextEditingController cholesController = TextEditingController();
  TextEditingController glucoseController = TextEditingController();
  TextEditingController fatController = TextEditingController();
  String choles = '';
  String glucose = '';
  String fat = '';

  // BannerAd? banner;
  final String iOSTestId = 'ca-app-pub-3940256099942544/2934735716';
  final String androidTestId = 'ca-app-pub-9075644019401216/6391836077';

  @override
  void initState() {
    super.initState();
    // banner = BannerAd(
    //   size: AdSize.fullBanner,
    //   adUnitId: Platform.isIOS ? iOSTestId : androidTestId,
    //   listener: const BannerAdListener(),
    //   request: const AdRequest(),
    // )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (choles.isEmpty && glucose.isEmpty && fat.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        choles = Hive.box(personalInfoBox)
            .get(HealthKey.cholesterol, defaultValue: 0)
            .toString();
        glucose = Hive.box(personalInfoBox)
            .get(HealthKey.glucose, defaultValue: 0)
            .toString();
        fat = Hive.box(personalInfoBox)
            .get(HealthKey.fat, defaultValue: 0)
            .toString();
        setState(() {
          cholesController.text = choles;
          glucoseController.text = glucose;
          fatController.text = fat;
        });
      });
    }
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: WidgetProvider.appBar(
          '건강 정보 입력',
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '콜레스테롤 입력',
                        style: textStyleBold14,
                      ),
                      lineSpace5,
                      _inputItem(
                        '',
                        (text) {
                          setState(() {
                            choles = text;
                          });
                        },
                        controller: cholesController,
                      ),
                      lineSpace30,
                      const Text(
                        '혈당 수치 입력',
                        style: textStyleBold14,
                      ),
                      lineSpace5,
                      _inputItem(
                        '',
                        (text) {
                          setState(() {
                            glucose = text;
                          });
                        },
                        controller: glucoseController,
                      ),
                      lineSpace30,
                      const Text(
                        '지방 수치 입력',
                        style: textStyleBold14,
                      ),
                      lineSpace5,
                      _inputItem(
                        '',
                        (text) {
                          setState(() {
                            fat = text;
                          });
                        },
                        controller: fatController,
                      ),
                      lineSpace30,
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: BottomButton(
                              label: '재입력',
                              onPress: () {
                                setState(
                                  () {
                                    cholesController.clear();
                                    glucoseController.clear();
                                    fatController.clear();
                                  },
                                );
                              },
                            ),
                          ),
                          rowSpace20,
                          Flexible(
                            child: BottomButton(
                              label: '저장',
                              onPress: () async {
                                if (choles.isNotEmpty &&
                                    glucose.isNotEmpty &&
                                    fat.isNotEmpty) {
                                  await Hive.box(personalInfoBox).put(
                                      HealthKey.cholesterol, int.parse(choles));
                                  await Hive.box(personalInfoBox).put(
                                      HealthKey.glucose, int.parse(glucose));
                                  await Hive.box(personalInfoBox)
                                      .put(HealthKey.fat, int.parse(fat));
                                  Navigator.pop(context);
                                } else {}
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
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

  Widget _inputItem(String hint, ValueChanged<String> callback,
      {TextInputType? inputType,
      bool? obscure,
      int? maxLength,
      List<TextInputFormatter>? formatter,
      String? initialValue,
      TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      style: textStyleNormal14,
      keyboardType: inputType,
      maxLength: maxLength,
      obscureText: obscure ?? false,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        hintText: hint,
        hintStyle: StyleProvider.textStyleNormal12(Colors.black26),
      ),
      onChanged: callback,
      inputFormatters: formatter,
    );
  }
}
