import 'package:flutter/cupertino.dart';

class LobyProvider with ChangeNotifier{
    int currentIndex = 0; 
  indexUpdate(newindex){
   currentIndex=newindex;
   notifyListeners();
  }
}