import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider with ChangeNotifier{
  List<SongModel> temp =[];
  void notifytemp(){
    notifyListeners();
  }
}