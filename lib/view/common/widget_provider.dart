import 'package:flutter/material.dart';
import 'package:health_scanner/view/common/bottom_button.dart';
import 'package:health_scanner/view/common/style_provider.dart';

class WidgetProvider {
  WidgetProvider._();

  static PreferredSizeWidget appBar(String title,
      {List<Widget>? actions,}) {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: textStyleNormal18,
          ),
        ],
      ),
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0.0,
      automaticallyImplyLeading: true,
      actions: actions ??
          [
            const IconButton(
              iconSize: 1,
              icon: Icon(
                Icons.refresh,
                color: Colors.transparent,
              ),
              onPressed: null,
            ),
          ],
    );
  }

  static Widget floatingButton(
      String text, bool enabled, VoidCallback callback) {
    return enabled ? BottomButton(label: text, onPress: callback) : Container();
  }

  static Widget floatingTwoButton(bool enabled, String text1,
      VoidCallback callback1, String text2, VoidCallback callback2) {
    return enabled
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: BottomButton(
                    label: text1,
                    onPress: callback1,
                    isBlack: false,
                  ),
                ),
                rowSpace20,
                Expanded(
                  child: BottomButton(
                    label: text2,
                    onPress: callback2,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
