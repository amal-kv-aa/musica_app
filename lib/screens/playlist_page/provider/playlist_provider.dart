
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/screens/home_page/home_page.dart';
import 'package:musica_app/screens/playlist_page/playlist_addsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListProvider with ChangeNotifier{
PlayListProvider(){
  getplayList();
}
  final playlistDB = Hive.box<Playlistmodel>('PlayListsongs_dB'); 
  List<SongModel> playsongmodel = [];
   List<Playlistmodel> playlistsong = [];

   //==============play list button list============//
   List<dynamic> songslist = [];
   List<dynamic> dltlist = [];

   addplaylist({required Playlistmodel model}) async {
  await playlistDB.add(model);
  getplayList();
  }
      
    getplayList() async {
    playlistsong.clear();
    playlistsong.addAll(playlistDB.values);
    notifyListeners();
  }
  
   updatlist(index,model)async{
  await playlistDB.putAt(index, model);
  getplayList();
  await showselectsong(index); 
 }
  
     deleteplaylist(index) async{
    await playlistDB.deleteAt(index);
    getplayList();
  }

 showselectsong(index)async{
  final checksong = playlistsong[index].dbsonglist;
  playsongmodel.clear();
  for(int i = 0; i <checksong.length;i++ ){
    for(int j = 0;j < HomePage.songs.length;j++){
      if(HomePage.songs[j].id == checksong[i]){
       playsongmodel.add(HomePage.songs[j]);
        break;
      }
    }
  }
 }
    //================================reset app=========================//



    goNowplaying(BuildContext context,newindex){
      Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) {return PlaylistAdd(
                          newindex: newindex,
                        );
                        } )).whenComplete((){
                          notifyListeners();
                        });
    }
}