import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica_app/screens/home_page/home_page.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../data_model/data_model.dart';

//=======================play list add===================//

// class PlaylistFunctions{

//   static  ValueNotifier<List<SongModel>> playsongmodel = ValueNotifier([]);
//   static ValueNotifier< List <Playlistmodel>> playlistsong = ValueNotifier([]);

//   static addplaylist({required Playlistmodel model}) async {
//   final playlistDB = await Hive.openBox<Playlistmodel>('PlayListsongs_dB');
//   await playlistDB.add(model);
//   await getplayList();
//   }
      
//   static getplayList() async {
//     final playlistDB = await Hive.openBox<Playlistmodel>('PlayListsongs_dB');
//     playlistsong.value.clear();
//     playlistsong.value.addAll(playlistDB.values);
//     playlistsong.notifyListeners();
//   }

//   static updatlist(index,model)async{
//   final playlistDB = await Hive.openBox<Playlistmodel>('PlayListsongs_dB');
//   await playlistDB.putAt(index, model);
//   await getplayList();
//   await PlaylistsongCheck.showselectsong(index); 
//  }
  
//     static deleteplaylist(index) async{
//     final playlistDB =  await Hive.openBox<Playlistmodel>('PlayListsongs_dB');
//     await playlistDB.deleteAt(index);
//     await getplayList();
//   }
// }


// class  PlaylistsongCheck{

// static ValueNotifier<List> selectplaysong = ValueNotifier([]);
// static showselectsong(index)async{
//   final checksong = PlaylistFunctions.playlistsong.value[index].dbsonglist;
//   selectplaysong.value.clear();
//   PlaylistFunctions.playsongmodel.value.clear();
//   for(int i = 0; i <checksong.length;i++ ){
//     for(int j = 0;j < HomePage.songs.length;j++){
//       if(HomePage.songs[j].id == checksong[i]){
//        selectplaysong.value.add(j);
//        PlaylistFunctions.playsongmodel.value.add(HomePage.songs[j]);
//         break;
//       }
//     }
//   }
//  }

//     //================================reset app=========================//
//  static  resetapp()async{
//   final playlistDB = await Hive.openBox<Playlistmodel>('PlayListsongs_dB');
//     final songDB = await Hive.openBox('song_db');
//         final checkDB = await Hive.openBox('check_db');
//         checkDB.clear();
//     playlistDB.clear();
//     songDB.clear();
//     NowPlaying.player.pause();
//     }
// }
