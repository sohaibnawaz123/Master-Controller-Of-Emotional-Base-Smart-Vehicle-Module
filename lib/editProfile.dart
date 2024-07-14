// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/Setting.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/textstyle.dart';

class EditProfileScreen extends StatefulWidget {
  final String username;
  final String useremail;
  final String userphonenumber;
  final String useraddress;

  const EditProfileScreen({super.key, 
    required this.username,
    required this.useremail,
    required this.userphonenumber,
    required this.useraddress,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _useremailController;
  late TextEditingController _userphonenumberController;
  late TextEditingController _useraddressController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _useremailController = TextEditingController(text: widget.useremail);
    _userphonenumberController = TextEditingController(text: widget.userphonenumber);
    _useraddressController = TextEditingController(text: widget.useraddress);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _useremailController.dispose();
    _userphonenumberController.dispose();
    _useraddressController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    var sharepref = await SharedPreferences.getInstance();
    sharepref.setString(SettingScreenState.KEYUSERNAME, _usernameController.text);
    sharepref.setString(SettingScreenState.KEYUSEREMAIL, _useremailController.text);
    sharepref.setString(SettingScreenState.KEYUSERADDRESS, _useraddressController.text);
    // Assuming HomeState.KEYNUMBER is the correct key for userphonenumber
    sharepref.setString(SettingScreenState.KEYNUMBER, _userphonenumberController.text);

    // ignore: use_build_context_synchronously
    Navigator.pop(context, true); // Return true to indicate changes were saved
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: subheadingcolor,
            borderRadius: BorderRadius.circular(10.0)),
            child: IconButton(
              icon: const Icon(Icons.save,color: Colors.white,),
              onPressed: _saveChanges,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding:  const EdgeInsets.symmetric(horizontal: 20.0,vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration:InputDecoration(labelText: 'Username',
              labelStyle:textStyle(size: 18, color: subheadingcolor),
              border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primarycolor, width: 2)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primarycolor, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: subheadingcolor, width: 2))
              ),
            ),const SizedBox(height: 20,),
            TextFormField(
              controller: _useremailController,
              decoration:InputDecoration(labelText: 'Email Address',
              labelStyle:textStyle(size: 18, color: subheadingcolor),
              border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primarycolor, width: 2)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primarycolor, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: subheadingcolor, width: 2))),
            ),const SizedBox(height: 20,),
            TextFormField(
              controller: _userphonenumberController,
              decoration: InputDecoration(labelText: 'Emergency Number',
              labelStyle:textStyle(size: 18, color: subheadingcolor),
              border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primarycolor, width: 2)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primarycolor, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: subheadingcolor, width: 2))),
            ),const SizedBox(height: 20,),
            TextFormField(
              controller: _useraddressController,
              decoration: InputDecoration(labelText: 'Residential Address',
              labelStyle:textStyle(size: 18, color: subheadingcolor),
              border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primarycolor, width: 2)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primarycolor, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: subheadingcolor, width: 2))),
            ),
          ],
        ),
      ),
    );
  }
}
