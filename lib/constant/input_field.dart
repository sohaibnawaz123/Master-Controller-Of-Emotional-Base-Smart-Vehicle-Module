import 'package:flutter/material.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/textstyle.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? prefixIcon;
  final validate;
  // final Widget? suffixIcon;
  const InputField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hintText,
    this.prefixIcon, required this.validate,
    // this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return TextFormField(
      validator: validate,
      controller: controller,
      keyboardType: keyboardType,

      // obscureText: isobscureText! ,
      // obscuringCharacter: obscuringCharacter! ,
      style: textStyle(fontFamily: "Poppins-M", size: 16, color: subheadingcolor),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          constraints: BoxConstraints(maxHeight: height, maxWidth: width),
          filled: true,
          fillColor: Colors.white,
          labelText: hintText,
          labelStyle: textStyle(size: 18, color: subheadingcolor),
          prefixIcon: prefixIcon,

          // suffixIcon: suffixIcon!,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primarycolor, width: 2)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primarycolor, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: subheadingcolor, width: 2))),
    );
  }
}
