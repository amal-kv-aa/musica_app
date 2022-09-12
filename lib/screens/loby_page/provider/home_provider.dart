import 'package:flutter/cupertino.dart';
import 'package:we_slide/we_slide.dart';

class LobyProvider with ChangeNotifier{
       final WeSlideController controller = WeSlideController();
    int currentIndex = 0; 
  indexUpdate(newindex){
   currentIndex=newindex;
   notifyListeners();
  }
  dismiss(){
    controller.hide;
    notifyListeners();
  }
}