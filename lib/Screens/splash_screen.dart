import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medsapp_project/Screens/dashbored.dart';
//import 'package:medsapp_project/Screens/home_screen.dart';
import 'package:medsapp_project/Screens/on_boarding_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidationData().whenComplete(() {
      Timer(Duration(seconds: 10), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    finalEmail == null ? OnboardingScreen() : Dashbored())));
      });
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainEmail!;
    });
    print('finalEmail');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: height * 0.2),
        child: Column(
          children: [
            Container(
              // padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
              child: Center(
                child: Stack(children: [
                  Image(
                    image: AssetImage('assets/images/2.png.png'),
                  ),
                  Positioned(
                      top: height * 0.10,
                      left: width * 0.17,
                      child: Text(
                        'Donations',
                        style: TextStyle(color: Colors.black),
                      )),
                ]),
              ),
            ),
            SizedBox(
              height: height * 0.250,
            ),
            Text(
              'Welcome To MedsApp',
              style: TextStyle(fontSize: 18, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
