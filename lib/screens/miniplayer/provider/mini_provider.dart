import 'package:flutter/material.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MiniProvider with ChangeNotifier{

   List<SongModel> minilist = [];
   covertlist(BuildContext context){
     minilist.clear();
      minilist.addAll(context.read<NowplayProvider>().itemlist);
   }
  goNowplay(BuildContext context){
    
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => Nowplaying(
                    songs: minilist,
                  )));
  }
  
}