import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    requeStoragePermission();
  }
  final OnAudioQuery audioQuery = OnAudioQuery();
  //=============request==storege==access==permission===================//
  Future requeStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
        notifyListeners();
      }
    }
  }
}
