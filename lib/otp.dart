import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/textstyle.dart';
import 'package:testapp/number.dart';
import 'package:testapp/user_detailScreen.dart';

// ignore: must_be_immutable
class MyVerify extends StatefulWidget {
  String verificationid;
  MyVerify({super.key, required this.verificationid});

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 22,
        color: buttontextcolor,
      ),
      decoration: BoxDecoration(
        color: subheadingcolor,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: headingcolor),
      ),
    );
    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor:backgroundColor ,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: subheadingcolor,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        alignment: Alignment.center,
        
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/otp.gif',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "PHONE VERIFICATION",
                style: alfaSlabOne(fontFamily: "Poppins-B", size: 26, color: subheadingcolor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: textStyle(fontFamily: "Poppins-R", size: 16, color: textcolor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

                showCursor: true,
                // ignore: avoid_print
                // onCompleted: (pin) => print(pin),
                onChanged: (value) {
                  code = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: subheadingcolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            await PhoneAuthProvider.credential(
                                verificationId: widget.verificationid,
                                smsCode: code);
                        FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) => Navigator.push(
                                context,
                                PageTransition(
                                    child: const DetailScreen(),
                                    type: PageTransitionType.scale,
                                    alignment: Alignment.center,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.ease)));
                      } catch (x) {
                        log(x.toString() as num);
                      }
                    },
                    child: Text(
                      "VERIFY NUMBER",
                      style: alfaSlabOne(fontFamily: "Poppins-B", size: 18, color: buttontextcolor),
                    )),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const MyPhone(),
                                type: PageTransitionType.scale,
                                alignment: Alignment.center,
                                duration: const Duration(seconds: 1),
                                curve: Curves.ease));
                      },
                      child: const Text(
                        "Edit Phone Number ?",
                        style:
                            TextStyle(fontFamily: "Poppins-R", color: textColor),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
