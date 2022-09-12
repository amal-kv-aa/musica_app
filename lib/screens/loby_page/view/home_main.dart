import 'package:flutter/material.dart';
import 'package:musica_app/screens/home_page/view/home_page.dart';
import 'package:musica_app/screens/loby_page/provider/home_provider.dart';
import 'package:musica_app/screens/favorite_page/view/favorite_screen.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/nowplaying_page/view/now_playing.dart';
import 'package:musica_app/screens/playlist_page/view/playlist_screen.dart';
import 'package:musica_app/screens/search_page/view/search_screen.dart';
import 'package:musica_app/screens/settings_page/view/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:we_slide/we_slide.dart';
import '../../miniplayer/view/miniplayer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PageController _pagecontroller = PageController(initialPage: 0);
    double panel = context.watch<NowplayProvider>().player.playing ||
            context.watch<NowplayProvider>().player.currentIndex != null
        ? 120
        : 60;
    const double footer = 85;

//===================================== bottomnavbar == items =====================================//

    final _bottomnavigationbaritem = [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.music_note,
          ),
          label: ''),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
          label: ''),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
          ),
          label: ''),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.playlist_add,
          ),
          label: ''),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: ''),
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//===================================================body=================================================//
      extendBody: true,
      body: WeSlide(
          footerHeight: footer,
          blur: true,
          panelMaxSize: MediaQuery.of(context).size.height,
          isDismissible: true,
          panelMinSize: panel,
          controller: context.watch<LobyProvider>().controller,
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
              const SettingsScreen()
            ],
          ),
          hidePanelHeader: true,
          panel: context.watch<NowplayProvider>().player.playing ||
                  context.watch<NowplayProvider>().player.currentIndex != null
              ?  Nowplaying(ontap: context.read<LobyProvider>().dismiss())
              : const SizedBox(),
          panelHeader: context.watch<NowplayProvider>().player.playing ||
                  context.watch<NowplayProvider>().player.currentIndex != null
              ? const MiniPlayer()
              : const SizedBox(),
          footer: SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                //============miniplayer==condition===========//
                BottomNavigationBar(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
                  unselectedItemColor: const Color.fromARGB(255, 107, 107, 107),
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
          )),
    );
  }
}
