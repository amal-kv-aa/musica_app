import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica_app/screens/home_page/view/home_page.dart';
import 'package:on_audio_query/on_audio_query.dart';


class Favbutton with ChangeNotifier{
  Favbutton(){
    getfavList();
  }
   List dblist = [];
   List<SongModel> favsong = [];

//======================Fav==Function===================//


  Box songsDB = Hive.box('song_db');

  addfavsong(value) async {
    await songsDB.add(value);
   getfavList();
  }

  getfavList()  {
    dblist.clear();
   dblist.addAll(songsDB.values);
   showsongs();
   notifyListeners();
  }

  showsongs() async {
    favsong.clear();
    for (int i = 0; i < dblist.length; i++) {
      for (int j = 0; j < HomePage.songs.length; j++) {
        if (HomePage.songs[j].id == dblist[i]) {
          favsong.add(HomePage.songs[j]);
        }
      }
    }
  }

  removeList(index) async {
    await songsDB.deleteAt(index);
    getfavList();
  }

}