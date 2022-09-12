import 'package:flutter/material.dart';
import 'package:musica_app/screens/nowplaying_page/view/now_playing.dart';

class MiniProvider with ChangeNotifier {
  
  goNowplay(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const Nowplaying(
        ),
      ),
    );
  }
}
