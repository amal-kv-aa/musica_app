import 'package:flutter/material.dart';
import 'package:musica_app/screens/loby_page/view/home_main.dart';
import 'package:musica_app/screens/miniplayer/view/miniplayer.dart';
import 'package:musica_app/screens/nowplaying_page/view/now_playing.dart';
import 'package:we_slide/we_slide.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     const double _panelMinSize = 70.0;
final double _panelMaxSize = MediaQuery.of(context).size.height / 2;
    return
     Scaffold(
  backgroundColor: Colors.black,
  body: WeSlide(
    panelMinSize: _panelMinSize,
    panelMaxSize: _panelMaxSize,
    body: Container(
      color: Colors.white,
      child: const Center(child: HomeScreen()),
    ),
    panel: Container(
      color: Colors.red,
      child: const Center(child: Nowplaying()),
    ),
    panelHeader: Container(
      height: _panelMinSize,
      color: Colors.yellow,
      child: const Center(child: MiniPlayer()),
    ),
  ),
);
  }
}