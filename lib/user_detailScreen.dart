// ignore_for_file: file_names, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Home.dart';
import 'package:testapp/Setting.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/input_field.dart';
import 'package:testapp/constant/textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testapp/splashScreen.dart';

final _formkey = GlobalKey<FormState>();

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final houseAddressController = TextEditingController();
  final phoneController = TextEditingController();

  String? validateEmail(String? email) {
    RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final isEmailValid = emailRegExp.hasMatch(email ?? '');
    if (!isEmailValid) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? validatePhone(String? phone) {
    RegExp phoneRegExp =
        RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    final isPhoneValid = phoneRegExp.hasMatch(phone ?? '');
    if (!isPhoneValid) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.length < 3) {
      return "Name should be at least 3 characters";
    }
    return null;
  }

  String? validateAddress(String? address) {
    if (address == null || address.length < 5) {
      return "Address should be at least 5 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0),
          child: Container(
            color: subheadingcolor,
            height: 4.0,
          ),
        ),
        title: Center(
            child: Text(
          "USER DETAILS",
          style: alfaSlabOne(
              fontFamily: "Poppins-B", size: 32, color: subheadingcolor),
          textAlign: TextAlign.center,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/form_fill.gif',
                  width: 150,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    InputField(
                      validate: validateName,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      hintText: "Full Name",
                      prefixIcon: const Icon(
                        Icons.person_2_rounded,
                        color: subheadingcolor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      validate: validateEmail,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Email Address",
                      prefixIcon: const Icon(
                        Icons.email_rounded,
                        color: subheadingcolor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      validate: validateAddress,
                      controller: houseAddressController,
                      keyboardType: TextInputType.text,
                      hintText: "Residential Address",
                      prefixIcon: const Icon(
                        Icons.location_on,
                        color: subheadingcolor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      validate: validatePhone,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      hintText: "Emergency Number",
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: subheadingcolor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 180,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: subheadingcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          String ID = randomAlphaNumeric(10);
                          if (_formkey.currentState!.validate()) {
                            CollectionReference collRef = FirebaseFirestore
                                .instance
                                .collection("Flutterclient");
                            await collRef.add({
                              'id': ID,
                              'Name': nameController.text,
                              'Email': emailController.text,
                              'Mobile Number': phoneController.text,
                              'Location': houseAddressController.text,
                            });

                            // Save to Shared Preferences
                            SharedPreferences sharepref =
                                await SharedPreferences.getInstance();
                            sharepref.setString(SettingScreenState.KEYUSERNAME,
                                nameController.text);
                            sharepref.setString(SettingScreenState.KEYUSEREMAIL,
                                emailController.text);
                            sharepref.setString(
                                SettingScreenState.KEYUSERADDRESS,
                                houseAddressController.text);
                            sharepref.setString(
                                SettingScreenState.KEYNUMBER, phoneController.text);
                            sharepref.setBool(SplashScreenState.KEYSTORE, true);

                            // Navigate to Home Screen
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: const HomeScreen(),
                                type: PageTransitionType.scale,
                                alignment: Alignment.center,
                                duration: const Duration(seconds: 1),
                                curve: Curves.ease,
                              ),
                            );
                          }
                        },
                        child: Text(
                          "SUBMIT",
                          style: textStyle(
                            fontFamily: "Poppins-B",
                            size: 22,
                            color: buttontextcolor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
