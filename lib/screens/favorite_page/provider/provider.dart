import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica_app/screens/home_page/home_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Favsong with ChangeNotifier {
  Favsong() {
    showsongs();
  }
  bool checkfav = false;
  final List _dblist = [];
  final List<SongModel> _favsong = [];
  get dblist => _dblist;
  get favsong => _favsong;

//======================Fav==Function===================//


  Box songsDB = Hive.box('song_db');

  addfavsong(value) async {
    await songsDB.add(value);
    getfavList();
  }

  getfavList()  {
    _dblist.clear();
    _dblist.addAll(songsDB.values);
    notifyListeners();
  }

  showsongs() async {
    _favsong.clear();
    for (int i = 0; i < _dblist.length; i++) {
      for (int j = 0; j < HomePage.songs.length; j++) {
        if (HomePage.songs[j].id == _dblist[i]) {
          _favsong.add(HomePage.songs[j]);
        }
      }
    }
  }

  removeList(index) async {
    await songsDB.deleteAt(index);
    getfavList();
  }

  int? themvalue;
  checktheme(value) async {
    final checkDB = await Hive.openBox('check_db');
    await checkDB.put(0, value);
    themvalue = checkDB.values.first;
  }

  gettheme() async {
    final checkDB = await Hive.openBox('check_db');
    themvalue = checkDB.values.first;
  }
}
