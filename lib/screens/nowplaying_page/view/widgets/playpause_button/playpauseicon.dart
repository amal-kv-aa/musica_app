import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/nowplayer_provider.dart';

class PlayPauseIcon extends StatelessWidget {
  const PlayPauseIcon({Key? key,required this.size}) : super(key: key);
 final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
      ),
      child: StreamBuilder<bool>(
        stream: context.watch<NowplayProvider>().player.playingStream,
        builder: ((context, snapshot) {
          bool? playingState = snapshot.data;
          if (playingState != null && playingState) {
            return  Icon(
              Icons.pause,
              size: size,
              color: Colors.white,
            );
          }
          return  Icon(
            Icons.play_arrow_outlined,
            size: size,
            color: Colors.white,
          );
        }),
      ),
    );
  }
}
