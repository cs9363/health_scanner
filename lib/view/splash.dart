import 'package:flutter/material.dart';
import 'package:health_scanner/view/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ScannerHome())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/splash.png',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
