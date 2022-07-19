import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musica_app/auto_playing_list/set_source.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:musica_app/screens/playlist_page/widgets/bottomsheet/bottomsheet.dart';
import 'package:musica_app/screens/theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaylistFolder extends StatelessWidget {
  const PlaylistFolder({Key? key, this.newindex}) : super(key: key);
  final int? newindex;
  @override
  Widget build(BuildContext context) {
   
    final themechange = Provider.of<Themeset>(context, listen: false);
    final read = context.read<PlayListProvider>();
    final watch = context.watch<PlayListProvider>();
    read.showselectsong(newindex);
     print('.........................************...............................');
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Center(
            child: Text(
          watch.playlistsong[newindex!].name.toString().toUpperCase(),
          style: const TextStyle(
              color: Color.fromARGB(255, 245, 242, 242),
              fontFamily: 'cursive',
              fontWeight: FontWeight.bold),
        )),
        actions: [
          IconButton(
              onPressed: () {
                context
                    .read<PlayListProvider>()
                    .goNowplaying(context, newindex);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        decoration: themechange.themvalue == 0
            ? BoxDecoration(
                image: watch.playlistsong[newindex!].image != null
                    ? DecorationImage(
                        image: FileImage(
                            File(watch.playlistsong[newindex!].image!)),
                        fit: BoxFit.cover)
                    : const DecorationImage(
                        image: AssetImage('assets/images/music.jpg'),
                        fit: BoxFit.cover))
            : BoxDecoration(
                image: watch.playlistsong[newindex!].image != null
                    ? DecorationImage(
                        image: FileImage(
                            File(watch.playlistsong[newindex!].image!)),
                        fit: BoxFit.cover)
                    : null,
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
            watch.playlistsong[newindex!].dbsonglist.isEmpty
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
                        child: Consumer<PlayListProvider>(
                          builder: (context, value, _) {
                            return ListView.builder(
                                itemCount: value
                                    .playlistsong[newindex!].dbsonglist.length,
                                itemBuilder: (ctx, index) {
                                  return InkWell(
                                    onLongPress: () {
                                      Bottomsheet.alertdialog(
                                          context, newindex, index);
                                    },
                                    child: Card(
                                        color: Colors.white24,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black)),
                                          child: Consumer<PlayListProvider>(
                                            builder: (context, value, _) {
                                              return ListTile(
                                                onTap: () {
                                                  context
                                                      .read<NowplayProvider>()
                                                      .player
                                                      .setAudioSource(
                                                        SetSource.createPLaylist(
                                                            watch
                                                                .playsongmodel),
                                                        initialIndex: index,
                                                      );
                                                  context
                                                      .read<NowplayProvider>()
                                                      .player
                                                      .play();
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              Nowplaying(
                                                                songs: watch
                                                                    .playsongmodel,
                                                              )));
                                                },
                                                leading: CircleAvatar(
                                                  child: QueryArtworkWidget(
                                                    id: value.
                                                        playsongmodel[
                                                            index]
                                                        .id,
                                                    type: ArtworkType.AUDIO,
                                                    artworkBorder:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                ),
                                                title: Text(
                                                  value.playsongmodel[
                                                    index
                                                      ]
                                                      .title
                                                      .replaceAll(
                                                          RegExp('_'), '')
                                                      .replaceAll(
                                                          RegExp('-'), ''),
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              );
                                            },
                                          ),
                                        )),
                                  );
                                });
                          },
                        )),
                  ),
          ],
        ),
      ),
    );
  }
}
