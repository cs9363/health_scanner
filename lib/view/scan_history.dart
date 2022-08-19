import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_scanner/repository/entity/scan_result.dart';
import 'package:health_scanner/util/constant.dart';
import 'package:health_scanner/view/common/bottom_button.dart';
import 'package:health_scanner/view/common/style_provider.dart';
import 'package:health_scanner/view/common/widget_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScanHistory extends StatefulWidget {
  const ScanHistory({Key? key}) : super(key: key);

  @override
  _ScanHistoryState createState() => _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  @override
  Widget build(BuildContext context) {
    var history = Hive.box<ScanResult>(scanHistoryBox);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: WidgetProvider.appBar(
          '스캔 내역',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: history.length > 0
                ? Column(
                    children: [
                      Flexible(
                        child: ListView.separated(
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            ScanResult result =
                                history.getAt((history.length - 1) - index)!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result.time.toString(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  result.barcode,
                                  style: textStyleBold16,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  result.result,
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 30,
                            );
                          },
                        ),
                      ),
                      lineSpace20,
                      BottomButton(
                        label: '삭제',
                        onPress: () => Hive.box<ScanResult>(scanHistoryBox)
                            .clear()
                            .then((_) => setState(() {})),
                      )
                    ],
                  )
                : Center(
                    child: Text('스캔한 내역이 없습니다.', style: textStyleNormal16,),
                  ),
          ),
        ),
      ),
    );
  }
}
