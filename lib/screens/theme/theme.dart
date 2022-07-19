import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica_app/data_model/data_model.dart';

class Themeset with ChangeNotifier {
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

  resetapp() async {
    final songDB = Hive.box('song_db');
    final checkDB = Hive.box('check_db');
    final playlistDB = Hive.box<Playlistmodel>('PlayListsongs_dB');
    checkDB.clear();
    playlistDB.clear();
    songDB.clear();
    themvalue = null;
    notifyListeners();
  }
}
