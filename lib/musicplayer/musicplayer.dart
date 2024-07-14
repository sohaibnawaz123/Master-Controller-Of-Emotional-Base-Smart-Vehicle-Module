import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/constant/color.dart';
import 'package:testapp/constant/neu_box.dart';
import 'package:testapp/musicplayer/playlist_provider.dart';
import 'package:testapp/constant/textstyle.dart';

class MusicPlayer2 extends StatelessWidget {
  const MusicPlayer2({super.key});
  String formatTime(Duration duration) {
    String twodigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2 , "0");
    String formattedTime = "${duration.inMinutes}:$twodigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (BuildContext context, PlaylistProvider value, Widget? child) {
        //get playlist
        final playlist = value.playlist;

        //got current song
        final currentSong = playlist[value.currentSongIndex ?? 0];

        return Scaffold(
          
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
                backgroundColor: subheadingcolor,
                title: Text(
                  "M U S I C-P L A Y E R",
                  style: alfaSlabOneOutline(
                      fontFamily: "Rubik-B", size: 30, color: Colors.white),
                )),
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    //Menu And back Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 40,
                              height: 40,
                              child: NeuBox(
                                thechild: IconButton(
                                  padding: const EdgeInsets.all(0.0),
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.arrow_back),
                                ),
                              )),
                          
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Image
                    SizedBox(
                      width: 300,
                      child: NeuBox(
                        thechild: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  height: 250,
                                  child: Image.asset(
                                    currentSong.albumPath,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentSong.songName,
                                      style: textStyle(
                                          fontFamily: "Poppins-B",
                                          size: 18,
                                          color: textColor),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      currentSong.artistName,
                                      style: textStyle(
                                          fontFamily: "Poppins-M",
                                          size: 14,
                                          color: const Color.fromARGB(
                                              190, 0, 0, 0)),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 25,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          formatTime(value.currentDuration),
                          style: textStyle(fontFamily:"Poppins-M" , size: 16, color: Colors.black87),
                        ),
                        const Icon(
                          Icons.shuffle,
                          size: 25,
                        ),
                        const Icon(
                          Icons.repeat,
                          size: 25,
                        ),
                        Text(
                          formatTime(value.totalDuration),
                          style: textStyle(fontFamily: "Poppins-M", size: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    NeuBox(
                        thechild: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0)),
                      child: SizedBox(
                        height: 10,
                        child: Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          activeColor: subheadingcolor,
                          onChanged: (double double) {},
                          onChangeEnd: (double double) {
                            value.seek(Duration(seconds: double.toInt()));
                          },
                          value: value.currentDuration.inSeconds.toDouble(),
                        ),
                      ),
                    )),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: NeuBox(
                            thechild: GestureDetector(
                              onTap: value.playPreviousSong,
                              child: const Icon(
                                Icons.skip_previous,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: NeuBox(
                              thechild: GestureDetector(
                                onTap: value.pauseOrResume,
                                child: Icon(
                                  value.isplaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: NeuBox(
                            thechild: GestureDetector(
                              onTap: value.playNextSong,
                              child: const Icon(
                                Icons.skip_next,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
