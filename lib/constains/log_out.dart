import 'dart:js';

import 'package:flutter/material.dart';
import 'package:medsapp_project/Screens/about_us.dart';
import 'package:medsapp_project/Screens/beautiful_cards.dart';
import 'package:medsapp_project/Screens/chat_screen.dart';
import 'package:medsapp_project/Screens/contact_us.dart';
import 'package:medsapp_project/Screens/dashbored.dart';
import 'package:medsapp_project/Screens/login_screen1.dart';
import 'package:medsapp_project/Screens/on_boarding_screens.dart';
import 'package:medsapp_project/Screens/search_donations_here.dart';
import 'package:medsapp_project/Screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut {
  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    // Navigate to the login screen and remove all the routes
    Navigator.pushAndRemoveUntil(
      context as BuildContext,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
      (route) => true,
    );
    Navigator.pushAndRemoveUntil(
      context as BuildContext,
      MaterialPageRoute(builder: (BuildContext context) => OnboardingScreen()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context as BuildContext,
      MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context as BuildContext,
      MaterialPageRoute(builder: (BuildContext context) => BeautifulCards()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context as BuildContext,
      MaterialPageRoute(
          builder: (BuildContext context) => FindDonationScreen()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context as BuildContext,
      MaterialPageRoute(builder: (BuildContext context) => AboutUs()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context as BuildContext,
      MaterialPageRoute(builder: (BuildContext context) => ContactUsScreen()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context as BuildContext,
      MaterialPageRoute(builder: (BuildContext context) => Dashbored()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context as BuildContext,
      MaterialPageRoute(builder: (BuildContext context) => ChatScreen()),
      (route) => false,
    );
    Navigator.pushAndRemoveUntil(
      context as BuildContext,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
      (route) => false,
    );
  }
}
