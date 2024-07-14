import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:testapp/musicplayer/songs.dart';

class PlaylistProvider extends ChangeNotifier {
  

  final List<Song> _playlist = [
    Song(
        songName: "Jaanay Iss Dil",
        artistName: "",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Jaanay Iss Dil.mp3",
        bpm: 90),
    Song(
        songName: "Kings & Queens",
        artistName: "Ava Max",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Ava Max - Kings & Queens (low).mp3",
        bpm: 90),
    Song(
        songName: "Sweet but Psycho",
        artistName: "Ava Max",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Ava Max - Sweet but Psycho (Low).mp3",
        bpm: 90),
    Song(
        songName: "So Far Away",
        artistName: "Avenged Sevenfold",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Avenged Sevenfold - So Far Away [Low].mp3",
        bpm: 90),
    Song(
        songName: "Flowers",
        artistName: "Miley Cyrus",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Miley Cyrus - Flowers (low).mp3",
        bpm: 90),
    Song(
        songName: "PassengerLet Her Go",
        artistName: "Passenger",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Passenger  Let Her Go(low).mp3",
        bpm: 90),
    Song(
        songName: "At My Worst",
        artistName: "Pink Sweat",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Pink Sweat - At My Worst (low).mp3",
        bpm: 90),
    Song(
        songName: "Dusk Till Dawn",
        artistName: "ZAYN & Sia",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/ZAYN & Sia - Dusk Till Dawn (Low).mp3",
        bpm: 90),
    Song(
        songName: "alan-walker-alone",
        artistName: "alan-walker",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/alan-walker-alone.mp3",
        bpm: 100),
    Song(
        songName: "let-me-down-slowly",
        artistName: "",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/let-me-down-slowly.mp3",
        bpm: 150),
    Song(
        songName: "My Passion",
        artistName: "AKcent",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Akcent - My Passion ( official video ).mp3",
        bpm: 120),
    Song(
        songName: "Faded",
        artistName: "Alan Walker",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Alan Walker - Faded.mp3",
        bpm: 120),
    Song(
        songName: "Dancing On My Own",
        artistName: "Calum Scott",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Calum Scott - Dancing On My Own.mp3",
        bpm: 120),
    Song(
        songName: "Love Me Like You Do",
        artistName: "Ellie Goulding",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Ellie Goulding - Love Me Like You Do (Lyrics).mp3",
        bpm: 120),
    Song(
        songName: "Luis Fonsi - Despacito High",
        artistName: "Luis Fonsi",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Luis Fonsi - Despacito High.mp3",
        bpm: 120),
    Song(
        songName: "OneRepublic",
        artistName: "",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/OneRepublic - I Aint Worried (From Top Gun_ Maverick) [Official Music Video] high.mp3",
        bpm: 120),
    Song(
        songName: "Calm Down",
        artistName: "Rema, Selena Gomez",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Rema, Selena Gomez - Calm Down (Official Music Video).mp3",
        bpm: 120),
    Song(
        songName: "The Greatest",
        artistName: "Sia",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Sia - The Greatest (Lyrics).mp3",
        bpm: 120),
    Song(
        songName: "Unstoppable",
        artistName: "Sia",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Sia - Unstoppable (Official Video - Live from the Nostalgic For The Present Tour).mp3",
        bpm: 120),
    Song(
        songName: "Dance Monkey",
        artistName: "Tones and I ",
        albumPath: "assets/albumimg/music.jpg",
        audioPath: "audio/Tones and I - Dance Monkey (Lyrics).mp3",
        bpm: 120),
  ];
  
  

  //audioplayer
  final AudioPlayer _audioPlayer = AudioPlayer();
  //duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider() {
    ListenToDuration();
  }
  //initially playing
  bool _isplaying = false;

  filteredSongs() => null;

  //play song
  void play() async {
    final String path = playlist[currentSongIndex!].audioPath;
    await _audioPlayer.stop(); //stop songs
    await _audioPlayer.play(AssetSource(path));
    _isplaying = true;
    notifyListeners();
  }

  //pausesong
  void pause() async {
    await _audioPlayer.pause();
    _isplaying = false;
    notifyListeners();
  }

  //resume
  void resume() async {
    await _audioPlayer.resume();
    _isplaying = true;
    notifyListeners();
  }

  //pause&resume button
  void pauseOrResume() async {
    _isplaying ? pause() : resume();
    notifyListeners();
  }

  //seek
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  //previous song
  void playPreviousSong() {
    if (_currentDuration.inSeconds > 3) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        _currentSongIndex = currentSongIndex! - 1;
      } else {
        _currentSongIndex = _playlist.length - 1;
      }
    }
    notifyListeners();
  }

  //Listen to duration
  void ListenToDuration() {
    //duration listener
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //positionlistner
    _audioPlayer.onPositionChanged.listen((newposition) {
      _currentDuration = newposition;
      notifyListeners();
    });

    //complete
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  int? _currentSongIndex;

  //Getter
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isplaying => _isplaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //Setter
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
