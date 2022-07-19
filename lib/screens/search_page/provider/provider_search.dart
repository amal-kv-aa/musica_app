import 'package:flutter/cupertino.dart';
import 'package:musica_app/screens/home_page/home_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider with ChangeNotifier{
  List<SongModel> temp =[];
  void notifytemp(){
    notifyListeners();
  }
     filter(String value){
      if(value == null || value.isEmpty){
                              temp.addAll(HomePage.songs);
                              }
                              temp.clear();
                              for (SongModel i  in HomePage.songs ) {
                                if(i.title.toLowerCase().contains(value.toLowerCase())){
                                  temp.add(i);
                                } 
                              notifytemp();
                              }
     }
}