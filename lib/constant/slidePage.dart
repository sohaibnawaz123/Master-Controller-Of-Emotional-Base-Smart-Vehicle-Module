// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/textstyle.dart';

class SlidePage extends StatelessWidget {
  final String heading1;
  final String heading2;
  final String image;
  const SlidePage({
    super.key,
    required this.heading1,
    required this.heading2,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      image,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    heading1,
                    style: alfaSlabOne(fontFamily: "Poppins-B", size: 32 ,color: subheadingcolor),textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        heading2,
                        style: textStyle(
                            fontFamily: "Poppins-R",
                            size: 15,
                            color: textcolor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ]),
        ),
      ),
    );
  }
}
