class Song {
  final String songName;
  final String artistName;
  final String albumPath;
  final String audioPath;
  final num bpm;

  Song({required this.bpm, 
      required this.songName,
      required this.artistName,
      required this.albumPath,
      required this.audioPath});
}
