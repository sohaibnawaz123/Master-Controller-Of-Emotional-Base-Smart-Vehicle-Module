// ignore_for_file: file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:testapp/About.dart';
import 'package:testapp/Setting.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/musicplayer/Songlist.dart';
import 'package:testapp/constant/textstyle.dart';
import 'package:testapp/homeScreen.dart';
// import 'package:testapp/musicplayer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentindex = 0;
  final PageController _controller_2 = PageController();
  final _pages = [
    const Home(),
    const SongList(),
    const AboutScreen(),
    const SettingScreen()
  ];

  // ignore: non_constant_identifier_names
  List pg_titles = ["HOME", "PLAY LIST", 'ABOUT', 'SETTING'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar Designs
      appBar: AppBar(
        automaticallyImplyLeading: false,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(3.0),
            child: Container(
              color: subheadingcolor,
              height: 4.0,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 50.0,
          backgroundColor:subheadingcolor,
          title: Text(
            pg_titles[currentindex],
            style: alfaSlabOneOutline(
                size: 30,
                color: Colors.white),
          )),
      // Bottom bar Design
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: const Color(0xFFECF9FF),
          color: subheadingcolor,
          index: currentindex,
          onTap: (index) {
            setState(() {
              currentindex = index;
              _controller_2.animateToPage(currentindex,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeOutQuad);
            });
          },
          items: const [
            Icon(
              Icons.home_filled,
              color: Color(0xFFECF9FF),
            ),
            Icon(Icons.music_note, color: Color(0xFFECF9FF)),
            Icon(Icons.person_2_rounded, color: Color(0xFFECF9FF)),
            Icon(Icons.settings, color: Color(0xFFECF9FF)),
            
          ]),

      // page selection  Container(child: pages[currentindex])
      body: PageView(
        controller: _controller_2,
        onPageChanged: (index) {
          setState(() {
            currentindex = index;
          });
        },
        children: _pages,
      ),
    );
  }
}
