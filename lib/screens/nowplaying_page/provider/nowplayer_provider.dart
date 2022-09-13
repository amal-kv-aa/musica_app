import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musica_app/screens/home_page/view/home_page.dart';
import 'package:musica_app/screens/nowplaying_page/view/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rxdart/rxdart.dart';

class NowplayProvider with ChangeNotifier {
  NowplayProvider() {
    listenstream();
  }
  int currentIndex = 0;
  PaletteGenerator? palletColor;

  List<SongModel> itemlist = [];

  final AudioPlayer player = AudioPlayer();
//=========================uodate playing song index===============//
  _updateCurrentPlayingSongDetailes(index)  {
    if (player.currentIndex != null) {
      currentIndex = index;
      generatPallet(player.currentIndex!);
    }
  }
  //====================duration State stream=========================//

  Stream<DurationState> get durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          player.positionStream,
          player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));

//=============================update song list============================//

  updatesonglist(List<SongModel> songs) {
    itemlist.clear();
    itemlist.addAll(songs);
    notifyListeners();
  }

  //====================update currend index======================//

  listenstream() {
    player.currentIndexStream.listen((index) {
      if (index != null) {
        
        _updateCurrentPlayingSongDetailes(index);
        
      }
    });
  }

  //==============================Seeks to previous========================//

  playPreviouse() {
    if (player.hasPrevious) {
      player.seekToPrevious();
      player.play();
    }
  }

  //================================pause play============================//

  playPause() {
    if (player.playing) {
      player.pause();
    } else {
      if (player.currentIndex != null) {
        player.play();
      }
    }
  }

  //================================play next===============================//

  playNext() {
    if (player.hasNext) {
      player.seekToNext();
      player.play();
    }
  }

  //=========================Loop mode===========================//

  repeatesong() {
    player.loopMode == LoopMode.one
        ? player.setLoopMode(LoopMode.all)
        : player.setLoopMode(LoopMode.one);
  }

  //==========================Gesture detucture========================//

  gesture(DragEndDetails dragDownDetails) async {
    if (dragDownDetails.primaryVelocity! < 0) {
      if (player.hasNext) {
        await player.seekToNext();
        await player.play();
        notifyListeners();
      }
    } else if (dragDownDetails.primaryVelocity! > 0) {
      if (player.hasPrevious) {
        await player.seekToPrevious();
        await player.play();
        notifyListeners();
      }
    }
  }

  //=====================image color generator====================//
  Future<void> generatPallet(int index) async {
    final image = await OnAudioQuery().queryArtwork(
        HomePage.songs[index].id,
         ArtworkType.AUDIO,
        format: ArtworkFormat.JPEG);
    palletColor = await PaletteGenerator.fromImageProvider(MemoryImage(image!),
        maximumColorCount: 20);
    notifyListeners();
  }
}
