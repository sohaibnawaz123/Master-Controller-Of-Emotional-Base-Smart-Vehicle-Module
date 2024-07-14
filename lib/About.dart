// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/textstyle.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -1),
      color: const Color(0xFFFFFFFF),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      border: Border.symmetric(
                          horizontal:
                              BorderSide(width: 3.0, color: subheadingcolor))),
                  child: Text(
                    "ABOUT PROJECT",
                    style: alfaSlabOne(
                      fontFamily: "Poppins-B",
                        size: 32,
                        color: subheadingcolor),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(
                height: 10.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    "assets/project.jpg",
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              // About Project
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "Our innovative automotive system analyzes facial expressions to recommend personalized driving speeds, dynamically adjusts ambient lighting and suggests tailored music based on the driver's emotions. It also serves as a safety feature, detecting drowsiness through light variations and initiating assistance calls via a connected app. Integrated Smart Watch vitals enhance the accuracy of emotion and drowsiness detection, redefining the driving experience with a seamless blend of safety, comfort, and entertainment.",
                  style: textStyle(
                      fontFamily: "Poppins-R", size: 14, color: headingcolor),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      border: Border.symmetric(
                          horizontal:
                              BorderSide(width: 3.0, color: subheadingcolor))),
                  child: Text(
                    "ABOUT TEAM",
                    style: alfaSlabOne(
                      fontFamily: "Poppins-B",
                        size: 32,
                        color: subheadingcolor),
                    textAlign: TextAlign.center,
                  )),

              // 1st person Info
              const SizedBox(
                height: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Icon(
                        Icons.person,
                        size: 70.0,
                        color: subheadingcolor,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 3,color:headingcolor ))
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "SIR IQBALUDIN KHAN",
                              style: alfaSlabOne(fontFamily: "Poppins-M", size: 22, color: headingcolor)),
                          TextSpan(
                              text: "\nInternal Superviser",
                              style: textStyle(fontFamily: "Poppins-R", size: 16, color: headingcolor))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "As an internal supervisor of our project and an esteemed Assistant Professor, Sir Iqbal brings invaluable expertise in software engineering. His role as the Coordinator of the Computer Science program and Deputy Manager of IRD further enhances his capability to guide us effectively. We are eager to benefit from his profound knowledge and mentorship throughout our project journey.",
                  style: textStyle(
                      fontFamily: "Rubik-R", size: 16, color: headingcolor),
                ),
              ),
              // 2nd person Info
              const SizedBox(
                height: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Icon(
                        Icons.person,
                        size: 70.0,
                        color: subheadingcolor,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 3,color:headingcolor ))
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "FAIZAN HUSSAIN",
                              style: alfaSlabOne(fontFamily: "Poppins-M", size: 22, color: headingcolor)),
                          TextSpan(
                              text: "\nExternal Superviser",
                              style: textStyle(fontFamily: "Poppins-R", size: 16, color: headingcolor))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "As our project's external supervisor, Faizan Hussain's expertise as a researcher, technical report writer, and documentation specialist provides invaluable guidance. With his experience, we anticipate receiving insightful feedback and direction to enhance the quality and effectiveness of our project. We look forward to collaborating with him to achieve our project goals.",
                  style: textStyle(
                      fontFamily: "Rubik-R", size: 16, color: headingcolor),
                ),
              ),
              // 3rd person Info
              const SizedBox(
                height: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Icon(
                        Icons.person,
                        size: 70.0,
                        color: subheadingcolor,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 3,color:headingcolor ))
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "DUAA LODHI",
                              style: alfaSlabOne(fontFamily: "Poppins-M", size: 22, color: headingcolor)),
                          TextSpan(
                              text: "\nTeam Lead & Researcher",
                              style: textStyle(fontFamily: "Poppins-R", size: 16, color: headingcolor))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "My name is Duaa Lodhi, and I am a student pursuing a Bachelor's degree in Software Engineering. I have skills in ASP.NET, C#, and Python, and have completed various projects, including our final year project, the \"Driver's Emotion-Based Smart Vehicle Module.\"",
                  style: textStyle(
                      fontFamily: "Rubik-R", size: 16, color: headingcolor),
                ),
              ),
              // 4th person Info
              const SizedBox(
                height: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Icon(
                        Icons.person,
                        size: 70.0,
                        color: subheadingcolor,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 3,color:headingcolor ))
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "AMEENA LODHI",
                              style: alfaSlabOne(fontFamily: "Poppins-M", size: 22, color: headingcolor)),
                          TextSpan(
                              text: "\nDeveloper & Researcher",
                              style: textStyle(fontFamily: "Poppins-R", size: 16, color: headingcolor))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "My name is Ameena Lodhi, and I am currently studying for a Bachelor's degree in Software Engineering. I possess skills in ASP.NET, C#, Python, and SQL, and have successfully completed several projects. One of my key projects is our final year project, the \"Driver's Emotion-Based Smart Vehicle Module.\"",
                  style: textStyle(
                      fontFamily: "Rubik-R", size: 16, color: headingcolor),
                ),
              ),
              // 5th person Info
              const SizedBox(
                height: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: const Icon(
                        Icons.person,
                        size: 70.0,
                        color: subheadingcolor,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 3,color:headingcolor ))
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "SOHAIB NAWAZ",
                              style: alfaSlabOne(fontFamily: "Poppins-M", size: 22, color: headingcolor)),
                          TextSpan(
                              text: "\nDeveloper & UI/UX Designer",
                              style: textStyle(fontFamily: "Poppins-R", size: 16, color: headingcolor))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "My name is Sohaib Nawaz, and I am currently pursuing a Bachelor's degree in Software Engineering. I have skills in Flutter, HTML, CSS, JavaScript, and WordPress, and have successfully completed several projects. One of my key projects is our final year project, the \"Driver's Emotion-Based Smart Vehicle Module.\"",
                  style: textStyle(
                      fontFamily: "Rubik-R", size: 16, color: headingcolor),
                ),
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
