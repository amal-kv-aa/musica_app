import 'package:flutter/material.dart';
import 'package:musica_app/screens/favorite_page/favoritebutton/favbutton.dart';
import 'package:musica_app/screens/home_page/provider/home_provider.dart';
import 'package:musica_app/screens/theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static List<SongModel> songs = [];
  @override
  Widget build(BuildContext context) {
   context.read<HomeProvider>().requeStoragePermission();
    final themechange = context.watch<Themeset>();
    return Container(
      decoration: themechange.themvalue == 0
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/music.jpg',
                  ),
                  fit: BoxFit.cover))
          : BoxDecoration(
              gradient:
                  themechange.themvalue == 1 || themechange.themvalue == null
                      ? const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topLeft,
                          colors: [
                              Color.fromARGB(255, 0, 0, 0),
                              Color.fromARGB(255, 0, 0, 0),
                            ])
                      : const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topLeft,
                          colors: [
                              Color.fromARGB(255, 122, 0, 57),
                              Color.fromARGB(255, 11, 219, 226),
                            ])),
      child: ListView(children: [
        FutureBuilder<List<SongModel>>(
            future: context.read<HomeProvider>().audioQuery.querySongs(
                sortType: SongSortType.ARTIST,
                orderType: OrderType.ASC_OR_SMALLER,
                uriType: UriType.EXTERNAL,
                ignoreCase: true),
            builder: (context, item) {
              //== loading content indicator==//
              if (item.data == null) {
                return const Center(child: Text('Loading songs......'));
              }
              //======no song found =========//
              if (item.data!.isEmpty) {
                return const Center(
                  child: Text('No songs founds.......'),
                );
              }
              HomePage.songs.clear();
              HomePage.songs = item.data!;

              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.76,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisExtent: 200,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        reverse: false,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: item.data!.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<HomeProvider>()
                                      .gotoNowplay(context, index);
                                },
                                child: Card(
                                  color: Colors.transparent,
                                  child: ListView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                            ),
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: QueryArtworkWidget(
                                            id: HomePage.songs[index].id,
                                            artworkFit: BoxFit.cover,
                                            artworkBorder:
                                                BorderRadius.circular(0),
                                            artworkQuality: FilterQuality.high,
                                            type: ArtworkType.AUDIO,
                                          )),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                          ),
                                          color: Colors.white24,
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            HomePage.songs[index].title
                                                .replaceAll(RegExp('_'), '')
                                                .replaceAll(RegExp('-'), ''),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 14,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          trailing: ButtonFav(
                                              id: HomePage.songs[index].id),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }),
      ]),
    );
  }
}
