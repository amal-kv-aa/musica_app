import 'package:flutter/material.dart';
import 'package:musica_app/screens/nowplaying_page/view/now_playing.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/search_page/provider/provider_search.dart';
import 'package:musica_app/utils/common_widgets/auto_playing_list/set_source.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final read = context.read<NowplayProvider>();
    final searchController = TextEditingController();
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: ListView(
        physics: const BouncingScrollPhysics(),
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
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        final data = searchlist.temp[index];
                        return ListTile(
                          onTap: () {
                            read.player.setAudioSource(
                              SetSource.createPLaylist(searchlist.temp),
                              initialIndex: index,
                            );
                            read.updatesonglist(searchlist.temp);
                            read.player.play();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const Nowplaying()));
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
                      itemCount: context.read<SearchProvider>().temp.length,
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
