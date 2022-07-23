import 'package:flutter/material.dart';
import 'package:musica_app/common_widgets/auto_playing_list/set_source.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/search_page/provider/provider_search.dart';
import 'package:musica_app/screens/theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final searchpro = context.read<SearchProvider>();
    final themechange = Provider.of<Themeset>(context, listen: false);
    final searchController = TextEditingController();
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
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              onChanged: (String? value) {
                context.read<SearchProvider>().filter(value!);
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                filled: true,
                errorBorder: InputBorder.none,
                fillColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Consumer<SearchProvider>(
                  builder: (context, searchlist, child) {
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        final data = searchlist.temp[index];
                        return ListTile(
                          onTap: () {
                            context
                                .read<NowplayProvider>()
                                .player
                                .setAudioSource(
                                  SetSource.createPLaylist(searchlist.temp),
                                  initialIndex: index,
                                );
                            context.read<NowplayProvider>().player.play();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    Nowplaying(songs: searchlist.temp)));
                          },
                          title: Text(
                            data.title,
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: CircleAvatar(
                              child: QueryArtworkWidget(
                            id: data.id,
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(0),
                          )),
                        );
                      },
                      itemCount: searchpro.temp.length,
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
