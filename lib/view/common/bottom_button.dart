import 'package:flutter/material.dart';
import 'package:health_scanner/view/common/style_provider.dart';

const double buttonIconSize = 30;
const double buttonHeight = 50;

class BottomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPress;
  final bool isBlack;

  const BottomButton(
      {required this.label,
      required this.onPress,
      this.isBlack = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPress,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: textStyleBold16,
          ),
        ),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              return states.contains(MaterialState.pressed)
                  ? isBlack
                      ? Colors.grey
                      : Colors.grey
                  : null;
            },
          ),
          foregroundColor: isBlack
              ? MaterialStateProperty.all<Color>(Colors.white)
              : MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: isBlack
              ? MaterialStateProperty.all<Color>(Colors.black)
              : MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
            // borderRadius: BorderRadius.all(Radius.circular(10.0)),
            side: BorderSide(color: Colors.black),
          )),
        ),
      ),
    );
  }
}
