import 'package:flutter/material.dart';
import 'package:musica_app/screens/home_page/view/home_page.dart';
import 'package:musica_app/screens/playlist_page/view/widgets/button_playlist/add_button.dart';
import 'package:on_audio_query/on_audio_query.dart';


class PlaylistAdd extends StatelessWidget {
const  PlaylistAdd({Key? key, this.newindex}) : super(key: key);
final  int? newindex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
           height: double.infinity,
           width: double.infinity,
           color: Theme.of(context).cardColor,
            child: ListView.builder(
                itemCount: HomePage.songs.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: QueryArtworkWidget(
                          id: HomePage.songs[index].id,
                          type: ArtworkType.AUDIO,
                          artworkBorder: BorderRadius.circular(0),
                        ),
                      ),
                      title: Text(
                        HomePage.songs[index].title
                            .replaceAll(RegExp('_'), '')
                            .replaceAll(RegExp('-'), ''),
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white),
                      ),
                      trailing: PlaylistButton(
                        song: HomePage.songs[index].id,
                        folderindex: newindex,
                      ),
                    ),
                  );
                }),
                ),);
  }
}
