import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/neu_box.dart';
import 'package:testapp/constant/switch.dart';
import 'package:testapp/constant/textstyle.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  bool ledState = true;
  bool lcdState = true;
  bool detectionState = false;
  String emotionText = "";
  late Timer _timer;
  static const String KEYNUMBER = "number";
  late String phoneNumber; // Replace with the target phone number
  final String message = "Hello, I Need Help I am Feeling Drowsy";

  final String baseUrl = 'http://192.168.100.55:5000/';

  @override
  void initState() {
    super.initState();
    _loadEmotionText();
    getNumber();
    loadSwitchStates(); // Load switch states when the widget initializes
    // Initialize ledState and lcdState to true by default
    ledState = true;
    lcdState = true;
    // Start the timer to restart the screen every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _loadEmotionText();
    });
  }

  void getNumber() async {
    var sharepref = await SharedPreferences.getInstance();
    var unumber = sharepref.getString(KEYNUMBER)!;
    phoneNumber = "+92$unumber";
  }

  void sendMessage() async {
    String url =
        "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> loadSwitchStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ledState = prefs.getBool('ledState') ?? true;
      lcdState = prefs.getBool('lcdState') ?? true;
      detectionState = prefs.getBool('detectionState') ?? false;
    });
  }

  Future<void> saveSwitchState(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _loadEmotionText() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.100.55:5000/status'));

      if (response.statusCode == 200) {
        setState(() {
          emotionText =
              response.body.trim(); // Assuming response is just "happy"
          // Apply any necessary filters
        });
      } else {
        throw Exception('Failed to load emotion status');
      }
    } catch (e) {
      print("Error loading emotion status: $e");
      // Handle error gracefully (e.g., show a dialog or retry mechanism)
    }
  }

  Future<void> sendGetRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint));
      debugPrint(
          'Response from $endpoint: ${response.statusCode} ${response.body}');
    } catch (e) {
      debugPrint('Error sending request: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timer to prevent memory leaks
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: emotionText.contains("drowsy")
          ? FloatingActionButton(
              onPressed: () {
                sendMessage();
              },
              backgroundColor: subheadingcolor,
              child: const Icon(Icons.message, color: Colors.white),
            )
          : null,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 0),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    "assets/heartrate.gif",
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.3,
                child: NeuBox(
                  thechild: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [subheadingcolor, subheadingcolor]),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Detection Switch
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Detection",
                                style: alfaSlabOneOutline(
                                    size: 18, color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              SwitchButton(
                                activecolor: Colors.black,
                                inactivecolor: primarycolor,
                                controller: ValueNotifier<bool>(detectionState),
                                activeIcon: const Icon(
                                  Icons.emoji_emotions,
                                  color: Colors.yellow,
                                ),
                                inactiveIcon: const Icon(
                                  Icons.emoji_emotions,
                                  color: Colors.black,
                                ),
                                onChange: (value) async {
                                  setState(() {
                                    detectionState = value;
                                  });
                                  await saveSwitchState(
                                      'detectionState', value);
                                  if (value) {
                                    debugPrint(
                                        'Sending Detection ON request...');
                                    sendGetRequest('start');
                                  } else {
                                    debugPrint(
                                        'Sending Detection OFF request...');
                                    sendGetRequest('stop');
                                  }
                                },
                              ),
                            ],
                          ),
                          // LED Switch
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "LIGHTS",
                                style: alfaSlabOneOutline(
                                    size: 18, color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              SwitchButton(
                                activecolor: Colors.black,
                                inactivecolor: primarycolor,
                                controller: ValueNotifier<bool>(ledState),
                                activeIcon: const Icon(
                                  Icons.light_mode,
                                  color: Colors.yellow,
                                ),
                                inactiveIcon: const Icon(
                                  Icons.light_mode,
                                  color: Colors.black,
                                ),
                                onChange: (value) async {
                                  setState(() {
                                    ledState = value;
                                  });
                                  await saveSwitchState('ledState', value);
                                  if (value) {
                                    debugPrint('Sending LED ON request...');
                                    sendGetRequest('ledon');
                                  } else {
                                    debugPrint('Sending LED OFF request...');
                                    sendGetRequest('ledoff');
                                  }
                                },
                              ),
                            ],
                          ),

                          // LCD Switch
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "SUGGESTION",
                                style: alfaSlabOneOutline(
                                    size: 18, color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              SwitchButton(
                                activecolor: Colors.black,
                                inactivecolor: primarycolor,
                                controller: ValueNotifier<bool>(lcdState),
                                activeIcon: const Icon(
                                  Icons.smart_screen,
                                  color: Colors.yellow,
                                ),
                                inactiveIcon: const Icon(
                                  Icons.smart_screen,
                                  color: Colors.black,
                                ),
                                onChange: (value) async {
                                  setState(() {
                                    lcdState = value;
                                  });
                                  await saveSwitchState('lcdState', value);
                                  if (value) {
                                    debugPrint('Sending LCD ON request...');
                                    sendGetRequest('lcdon');
                                  } else {
                                    debugPrint('Sending LCD OFF request...');
                                    sendGetRequest('lcdoff');
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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




















// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:testapp/constant/color.dart';
// import 'package:testapp/constant/neu_box.dart';
// import 'package:testapp/constant/switch.dart';
// import 'package:testapp/constant/textstyle.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => HomeState();
// }

// class HomeState extends State<Home> {
//   bool ledState = true;
//   bool lcdState = true;
//   bool detectionState = false;
  

//   final String baseUrl = 'http://192.168.100.55:5000/';
//   @override
//   void initState() {
//     super.initState();
    
//   }


//   Future<void> sendGetRequest(String endpoint) async {
//     try {
//       final response = await http.get(Uri.parse(baseUrl + endpoint));
//       debugPrint(
//           'Response from $endpoint: ${response.statusCode} ${response.body}');
//     } catch (e) {
//       debugPrint('Error sending request: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFFFFFFFF),
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 0),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20.0),
//               child: Container(
//                 color: Colors.white,
//                 child: Image.asset(
//                   "assets/heartrate.gif",
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   height: MediaQuery.of(context).size.height * 0.25,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 50),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.8,
//               height: MediaQuery.of(context).size.height * 0.3,
//               child: NeuBox(
//                 thechild: Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [subheadingcolor, subheadingcolor]),
//                     borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
                        
//                             // Start And Stop
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Detection",
//                               style: alfaSlabOneOutline(
//                                   size: 18, color: Colors.white),
//                               textAlign: TextAlign.left,
//                             ),
//                             SwitchButton(
//                               activecolor: Colors.black,
//                               inactivecolor: primarycolor,
//                               controller: ValueNotifier<bool>(detectionState),
//                               activeIcon: const Icon(
//                                 Icons.emoji_emotions,
//                                 color: Colors.yellow,
//                               ),
//                               inactiveIcon: const Icon(
//                                 Icons.emoji_emotions,
//                                 color: Colors.black,
//                               ),
//                               onChange: (value) {
//                                 setState(() {
//                                   detectionState = value;
//                                   if (value) {
//                                     debugPrint(
//                                         'Sending Detection ON request...');
//                                     sendGetRequest('start');
//                                   } else {
//                                     debugPrint(
//                                         'Sending Detection OFF request...');
//                                     sendGetRequest('stop');
//                                   }
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                         // LED Switch
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "LIGHTS",
//                               style: alfaSlabOneOutline(
//                                   size: 18, color: Colors.white),
//                               textAlign: TextAlign.left,
//                             ),
//                             SwitchButton(
//                               activecolor: Colors.black,
//                               inactivecolor: primarycolor,
//                               controller: ValueNotifier<bool>(ledState),
//                               activeIcon: const Icon(
//                                 Icons.light_mode,
//                                 color: Colors.yellow,
//                               ),
//                               inactiveIcon: const Icon(
//                                 Icons.light_mode,
//                                 color: Colors.black,
//                               ),
//                               onChange: (value) {
//                                 setState(() {
//                                   ledState = value;
//                                   if (value) {
//                                     debugPrint('Sending LED ON request...');
//                                     sendGetRequest('ledon');
//                                   } else {
//                                     debugPrint('Sending LED OFF request...');
//                                     sendGetRequest('ledoff');
//                                   }
//                                 });
//                               },
//                             ),
//                           ],
//                         ),

//                         // LCD Switch
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "SUGGESTION",
//                               style: alfaSlabOneOutline(
//                                   size: 18, color: Colors.white),
//                               textAlign: TextAlign.left,
//                             ),
//                             SwitchButton(
//                               activecolor: Colors.black,
//                               inactivecolor: primarycolor,
//                               controller: ValueNotifier<bool>(lcdState),
//                               activeIcon: const Icon(
//                                 Icons.smart_screen,
//                                 color: Colors.yellow,
//                               ),
//                               inactiveIcon: const Icon(
//                                 Icons.smart_screen,
//                                 color: Colors.black,
//                               ),
//                               onChange: (value) {
//                                 setState(() {
//                                   lcdState = value;
//                                   if (value) {
//                                     debugPrint('Sending LCD ON request...');
//                                     sendGetRequest('lcdon');
//                                   } else {
//                                     debugPrint('Sending LCD OFF request...');
//                                     sendGetRequest('lcdoff');
//                                   }
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
                        
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// } 
