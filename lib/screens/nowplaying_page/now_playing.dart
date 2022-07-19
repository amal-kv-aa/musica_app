import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:musica_app/screens/favorite_page/favoritebutton/favbutton.dart';
import 'package:musica_app/screens/nowplaying_page/bottomsheet/bottomsheet.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Nowplaying extends StatelessWidget {
  Nowplaying({Key? key, required this.songs}) : super(key: key);
  List<SongModel>? songs = [];
  @override
  Widget build(BuildContext context) {
    final read = context.read<NowplayProvider>();
    final watch = context.watch<NowplayProvider>();
    read.updatesonglist(songs!);
    read.listenstream();
    final themechange = Provider.of<Themeset>(context);
    final id = songs![watch.currentIndex].id;
    return Scaffold(
      body: Container(
        decoration: themechange.themvalue == 0
            ? const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/music.jpg'),
                    fit: BoxFit.cover))
            : BoxDecoration(
                gradient:
                    themechange.themvalue == 1 || themechange.themvalue == null
                        ? const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topLeft,
                            colors: [
                                Color.fromARGB(255, 0, 0, 0),
                                Color.fromARGB(255, 0, 0, 0),
                              ])
                        : const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topLeft,
                            colors: [
                                Color.fromARGB(255, 122, 0, 57),
                                Color.fromARGB(255, 11, 219, 226),
                              ])),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 40,
                      color: themechange.themvalue == 2
                          ? const Color.fromARGB(255, 86, 10, 35)
                          : const Color.fromARGB(255, 38, 225, 218),
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            GestureDetector(
              onHorizontalDragEnd: (dragDownDetails) {
                read.gesture(dragDownDetails);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: themechange.themvalue != 2
                              ? const Color.fromARGB(255, 7, 253, 241)
                              : const Color.fromARGB(255, 0, 201, 251)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 16,
                            color: themechange.themvalue != 2
                                ? const Color.fromARGB(255, 108, 235, 244)
                                : const Color.fromARGB(255, 12, 93, 117),
                            offset: const Offset(0, 0))
                      ],
                      color: const Color.fromARGB(255, 252, 255, 255)
                          .withOpacity(0),
                      borderRadius: BorderRadius.circular(50)),
                  child:  Consumer<NowplayProvider>(
                    builder: (context, value, child) {
                      return
                      QueryArtworkWidget(
                            id: value.itemlist[value.player.currentIndex!].id ,
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(50),
                            artworkFit: BoxFit.cover,
                            artworkQuality: FilterQuality.high,
                            );
                    },
                     
                  ),
                    
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Consumer<NowplayProvider>(
                        builder: (context, value, child) {
                          return Marquee(
                            text: songs![value.player.currentIndex!]
                                .title
                                .replaceAll(RegExp('_'), '')
                                .replaceAll(RegExp('-'), ''),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            velocity: 50,
                            pauseAfterRound: const Duration(seconds: 4),
                          );
                        },
                      ),
                    ),
                  ),
                  Consumer<NowplayProvider>(
                    builder: (context, value, child) => Text(
                      songs![value.player.currentIndex!].artist ?? 'Unknown',
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color.fromARGB(255, 205, 205, 205)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: StreamBuilder<DurationState>(
                stream: watch.durationStateStream,
                builder: (context, snapshot) {
                  final durationState = snapshot.data;
                  final progress = durationState?.position ?? Duration.zero;
                  final total = durationState?.total ?? Duration.zero;
                  return
                      //============================progressBar========================//
                      ProgressBar(
                    progress: progress,
                    total: total,
                    barHeight: 2,
                    progressBarColor: const Color.fromARGB(255, 74, 231, 249),
                    baseBarColor: const Color.fromARGB(255, 255, 255, 255),
                    thumbColor: const Color.fromARGB(255, 49, 255, 252),
                    timeLabelTextStyle: const TextStyle(color: Colors.white),
                    onSeek: (duration) {
                      context.read<NowplayProvider>().player.seek(duration);
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      read.playPreviouse();
                    },
                    icon: const Icon(
                      Icons.skip_previous_outlined,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
                InkWell(
                  onTap: () async {
                    read.playPause();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(255, 6, 170, 159),
                              Color.fromARGB(255, 224, 224, 224),
                            ]),
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 0, 204, 255))),
                    child: StreamBuilder<bool>(
                      stream: watch.player.playingStream,
                      builder: ((context, snapshot) {
                        bool? playingState = snapshot.data;
                        if (playingState != null && playingState) {
                          return const Icon(
                            Icons.pause,
                            size: 40,
                            color: Colors.white,
                          );
                        }
                        return const Icon(
                          Icons.play_arrow_outlined,
                          size: 40,
                          color: Colors.white,
                        );
                      }),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      read.playNext();
                    },
                    icon: const Icon(
                      Icons.skip_next_outlined,
                      color: Colors.white,
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        BottomSheets.showmodel(context, id);
                      },
                      icon: const Icon(
                        Icons.playlist_add,
                        color: Color.fromARGB(255, 17, 156, 156),
                      )),
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      read.repeatesong();
                    },
                    child: StreamBuilder<LoopMode>(
                      stream: watch.player.loopModeStream,
                      builder: (context, snapshot) {
                        final newLoopMod = snapshot.data;
                        if (LoopMode.one == newLoopMod) {
                          return const Icon(
                            Icons.repeat_one,
                            color: Color.fromARGB(255, 27, 203, 222),
                          );
                        } else {
                          return const Icon(
                            Icons.repeat,
                            color: Colors.white,
                          );
                        }
                      },
                    ),
                  )),
                  ButtonFav(
                    id: id,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
