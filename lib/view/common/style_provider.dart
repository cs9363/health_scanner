import 'package:flutter/material.dart';

const textStyleNormal10 =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 10);
const textStyleNormal12 =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 12);
const textStyleNormal14 =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 14);
const textStyleNormal16 =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 16);
const textStyleNormal18 =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 18);
const textStyleNormal20 =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
const textStyleBold10 = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
const textStyleBold12 = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
const textStyleBold14 = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
const textStyleBold16 = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
const textStyleBold18 = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
const textStyleBold20 = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const textStyleBold22 = TextStyle(fontWeight: FontWeight.bold, fontSize: 22);

const borderWidth = 0.3;
const buttonBorderRadius = 5;

Widget get rowSpace5 => const SizedBox(
      width: 5,
    );

Widget get rowSpace10 => const SizedBox(
      width: 10,
    );

Widget get rowSpace20 => const SizedBox(
      width: 20,
    );

Widget get rowSpace30 => const SizedBox(
      width: 30,
    );

Widget get lineSpace5 => const SizedBox(
      height: 5,
    );

Widget get lineSpace10 => const SizedBox(
      height: 10,
    );

Widget get lineSpace15 => const SizedBox(
      height: 15,
    );

Widget get lineSpace20 => const SizedBox(
      height: 20,
    );

Widget get lineSpace30 => const SizedBox(
      height: 30,
    );

Widget get lineSpace40 => const SizedBox(
      height: 40,
    );

Widget get wrapLineSpace10 => Container(
      height: 10,
    );

Widget get wrapLineSpace20 => Container(
      height: 20,
    );

Widget get wrapLineSpace30 => Container(
      height: 30,
    );

Widget get wrapLineSpace40 => Container(
      height: 40,
    );

class StyleProvider {
  StyleProvider._();

  static TextStyle textStyleNormal10(Color color) {
    return TextStyle(fontWeight: FontWeight.normal, fontSize: 10, color: color);
  }

  static TextStyle textStyleNormal12(Color color) {
    return TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: color);
  }

  static TextStyle textStyleNormal14(Color color) {
    return TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: color);
  }

  static TextStyle textStyleNormal16(Color color) {
    return TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: color);
  }

  static TextStyle textStyleNormal18(Color color) {
    return TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: color);
  }

  static TextStyle textStyleNormal20(Color color) {
    return TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: color);
  }

  static TextStyle textStyleBold12(Color color) {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: color);
  }

  static TextStyle textStyleBold14(Color color) {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color);
  }

  static TextStyle textStyleBold16(Color color) {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color);
  }

  static TextStyle textStyleBold18(Color color) {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color);
  }

  static TextStyle textStyleBold20(Color color) {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: color);
  }
}
