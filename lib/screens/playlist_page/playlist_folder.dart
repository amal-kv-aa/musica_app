import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musica_app/auto_playing_list/set_source.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:musica_app/screens/home_page/home_page.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:musica_app/screens/playlist_page/button_playlist/add_button.dart';
import 'package:musica_app/screens/playlist_page/playlist_addsongs.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaylistFolder extends StatelessWidget {
  const PlaylistFolder({Key? key,this.newindex}) : super(key: key);
 final int ? newindex;
  @override
  Widget build(BuildContext context) {
      final favprovider = Provider.of<Favsong>(context,listen: false);
     final playprovider = Provider.of<PlayListProvider>(context,listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Center(
            child: Text(
            playprovider.playlistsong[newindex!].name
              .toString()
              .toUpperCase(),
          style: const TextStyle(
              color: Color.fromARGB(255, 245, 242, 242),
              fontFamily: 'cursive',
              fontWeight: FontWeight.bold),
        )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) {return PlaylistAdd(
                          newindex: newindex,
                        );
                        } )).whenComplete(() {
                          
                        });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        decoration: favprovider.themvalue == 0
            ? BoxDecoration(
                image: playprovider
                            .playlistsong[newindex!].image !=
                        null
                    ? DecorationImage(
                        image: FileImage(File(playprovider
                            .playlistsong[newindex!].image!)),
                        fit: BoxFit.cover)
                    : const DecorationImage(
                        image: AssetImage('assets/images/music.jpg'),
                        fit: BoxFit.cover))
            : BoxDecoration(
                image: playprovider
                            .playlistsong[newindex!].image !=
                        null
                    ? DecorationImage(
                        image: FileImage(File(playprovider
                            .playlistsong[newindex!].image!)),
                        fit: BoxFit.cover)
                    : null,
                gradient: favprovider.themvalue == 1 ||
                        favprovider.themvalue == null
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
            playprovider
                    .playlistsong[newindex!].dbsonglist.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(
                      child: Text(
                        'Add Songs',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.03),
                      child: 
                      Consumer<PlayListProvider>(builder: (context, value, child) {
                         return ListView.builder(
                                itemCount:value.playlistsong
                                    [newindex!].dbsonglist.length,
                                itemBuilder: (ctx, index) {
                                  return InkWell(
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  favprovider.themvalue != 2
                                                      ? const Color.fromARGB(
                                                          255, 44, 44, 44)
                                                      : const Color.fromARGB(
                                                          255, 80, 39, 52),
                                              title: const Text(
                                                'Delete song ?',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 62, 221, 239)),
                                              ),
                                              actions: [
                                                Row(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'cancel',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      33,
                                                                      222,
                                                                      243)),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          playprovider
                                                              .getplayList();
                                                          value
                                                              .playlistsong
                                                              [newindex!]
                                                              .dbsonglist
                                                              .removeAt(index);
                                                          PlaylistButton
                                                              .dltlist = [
                                                            value
                                                                .playlistsong
                                                                [newindex!]
                                                                .dbsonglist
                                                          ]
                                                              .expand(
                                                                  (element) =>
                                                                      element)
                                                              .toList();
                                                          final model = Playlistmodel(
                                                              name: value
                                                                  .playlistsong
                                                                  [newindex!]
                                                                  .name,
                                                              dbsonglist:
                                                                  PlaylistButton
                                                                      .dltlist,
                                                              image: value
                                                                  .playlistsong
                                                                  [newindex!]
                                                                  .image);
                                                          playprovider
                                                              .updatlist(
                                                                  newindex,
                                                                  model);
                                                          
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text('Ok',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        33,
                                                                        222,
                                                                        243))))
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    child: Card(
                                        color: Colors.white24,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black)),
                                          child: ListTile(
                                            onTap: () {
                                              NowPlaying.player.setAudioSource(
                                                SetSource.createPLaylist(
                                                    playprovider
                                                        .playsongmodel),
                                                initialIndex: index,
                                              );
                                              NowPlaying.player.play();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (ctx) => NowPlaying(
                                                                songs: playprovider
                                                                    .playsongmodel
                                                                    ,
                                                              )));
                                            },
                                            leading: CircleAvatar(
                                              child: QueryArtworkWidget(
                                                id: HomePage
                                                    .songs[playprovider
                                                        .selectplaysong
                                                        [index]]
                                                    .id,
                                                type: ArtworkType.AUDIO,
                                                artworkBorder:
                                                    BorderRadius.circular(0),
                                              ),
                                            ),
                                            title: Text(
                                              HomePage
                                                  .songs[playprovider
                                                      .selectplaysong
                                                      [index]]
                                                  .title
                                                  .replaceAll(RegExp('_'), '')
                                                  .replaceAll(RegExp('-'), ''),
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ),
                                          ),
                                        )),
                                  );
                                });
                      },)
                    ),
                  ),
          ],
        ),
      ),
    );

  }
}