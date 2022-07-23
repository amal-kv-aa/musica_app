import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:musica_app/screens/splash_page/splash_screen.dart';
import 'package:provider/provider.dart';

class Themeset with ChangeNotifier {
  int? themvalue;
  checktheme(value) async {
    final checkDB = await Hive.openBox('check_db');
    await checkDB.put(0, value);
    themvalue = checkDB.values.first;
  }

  gettheme() async {
    final checkDB = await Hive.openBox('check_db');
    themvalue =await checkDB.values.first;
  }

  resetapp(BuildContext context) async {
    final songDB = Hive.box('song_db');
    final checkDB = Hive.box('check_db');
    final playlistDB = Hive.box<Playlistmodel>('PlayListsongs_dB');
    await checkDB.clear();
    await playlistDB.clear();
    await songDB.clear();
    themvalue = null;
    context.read<Favbutton>().getfavList();
    context.read<PlayListProvider>().getplayList();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) =>const SplashScreen()),
        (route) => false);
  }
}
