// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:musica_app/screens/home_page/home_page.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class FunctionsData {
//   static ValueNotifier<List<SongModel>> favsong = ValueNotifier([]);
//   static List favlist=[];
//   static dynamic dblist;
//   static ValueNotifier <List<dynamic>>favsongindex=ValueNotifier([]);
// //=======================fav function===================//
//     static addfavsong(value) async {
//     final songsDB = await Hive.openBox('song_db');
//     await songsDB.add(value);
//     getfavList();
//   }
//     static getfavList() async {
//     final songsDB = await Hive.openBox('song_db');
//     favsong.value.clear();
//     dblist = songsDB.values.toList();
//     showsongs();
//   }
//     static showsongs() async {
//     favsong.value.clear();
//     favsongindex.value.clear();
//     for (int i = 0; i < dblist.length; i++) {
//     for (int j = 0; j < HomePage.songs.length; j++) {
//         if (HomePage.songs[j].id == dblist[i]){
//           favsong.value.add(HomePage.songs[j]);
//           favsongindex.value.add(j);
//         }
//       }
//     }
//     favsongindex.notifyListeners();
//     favsong.notifyListeners();
//   }
//    static removeList(index) async {
//     final songDB = await Hive.openBox('song_db');
//     await songDB.deleteAt(index);
//     await getfavList();

 
    
//   }
  
//   static int? themvalue ;
  
//   static checktheme(value)async{
//     final checkDB = await Hive.openBox('check_db');
//     await checkDB.put(0,value);
//     themvalue=checkDB.values.first;
//   }
//   static gettheme()async{
//      final checkDB = await Hive.openBox('check_db');
//      themvalue=checkDB.values.first;
     
//   }
// }


