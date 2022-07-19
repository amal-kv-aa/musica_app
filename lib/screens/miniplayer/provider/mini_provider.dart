import 'package:flutter/material.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MiniProvider with ChangeNotifier{

   List<SongModel> minilist = [];
  goNowplay(BuildContext context){
     minilist.clear();
          for (var i = 0; i < context.read<NowplayProvider>().itemlist.length; i++) {
            minilist.add(context.read<NowplayProvider>().itemlist[i]);
          }
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => Nowplaying(
                    songs: minilist,
                  )));
  }
  
}