import 'package:flutter/material.dart';
import 'package:testapp/constant/color.dart';
import 'textstyle.dart';

class ImageBox extends StatelessWidget {
  final double imgborder;
  final String imgurl;
  final String tittle;
  final String desc;
  const ImageBox(
      {super.key,
      required this.imgborder,
      required this.imgurl,
      required this.tittle,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.85,
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(imgborder),
            child: Image.asset(
              imgurl,
              fit: BoxFit.cover,height: 250,width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            tittle,
            style: textStyle( fontFamily: "Rubik-M", size:35, color:subheadingcolor,),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: textStyle(size:20,color: textcolor,),
            ),
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}
