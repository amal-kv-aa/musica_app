import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

class NowplayProvider with ChangeNotifier {
  int currentIndex = 0;

  List<SongModel> itemlist = [];

  final AudioPlayer player = AudioPlayer();

  _updateCurrentPlayingSongDetailes(index) {
    if (player.currentIndex != null) {
      currentIndex = index;
    }
    notifyListeners();
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
    for (var i = 0; i < songs.length; i++) {
    itemlist.add(songs[i]);
    }
  }

  //====================update currend index======================//

  listenstream(){
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
      // notifyListeners();
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

  gesture(dragDownDetails) {
    if (dragDownDetails.primaryVelocity! < 0) {
      if (player.hasNext) {
        player.seekToNext();
        player.play();
        notifyListeners();
      }
    } else if (dragDownDetails.primaryVelocity! > 0) {
      if (player.hasPrevious) {
        player.seekToPrevious();
        player.play();
        notifyListeners();
      }
    }
  }
}
