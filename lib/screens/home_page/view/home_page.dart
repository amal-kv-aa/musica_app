import 'package:flutter/material.dart';
import 'package:musica_app/screens/favorite_page/view/widget/favoritebutton/favbutton.dart';
import 'package:musica_app/screens/home_page/provider/home_provider.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/nowplaying_page/view/now_playing.dart';
import 'package:musica_app/screens/weslide/weslide.dart';
import 'package:musica_app/utils/common_widgets/auto_playing_list/set_source.dart';
import 'package:musica_app/utils/common_widgets/logo/app_bar_logo.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static List<SongModel> songs = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final read = context.read<NowplayProvider>();
    final watch = context.watch<NowplayProvider>();
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            watch.palletColor?.dominantColor?.color ?? Colors.black,
            watch.palletColor?.darkVibrantColor?.color ?? Colors.black,
            Colors.black,
            Colors.black,
          ])),
      child: FutureBuilder<List<SongModel>>(
          future: context.read<HomeProvider>().audioQuery.querySongs(
              sortType: SongSortType.ALBUM,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, snapshot) {
            //== loading content indicator==//
            if (snapshot.data == null) {
              return const Center(
                child: Text(
                  'Loading songs......',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            //======no song found =========//
            if (snapshot.data!.isEmpty) {
              return const Center(
                  child: Text(
                'No songs founds.......',
                style: TextStyle(color: Colors.white),
              ));
            }
            HomePage.songs.clear();
            HomePage.songs = snapshot.data!;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: size.height * 0.08,
                    width: double.infinity,
                    child: Row(
                      children: const [LogoTop()],
                    ),
                  ),
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: size.width * 0.38,
                        mainAxisExtent: size.height * 0.21,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 3,
                      ),
                      physics: const BouncingScrollPhysics(),
                      reverse: false,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onLongPress: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) => const MyWidget())),
                            onTap: () {
                              read.player.setAudioSource(
                                SetSource.createPLaylist(snapshot.data),
                                initialIndex: index,
                              );
                              read.updatesonglist(snapshot.data!);
                              read.player.play();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const Nowplaying()));
                            },
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.14,
                                    child: QueryArtworkWidget(
                                      id: snapshot.data![index].id,
                                      artworkFit: BoxFit.cover,
                                      artworkBorder: BorderRadius.circular(0),
                                      artworkQuality: FilterQuality.high,
                                      type: ArtworkType.AUDIO,
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: Text(
                                        snapshot.data![index].title
                                            .replaceAll(RegExp('_'), '')
                                            .replaceAll(RegExp('-'), ''),
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 10,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    ButtonFav(id: snapshot.data![index].id)
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }
}
