import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/screens/home_page/home_page.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListProvider with ChangeNotifier{
PlayListProvider(){
  getplayList();
}
  final playlistDB = Hive.box<Playlistmodel>('PlayListsongs_dB'); 
  List<SongModel> playsongmodel = [];
   List<Playlistmodel> playlistsong = [];
   addplaylist({required Playlistmodel model}) async {
  await playlistDB.add(model);
  await getplayList();
  }
      
     getplayList() async {
    playlistsong.clear();
    playlistsong.addAll(playlistDB.values);
    notifyListeners();
  }
  
   updatlist(index,model)async{
  await playlistDB.putAt(index, model);
  await getplayList();
  await showselectsong(index); 
 }
  
     deleteplaylist(index) async{
    await playlistDB.deleteAt(index);
    await getplayList();
  }
   List selectplaysong = [];
 showselectsong(index)async{
  final checksong = playlistsong[index].dbsonglist;
  selectplaysong.clear();
  playsongmodel.clear();
  for(int i = 0; i <checksong.length;i++ ){
    for(int j = 0;j < HomePage.songs.length;j++){
      if(HomePage.songs[j].id == checksong[i]){
       selectplaysong.add(j);
       playsongmodel.add(HomePage.songs[j]);
        break;
      }
    }
  }notifyListeners();
 }

    //================================reset app=========================//
   resetapp()async{
    final songDB =  Hive.box('song_db');
        final checkDB =  Hive.box('check_db');
        checkDB.clear();
    playlistDB.clear();
    songDB.clear();
    NowPlaying.player.pause();
    }
}