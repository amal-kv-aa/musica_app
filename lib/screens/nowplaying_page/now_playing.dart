import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:musica_app/screens/playlist_page/button_playlist/add_button.dart';
import 'package:musica_app/screens/playlist_page/playlist_screen.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class NowPlaying extends StatefulWidget {
  static final AudioPlayer player = AudioPlayer();
  NowPlaying({
    Key? key,
    this.songs,
  }) : super(key: key);
  static bool ischeck = false;
  int? index;
  List<SongModel>? songs=[];
  String currentsongTitile = '';
  static int currentIndex = 0;
  static dynamic pause;
  int? favindex;
  static List<SongModel> itemlist = [];
  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  //====================duration State stream=========================//

  Stream<DurationState> get durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          NowPlaying.player.positionStream,
          NowPlaying.player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
  @override
  
  void initState() {
    NowPlaying.itemlist.clear();
    for (var i = 0; i < widget.songs!.length; i++) {
      NowPlaying.itemlist.add(widget.songs![i]);
    }
    //====================update currend index======================//
    NowPlaying.player.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayingSongDetailes(index);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favprovider = Provider.of<Favsong>(context);
      final playprovider = Provider.of<PlayListProvider>(context,listen: false);
    return Scaffold(
      body: Container(
        decoration: favprovider.themvalue==0 ? const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/music.jpg'),
                fit: BoxFit.cover)):
                 BoxDecoration( gradient:favprovider.themvalue==1 || favprovider.themvalue==null ?  const LinearGradient( begin: Alignment.bottomLeft,
              end: Alignment.topLeft,colors:  [
                Color.fromARGB(255, 0, 0, 0),

                  Color.fromARGB(255, 0, 0, 0),
              
              ]) : const LinearGradient( begin: Alignment.bottomLeft,
              end: Alignment.topLeft,colors:  [
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
                      NowPlaying.ischeck == true;
                    },
                    icon:  Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 40,
                      color:favprovider.themvalue==2 ? const Color.fromARGB(255, 86, 10, 35) : const Color.fromARGB(255, 38, 225, 218),
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            GestureDetector(
              onHorizontalDragEnd: (dragDownDetails){if(dragDownDetails.primaryVelocity! < 0){
                if(NowPlaying.player.hasNext){ NowPlaying.player.seekToNext();
                   setState(() {
                  
                });
                }
              }
              else if(dragDownDetails.primaryVelocity!>0){
               if(NowPlaying.player.hasPrevious){
                 NowPlaying.player.seekToPrevious();
                 setState(() {
                           
                 });
               }
              }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color:favprovider.themvalue !=2 ?  const Color.fromARGB(255, 7, 253, 241): const Color.fromARGB(255, 0, 201, 251)),
                      boxShadow:  [
                        BoxShadow(
                            blurRadius: 16,
                            color:favprovider.themvalue !=2 ? const Color.fromARGB(255, 108, 235, 244) : const Color.fromARGB(255, 12, 93, 117),
                            offset: const Offset(0, 0))
                      ],
                      color:
                          const Color.fromARGB(255, 252, 255, 255).withOpacity(0),
                      borderRadius: BorderRadius.circular(50)),
                  child: QueryArtworkWidget(
                    id: widget.songs![NowPlaying.currentIndex].id,
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(50),
                    artworkFit: BoxFit.cover,
                    artworkQuality: FilterQuality.high,
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
                      child: Marquee(
                        text: widget.songs![NowPlaying.currentIndex].title.replaceAll(RegExp('_'),'').replaceAll(RegExp('-'),''),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        velocity: 50,
                        pauseAfterRound: const Duration(seconds: 4),
                      ),
                    ),
                  ),
                  Text(
                    widget.songs![NowPlaying.currentIndex].artist ?? 'Unknown',
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color.fromARGB(255, 205, 205, 205)),
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
                stream: durationStateStream,
                builder: (context, snapshot) {
                    final playprovider = Provider.of<PlayListProvider>(context,listen: false);
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
                      NowPlaying.player.seek(duration);
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
                      if (NowPlaying.player.hasPrevious) {
                        NowPlaying.player.seekToPrevious();
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.skip_previous_outlined,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
                InkWell(
                  onTap: () async {
                    if (NowPlaying.player.playing) {
                      NowPlaying.player.pause();
                    } else {
                      if (NowPlaying.player.currentIndex != null) {
                        NowPlaying.player.play();
                      }
                    }
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
                      stream: NowPlaying.player.playingStream,
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
                      if (NowPlaying.player.hasNext) {
                        NowPlaying.player.seekToNext();
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.skip_next_outlined,
                      color: Colors.white,
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ), Padding(
              padding: const EdgeInsets.only(top: 16, right: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                child:Consumer<PlayListProvider>(builder: (context, value, child) {
                                    return Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: ListView(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            PlayList()));
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 52, 52, 52),
                                                  border: Border.all(
                                                      width: 2,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              103,
                                                              103,
                                                              103)),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'Create new Playlist',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(255, 17, 243, 255)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.36,
                                              child: ListView.builder(
                                                  itemCount: playprovider
                                                      .playlistsong
                                                      .length,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 2,
                                                              color: Colors
                                                                  .white30),
                                                          color:
                                                              Colors.black38),
                                                      child: ListTile(
                                                        title: Text(
                                                          playprovider
                                                              .playlistsong
                                                              [index]
                                                              .name
                                                              .toString().toUpperCase(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        trailing: PlaylistButton(
                                                            index: NowPlaying
                                                                .currentIndex,
                                                            folderindex: index,
                                                            song: widget.songs![NowPlaying.currentIndex].id ),
                                                      ),
                                                    );
                                                  })),
                                            ),
                                          ],
                                        ),
                                      );
                                },)
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.playlist_add,
                        color: Color.fromARGB(255, 17, 156, 156),
                      )),Flexible(child: InkWell(
                  onTap: () {
                    NowPlaying.player.loopMode == LoopMode.one
                    ? NowPlaying.player.setLoopMode(LoopMode.all)
                    : NowPlaying.player.setLoopMode(LoopMode.one);
                  },
                  child: StreamBuilder<LoopMode>(
                  stream: NowPlaying.player.loopModeStream,
                  builder: (context,snapshot){
                    final newLoopMod = snapshot.data;
                    if (LoopMode.one ==newLoopMod) {
                        return const Icon(Icons.repeat_one,color: Color.fromARGB(255, 27, 203, 222),);
                    }
                    else{
                      return
                      const Icon(Icons.repeat,color: Colors.white,);
                    }
                  },
                  ),
                  )),
                  // FavButton(
                  //   id: widget.songs![NowPlaying.currentIndex].id,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _updateCurrentPlayingSongDetailes(index) {
    setState(() {
      if (NowPlaying.player.currentIndex != null) {
        NowPlaying.currentIndex = index;
      }
    });
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
