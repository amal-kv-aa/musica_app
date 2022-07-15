import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
class MiniPlayer extends StatefulWidget {
const  MiniPlayer({
    Key? key,
  }) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  List<SongModel> minilist = [];

  @override
  Widget build(BuildContext context) {
      final favprovider = context.read<Favsong>();
    return GestureDetector(
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
      child: InkWell(
        onTap: () {
          minilist.clear();
          for (var i = 0; i < NowPlaying.itemlist.length; i++) {
            minilist.add(NowPlaying.itemlist[i]);
          }
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NowPlaying(
                    songs: minilist,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color:favprovider.themvalue!= 2? const Color.fromARGB(255, 123, 123, 123).withOpacity(0.8): const Color.fromARGB(255, 33, 205, 243).withOpacity(0.4) ,
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 163, 163, 163))),
            height: MediaQuery.of(context).size.height * 0.08,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              title: Marquee(
                text: NowPlaying.itemlist[NowPlaying.player.currentIndex!].title.replaceAll(RegExp('_'),'').replaceAll(RegExp('-'),''),
                style: const TextStyle(
                    color: Colors.white, overflow: TextOverflow.ellipsis),
                velocity: 50,
                pauseAfterRound: const Duration(
                  seconds: 5,
                ),
              ),
              leading: CircleAvatar(
                  child: QueryArtworkWidget(
                id: NowPlaying.itemlist[NowPlaying.player.currentIndex!].id,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(0),
              )),
              trailing: InkWell(
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
                  height: MediaQuery.of(context).size.height * 0.043,
                  width: MediaQuery.of(context).size.width * 0.09,
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
                          size: 25,
                          color: Colors.white,
                        );
                      }
                      return const Icon(
                        Icons.play_arrow_outlined,
                        size: 25,
                        color: Colors.white,
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
