import 'dart:developer';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musica_app/screens/favorite_page/view/widget/favoritebutton/favbutton.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/nowplaying_page/view/widgets/bottomsheet/bottomsheet.dart';
import 'package:musica_app/screens/nowplaying_page/view/widgets/playpause_button/playpauseicon.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Nowplaying extends StatelessWidget {
  const Nowplaying({
    Key? key,
    this.ontap
  }) : super(key: key);
  final  Function ? ontap;
  @override
  Widget build(BuildContext context) {
    final read = context.read<NowplayProvider>();
    final provider = context.watch<NowplayProvider>();
    log("entered");
    return 
       Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: provider.palletColor?.mutedColor?.color ?? Colors.black,
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
                        ontap ?? Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 40,
                      )),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onHorizontalDragEnd: (dragDownDetails) {
                  provider.gesture(dragDownDetails);
                },
               child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.37,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      child:  QueryArtworkWidget(
                            id: provider.itemlist[provider.player.currentIndex!].id,
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(50),
                            artworkFit: BoxFit.cover,
                            artworkQuality: FilterQuality.high,
                          
                        
                      )),
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
                        // child: Consumer<NowplayProvider>(
                        //   builder: (context, value, child) {
                        //     return Marquee(
                        //       text: value
                        //           .itemlist[value.player.currentIndex!].title
                        //           .replaceAll(RegExp('_'), '')
                        //           .replaceAll(RegExp('-'), ''),
                        //       style: const TextStyle(color: Colors.white),
                        //       velocity: 50,
                        //       pauseAfterRound: const Duration(seconds: 4),
                        //     );
                         // },
                        //),
                      ),
                    ),
                    // Consumer<NowplayProvider>(builder: (context, value, child) {
                    //   return Text(
                    //     value.itemlist[value.player.currentIndex!].artist ??
                    //         'Unknown',
                    //     style: const TextStyle(
                    //         overflow: TextOverflow.ellipsis, color: Colors.white),
                    //   );
                    // }),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: StreamBuilder<DurationState>(
                  stream: provider.durationStateStream,
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
                      progressBarColor: Colors.white,
                      thumbColor: Colors.white,
                      bufferedBarColor: Colors.black,
                      baseBarColor: Colors.white30,
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
                      )),
                  InkWell(
                      onTap: () async {
                        read.playPause();
                      },
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: const PlayPauseIcon(
                            size: 40,
                          ))),
                  IconButton(
                      onPressed: () {
                        read.playNext();
                      },
                      icon: const Icon(
                        Icons.skip_next_outlined,
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
                          BottomSheets.showmodel(
                            context,
                            provider.itemlist[provider.currentIndex].id,
                          );
                        },
                        icon: const Icon(
                          Icons.playlist_add,
                        )),
                    Flexible(
                        child: InkWell(
                      onTap: () {
                        context.read<NowplayProvider>().repeatesong();
                      },
                      child: StreamBuilder<LoopMode>(
                        stream: provider.player.loopModeStream,
                        builder: (context, snapshot) {
                          final newLoopMod = snapshot.data;
                          if (LoopMode.one == newLoopMod) {
                            return const Icon(
                              Icons.repeat_one,
                              color: Color.fromARGB(255, 0, 0, 0),
                            );
                          } else {
                            return const Icon(
                              Icons.repeat,
                            );
                          }
                        },
                      ),
                    )),
                    ButtonFav(
                      id: provider.itemlist[provider.currentIndex].id,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      
    );
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
