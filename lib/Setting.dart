import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/textstyle.dart';
import 'package:testapp/editProfile.dart';
import 'package:testapp/splashScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  static const String KEYUSERNAME = "Username";
  static const String KEYUSEREMAIL = "Useremail";
  static const String KEYUSERADDRESS = "Useraddress";
  static const String KEYNUMBER = "number";
  late String username = "";
  late String useremail = "";
  late String useraddress = "";
  late String userphonenumber = "";

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  void loadDetails() async {
    var sharepref = await SharedPreferences.getInstance();
    setState(() {
      username = sharepref.getString(KEYUSERNAME) ?? "";
      useremail = sharepref.getString(KEYUSEREMAIL) ?? "";
      useraddress = sharepref.getString(KEYUSERADDRESS) ?? "";
      userphonenumber = sharepref.getString(KEYNUMBER) ?? "";
    });
  }

  Future<void> _navigateToEditProfileScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          username: username,
          useremail: useremail,
          userphonenumber: userphonenumber,
          useraddress: useraddress,
        ),
      ),
    );

    if (result == true) {
      // Refresh the details if changes were saved
      loadDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var sharepref = await SharedPreferences.getInstance();
          sharepref.remove(SplashScreenState.KEYSTORE);
        },
        backgroundColor: subheadingcolor,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      body: Container(
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/person.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  alignment: const Alignment(-1, 0),
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text(
                          "Name: $username",
                          style: textStyle(
                              size: 16, color: const Color(0xFF040D12)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text(
                          "Email Address: $useremail",
                          style: textStyle(
                              size: 16, color: const Color(0xFF040D12)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text(
                          "Emergency Number: $userphonenumber",
                          style: textStyle(
                              size: 16, color: const Color(0xFF040D12)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text(
                          "Address: $useraddress",
                          style: textStyle(
                              size: 16, color: const Color(0xFF040D12)),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10.0),
                          child: ElevatedButton(
                            onPressed: _navigateToEditProfileScreen,
                            child: const Text('Edit Profile'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
