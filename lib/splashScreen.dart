// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Home.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/textstyle.dart';
import 'package:testapp/onboardSlider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ignore: constant_identifier_names
  static const String KEYSTORE = "isStore";
  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.2,
                    color: Colors.white,
                    child: Image.asset(
                      "assets/car.gif",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 350,
                  child: Text("DRIVER'S EMOTION MODULE CONTROLLER",
                      style: alfaSlabOneOutline(size: 30,),textAlign: TextAlign.center,),
                ),
              ],
            ),
          ),
      ),
    );
  }

  void whereToGo() async {
    var sharepref = await SharedPreferences.getInstance();
    var isStored = sharepref.getBool(KEYSTORE);
    Timer(const Duration(seconds: 5), () {
      if (isStored != null) {
        if (isStored) {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const HomeScreen(),
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  duration: const Duration(seconds: 2),
                  curve: Curves.ease));
        } else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const Homepage(),
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  duration: const Duration(seconds: 2),
                  curve: Curves.ease));
        }
      }else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const Homepage(),
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  duration: const Duration(seconds: 2),
                  curve: Curves.ease));
        }
    });
  }
}
