import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musica_app/common_widgets/auto_playing_list/set_source.dart';
import 'package:musica_app/screens/home_page/home_page.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class HomeProvider with ChangeNotifier {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  get audioQuery => _audioQuery;

  //=============request storege access permission===================//
  Future requeStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }
      
      notifyListeners();
    }
  }

  //==================navigate to nowplay=========================//
  gotoNowplay(BuildContext context, int index) {
    context.read<NowplayProvider>().player.setAudioSource(
          SetSource.createPLaylist(HomePage.songs),
          initialIndex: index,
        );
    context.read<NowplayProvider>().player.play();
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return Nowplaying(
        songs: HomePage.songs,
      );
    }));
  }
}
