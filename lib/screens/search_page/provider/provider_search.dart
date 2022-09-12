import 'package:flutter/cupertino.dart';
import 'package:musica_app/screens/home_page/view/home_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider with ChangeNotifier {
  List<SongModel> temp = [];
  
  filter(String value) {
    if (value.isEmpty) {
      temp.addAll(HomePage.songs);
    }
    temp.clear();
    temp = HomePage.songs
        .where(
            (song) => song.title.toLowerCase().startsWith(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
