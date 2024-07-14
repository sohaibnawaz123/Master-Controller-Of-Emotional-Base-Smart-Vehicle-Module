import 'dart:async'; // Import dart:async for Timer
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/musicplayer/playlist_provider.dart';
import 'package:testapp/musicplayer/songs.dart';
import 'package:testapp/musicplayer/musicplayer.dart';
import 'package:http/http.dart' as http;


class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  late final PlaylistProvider playlistProvider;
  FilterType activeFilter = FilterType.all;
  // late String emotionText;
  String emotionText = "";
  late Timer _timer; // Timer variable
  
  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    _loadEmotionText();
    // Initialize and start the timer
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _loadEmotionText();
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timer to prevent memory leaks
    _timer.cancel();
  }


  Future<void> _loadEmotionText() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.100.55:5000/status'));

      if (response.statusCode == 200) {
        setState(() {
          emotionText =
              response.body.trim(); // Assuming response is just "happy"
          _applyFilter(); // Apply any necessary filters
        });
      } else {
        throw Exception('Failed to load emotion status');
      }
    } catch (e) {
      print("Error loading emotion status: $e");
      // Handle error gracefully (e.g., show a dialog or retry mechanism)
    }
  }

  void _applyFilter() {
    if (emotionText.toLowerCase().contains("happy")) {
      _onFilterPressed(FilterType.highBpm);
    } else if (emotionText.toLowerCase().contains("neutral")) {
      _onFilterPressed(FilterType.highBpm);
    } else if (emotionText.toLowerCase().contains("sad")) {
      _onFilterPressed(FilterType.lowBpm);
    } else {
      _onFilterPressed(FilterType.all);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: const MusicPlayer2(),
              type: PageTransitionType.scale,
              alignment: Alignment.center,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            ),
          );
        },
        backgroundColor: subheadingcolor,
        child: const Icon(Icons.music_note_rounded, color: Colors.white),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Container(
                height: 70,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      style: BorderStyle.solid,
                      color: subheadingcolor,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => _onFilterPressed(FilterType.all),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color>((states) {
                          return activeFilter == FilterType.all
                              ? Colors.black
                              : Colors.white;
                        }),
                      ),
                      child: const Text('ALL'),
                    ),
                    ElevatedButton(
                      onPressed: () => _onFilterPressed(FilterType.lowBpm),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color>((states) {
                          return activeFilter == FilterType.lowBpm
                              ? Colors.black
                              : Colors.white;
                        }),
                      ),
                      child: const Text('Low BPM'),
                    ),
                    ElevatedButton(
                      onPressed: () => _onFilterPressed(FilterType.highBpm),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color>((states) {
                          return activeFilter == FilterType.highBpm
                              ? Colors.black
                              : Colors.white;
                        }),
                      ),
                      child: const Text('High BPM'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _getFilteredPlaylist().length,
                  itemBuilder: (context, index) {
                    final Song song = _getFilteredPlaylist()[index];
                    return ListTile(
                      title: Text(song.songName),
                      subtitle: Text(song.artistName),
                      leading: Image.asset(song.albumPath),
                      onTap: () => _onToSong(index),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onFilterPressed(FilterType filterType) {
    setState(() {
      activeFilter = filterType;
    });
  }

  List<Song> _getFilteredPlaylist() {
    if (activeFilter == FilterType.lowBpm) {
      return playlistProvider.playlist.where((song) => song.bpm < 100).toList();
    } else if (activeFilter == FilterType.highBpm) {
      return playlistProvider.playlist
          .where((song) => song.bpm >= 100)
          .toList();
    }
    return playlistProvider.playlist;
  }

  void _onToSong(int? songindex) {
    final originalIndex =
        playlistProvider.playlist.indexOf(_getFilteredPlaylist()[songindex!]);
    playlistProvider.currentSongIndex = originalIndex;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MusicPlayer2()),
    );
  }
}

enum FilterType {
  all,
  lowBpm,
  highBpm,
}

// import 'dart:async'; // Import dart:async for Timer
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import 'package:testapp/constant/color.dart';
// import 'package:testapp/musicplayer/playlist_provider.dart';
// import 'package:testapp/musicplayer/songs.dart';
// import 'package:testapp/musicplayer/musicplayer.dart';
// import 'package:flutter/services.dart' show rootBundle;

// class SongList extends StatefulWidget {
//   const SongList({super.key});

//   @override
//   State<SongList> createState() => _SongListState();
// }

// class _SongListState extends State<SongList> {
//   late final PlaylistProvider playlistProvider;
//   FilterType activeFilter = FilterType.all;
//   late String emotionText;
//   late Timer _timer; // Timer variable

