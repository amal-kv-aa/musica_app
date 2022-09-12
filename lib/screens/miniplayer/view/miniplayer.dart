import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:musica_app/screens/miniplayer/provider/mini_provider.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/nowplaying_page/view/widgets/playpause_button/playpauseicon.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<NowplayProvider>();
    return GestureDetector(
      child: InkWell(
        onTap: () {
          context.read<MiniProvider>().goNowplay(context);
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            watch.palletColor?.darkVibrantColor?.color ?? Colors.black,
            watch.palletColor?.darkVibrantColor?.color ?? Colors.black
          ])),
          height: MediaQuery.of(context).size.height * 0.08,
          child: ListTile(
            contentPadding:
                const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            leading: CircleAvatar(
                child: QueryArtworkWidget(
              id: watch.itemlist[watch.player.currentIndex!].id,
              type: ArtworkType.AUDIO,
              artworkBorder: BorderRadius.circular(0),
            )),
             title: Marquee(
              text: watch.itemlist[watch.player.currentIndex!].title
                  .replaceAll(RegExp('_'), '')
                  .replaceAll(RegExp('-'), ''),
              style: const TextStyle(
                  color: Colors.white, overflow: TextOverflow.ellipsis),
              velocity: 50,
              pauseAfterRound: const Duration(
                seconds: 5,
              ),
            ),
            trailing: InkWell(
                onTap: () async {
                  context.read<NowplayProvider>().playPause();
                },
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: const PlayPauseIcon(size: 25,))),
          ),
        ),
      ),
    );
  }
}
