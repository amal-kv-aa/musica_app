import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:musica_app/screens/miniplayer/provider/mini_provider.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);
  
  @override

  Widget build(BuildContext context) {
    final themechange = context.read< Themeset >();
    context.read<MiniProvider>().covertlist(context);
    return GestureDetector(
      onHorizontalDragEnd: (dragDownDetails) {
        if ( dragDownDetails.primaryVelocity! < 0 ) {
          context.read<NowplayProvider>().playNext();
        } else if ( dragDownDetails.primaryVelocity! > 0 ) {
          context.read<NowplayProvider>().playPreviouse();
           
        }
      },
      child: InkWell(
        onTap: () {
          context.read<MiniProvider>().goNowplay(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: themechange.themvalue != 2
                    ? const Color.fromARGB(255, 123, 123, 123).withOpacity(0.8)
                    : const Color.fromARGB(255, 33, 205, 243).withOpacity(0.4),
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 163, 163, 163))),
            height: MediaQuery.of(context).size.height * 0.08,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              title: Marquee(
                text: context
                    .watch<NowplayProvider>()
                    .itemlist[
                        context.watch<NowplayProvider>().player.currentIndex!]
                    .title
                    .replaceAll(RegExp('_'), '')
                    .replaceAll(RegExp('-'), ''),
                style: const TextStyle(
                    color: Colors.white, overflow: TextOverflow.ellipsis),
                velocity: 50,
                pauseAfterRound: const Duration(
                  seconds: 5,
                ),
              ),
              leading: CircleAvatar(
                  child: QueryArtworkWidget(
                id: context
                    .watch<NowplayProvider>()
                    .itemlist[
                        context.watch<NowplayProvider>().player.currentIndex!]
                    .id,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(0),
              )),
              trailing: InkWell(
                onTap: () async {
                  context.read<NowplayProvider>().playPause();
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
                    stream:
                        context.read<NowplayProvider>().player.playingStream,
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
