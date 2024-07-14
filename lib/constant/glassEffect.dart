// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/material.dart';

class GlassEffect extends StatelessWidget {
  final double radius;
  final double blur;
  final double width;
  final double height;
  final Widget theChild;
  const GlassEffect({super.key, required this.radius, required this.blur, required this.width, required this.height, required this.theChild,});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * width,
          height: MediaQuery.of(context).size.height * height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                  ]),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
              )),
          child: theChild,
        ),
      ),
    );
  }
}
