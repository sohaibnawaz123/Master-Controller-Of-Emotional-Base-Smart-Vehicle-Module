// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/slidePage.dart';
import 'package:testapp/constant/textstyle.dart';
import 'package:testapp/number.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

bool onLastpage = false;
PageController _controller = PageController();

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
                alignment: Alignment.center,
                children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                onLastpage = (value == 3);
              });
            },
            controller: _controller,
            children: const [
              SlidePage(
                image: "assets/lights.gif",
                heading1: "AMBIENT LIGHT'S",
                heading2:
                    "In the \"Driver's Emotion-Based Smart Vehicle Module\" project, ambient lights are used to reflect the driver\'s emotions, such as sadness, happiness, or anger. This enhances the driver\'s experience by visually representing their emotional state.",
              ),
              SlidePage(
                image: "assets/music_.gif",
                heading1: "MUSIC",
                heading2:
                    "In the \"Driver's Emotion-Based Smart Vehicle Module\" project, music is tailored to reflect the driver's emotions, such as sadness, happiness, or anger. Low BPM music for calmer emotions and high BPM music for more intense emotions. This system aims to enhance the driver's experience by aligning the music with their emotional state.",
              ),
              SlidePage(
                image: "assets/Voice.gif",
                heading1: "SUGGESTION",
                heading2:
                    "In the \"Driver's Emotion-Based Smart Vehicle Module\" project, driving suggestions are provided based on the driver's emotions, such as sadness, happiness, or anger. A Raspberry Pi detects these emotions and displays tailored suggestions to improve safety and comfort.",
              ),
              SlidePage(
                image: "assets/drowsinesss.gif",
                heading1: "DROWSINESS DETECTION",
                heading2:
                    "In the \"Driver's Emotion-Based Smart Vehicle Module\" project, the system detects the driver's drowsiness and automatically sends a message to a hotline via an Android application. This feature aims to enhance safety by providing timely alerts and assistance when the driver is at risk of falling asleep.",
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
            child: Container(alignment:const Alignment(0.0, 0.9) ,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      child: Text("SKIP",
                          style: alfaSlabOne(fontFamily: "Poppins-B", size: 20,color: subheadingcolor),
                          textAlign: TextAlign.center),
                      onTap: () {
                        // wheretogo();
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const MyPhone(),
                                type: PageTransitionType.scale,
                                alignment: Alignment.bottomCenter,
                                duration: const Duration(seconds: 2)));
                      }),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const ExpandingDotsEffect(
                      dotWidth:15 ,dotHeight: 15,
                      radius: 5,
                        dotColor: secondarycolor, activeDotColor: subheadingcolor),
                  ),
                  onLastpage
                      ? GestureDetector(
                          onTap: () => {
                                // wheretogo()
                                Navigator.push(context,
                                    PageTransition(
                                child: const MyPhone(),
                                type: PageTransitionType.scale,
                                alignment: Alignment.bottomRight,
                                duration: const Duration(seconds: 2),
                                curve: Curves.ease))
                              },
                          child:Text("DONE",
                              style: alfaSlabOne(fontFamily: "Poppins-B",size: 20,color: subheadingcolor),
                              textAlign: TextAlign.center))
                      : GestureDetector(
                          onTap: () => {
                                _controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn)
                              },
                          child:Text("NEXT",
                              style: alfaSlabOne(fontFamily: "Poppins-B",size: 20,color: subheadingcolor),
                              textAlign: TextAlign.center))
                ],
              ),
            ),
          )
                ],
              ),
        ));
  }
}
