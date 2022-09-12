import 'package:flutter/material.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:musica_app/screens/favorite_page/view/widget/alertfav/alert.dart';
import 'package:musica_app/screens/nowplaying_page/view/now_playing.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/utils/common_widgets/auto_playing_list/set_source.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: Consumer<Favbutton>(
        builder: (context, songList,_) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: songList.favsong.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.height * 0.011),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.06,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 6, 6, 6)
                          .withOpacity(0.6)),
                  child: ListTile(
                    selectedTileColor:
                        const Color.fromARGB(255, 226, 222, 222),
                    onTap: () {
                      context.read<NowplayProvider>().player.setAudioSource(
                            SetSource.createPLaylist(songList.favsong),
                            initialIndex: index,
                          );
                           context.read<NowplayProvider>().updatesonglist(songList.favsong);
                      context.read<NowplayProvider>().player.play();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>const Nowplaying()));
                    },
                    leading: CircleAvatar(
                      child: QueryArtworkWidget(
                        id: songList.favsong[index].id,
                        type: ArtworkType.AUDIO,
                        artworkBorder: BorderRadius.circular(0),
                      ),
                    ),
                    title: Text(
                      songList.favsong[index].title
                          .replaceAll(RegExp('_'), ''),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 232, 231, 232),
                          overflow: TextOverflow.ellipsis),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite),
                      color:Colors.white,
                      onPressed: () {
                        AlertFav.showfavalert(context, index);
                        
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
