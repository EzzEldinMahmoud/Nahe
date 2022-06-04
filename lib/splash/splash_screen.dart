import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/sign_page.dart';
import 'package:project/screens/start_screen.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logoSize: 100.0,
      logo: Image(image: AssetImage('assets/images/logo12.png')),
      backgroundColor: Color(0xffff00252b),
      showLoader: true,
      loadingText: Text("Loading...", style: TextStyle(color: Colors.white)),
      navigator: first_form(),
      durationInSeconds: 3,
      loaderColor: Colors.white,
    );
  }
}