//   @override
//   void initState() {
//     super.initState();
//     playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
//     _loadEmotionText();
//     // // Initialize and start the timer
//     // _timer = Timer.periodic(const Duration(seconds: 15), (_) {
//     //   _loadEmotionText();
//     // });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // Cancel the timer to prevent memory leaks
//     _timer.cancel();
//   }

//   Future<void> _loadEmotionText() async {
//     try {
//       final String text = await rootBundle.loadString("emotion_text/emotion_recognition.txt");
//       setState(() {
//         emotionText = text;
//         _applyFilter();
//       });
//     } catch (e) {
//       // ignore: avoid_print
//       print("Error loading emotion text: $e");
//     }
//   }

//   void _applyFilter() {
//     if (emotionText.toLowerCase().contains("happy")) {
//       _onFilterPressed(FilterType.highBpm);
//     } else if (emotionText.toLowerCase().contains("neutral")) {
//       _onFilterPressed(FilterType.highBpm);
//     } else if (emotionText.toLowerCase().contains("sad")) {
//       _onFilterPressed(FilterType.lowBpm);
//     } else {
//       _onFilterPressed(FilterType.all);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             PageTransition(
//               child: const MusicPlayer2(),
//               type: PageTransitionType.scale,
//               alignment: Alignment.center,
//               duration: const Duration(seconds: 1),
//               curve: Curves.ease,
//             ),
//           );
//         },
//         backgroundColor: subheadingcolor,
//         child: const Icon(Icons.music_note_rounded,color: Colors.white,),
//       ),
//       backgroundColor: const Color(0xFFFFFFFF),
//       body: Consumer<PlaylistProvider>(
//         builder: (context, value, child) {
//           return Column(
//             children: [
//               Container(
//                 height: 70,
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       width: 2,
//                       style: BorderStyle.solid,
//                       color: subheadingcolor,
//                     ),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () => _onFilterPressed(FilterType.all),
//                       style: ButtonStyle(
//                         backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
//                           return activeFilter == FilterType.all ? Colors.black : Colors.white;
//                         }),
//                       ),
//                       child: const Text('ALL'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () => _onFilterPressed(FilterType.lowBpm),
//                       style: ButtonStyle(
//                         backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
//                           return activeFilter == FilterType.lowBpm ? Colors.black : Colors.white;
//                         }),
//                       ),
//                       child: const Text('Low BPM'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () => _onFilterPressed(FilterType.highBpm),
//                       style: ButtonStyle(
//                         backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
//                           return activeFilter == FilterType.highBpm ? Colors.black : Colors.white;
//                         }),
//                       ),
//                       child: const Text('High BPM'),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _getFilteredPlaylist().length,
//                   itemBuilder: (context, index) {
//                     final Song song = _getFilteredPlaylist()[index];
//                     return ListTile(
//                       title: Text(song.songName),
//                       subtitle: Text(song.artistName),
//                       leading: Image.asset(song.albumPath),
//                       onTap: () => _onToSong(index),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   void _onFilterPressed(FilterType filterType) {
//     setState(() {
//       activeFilter = filterType;
//     });
//   }

//   List<Song> _getFilteredPlaylist() {
//     if (activeFilter == FilterType.lowBpm) {
//       return playlistProvider.playlist.where((song) => song.bpm < 100).toList();
//     } else if (activeFilter == FilterType.highBpm) {
//       return playlistProvider.playlist.where((song) => song.bpm >= 100).toList();
//     }
//     return playlistProvider.playlist;
//   }

//   void _onToSong(int? songindex) {
//     final originalIndex = playlistProvider.playlist.indexOf(_getFilteredPlaylist()[songindex!]);
//     playlistProvider.currentSongIndex = originalIndex;
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const MusicPlayer2()),
//     );
//   }
// }

// enum FilterType {
//   all,
//   lowBpm,
//   highBpm,
// }

//   Future<void> _loadEmotionText() async {
//   try {
//     final response = await http.get(Uri.parse('http://192.168.100.55:5000/status'));

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> jsonResponse = json.decode(response.body);

//       if (jsonResponse.containsKey('status')) {
//         setState(() {
//           emotionText = jsonResponse['status'] as String;
//           _applyFilter(); // Ensure this method is correctly implemented
//         });
//       } else {
//         throw FormatException('Missing status field in JSON');
//       }
//     } else {
//       throw Exception('Failed to load emotion status');
//     }
//   } catch (e) {
//     print("Error loading emotion status: $e");
//     // Handle error gracefully (e.g., show a dialog or retry mechanism)
//   }
// }
