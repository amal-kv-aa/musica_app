import 'package:flutter/material.dart';
import 'package:musica_app/screens/home_page/home_page.dart';
import 'package:musica_app/screens/loby_page/provider/home_provider.dart';
import 'package:musica_app/screens/miniplayer/miniplayer.dart';
import 'package:musica_app/screens/favorite_page/favorite_screen.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/playlist_page/playlist_screen.dart';
import 'package:musica_app/screens/search_page/search_screen.dart';
import 'package:musica_app/screens/settings_page/settings_screen.dart';
import 'package:provider/provider.dart';
import '../../logo/app_bar_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PageController _pagecontroller = PageController(initialPage: 0);

//=====================================bottomnavbar==items=====================================//

    final _bottomnavigationbaritem = [
      BottomNavigationBarItem(
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: const Color.fromARGB(97, 0, 0, 0),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 0, 0, 0))),
            child: const Icon(
              Icons.music_note,
            ),
          ),
          label: ''),
      BottomNavigationBarItem(
          icon: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(97, 0, 0, 0),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      width: 1, color: const Color.fromARGB(255, 0, 0, 0))),
              child: const Icon(
                Icons.search,
              )),
          label: ''),
      BottomNavigationBarItem(
          icon: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(97, 0, 0, 0),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      width: 1, color: const Color.fromARGB(255, 0, 0, 0))),
              child: const Icon(
                Icons.favorite,
              )),
          label: ''),
      BottomNavigationBarItem(
          icon: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(97, 0, 0, 0),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      width: 1, color: const Color.fromARGB(255, 0, 0, 0))),
              child: const Icon(
                Icons.playlist_add,
              )),
          label: ''),
    ];


    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//===========================================appbar===================================================//
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white12,
          title: const LogoTop(),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) =>const SettingsScreen()));
                },
                icon: const Icon(
                  Icons.more_vert_outlined,
                  size: 30,
                  color: Color.fromARGB(255, 31, 161, 137),
                )),
          ],
        ),
//===========================================body==============================================================//
        extendBody: true,
        body: PageView(
          controller: _pagecontroller,
          onPageChanged: (newIndex) {
            context.read<LobyProvider>().indexUpdate(newIndex);
          },
          children: <Widget>[
            const HomePage(),
            const SearchScreen(),
            const FavoritePage(),
            PlayList(),
          ],
        ),
        //======================================bottom=navbar============================//
        bottomNavigationBar: SizedBox(
          height: context.watch<NowplayProvider>().player.playing ||
                  context.watch<NowplayProvider>().player.currentIndex != null
              ? MediaQuery.of(context).size.height * 0.174
              : MediaQuery.of(context).size.height * 0.095,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              context.watch<NowplayProvider>().player.playing ||
                      context.watch<NowplayProvider>().player.currentIndex !=
                          null
                  ? const MiniPlayer()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0,
                    ),
              BottomNavigationBar(
                backgroundColor: Colors.white12,
                elevation: 0,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                selectedItemColor: const Color.fromARGB(255, 50, 206, 198),
                unselectedItemColor: const Color.fromARGB(255, 200, 200, 200),
                items: _bottomnavigationbaritem,
                type: BottomNavigationBarType.fixed,
                currentIndex: context.watch<LobyProvider>().currentIndex,
                onTap: (newIndex) {
                  _pagecontroller.animateToPage(newIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
              ),
            ],
          ),
        ));
  }
}
