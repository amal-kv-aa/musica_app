import 'package:flutter/material.dart';
import 'package:musica_app/screens/playlist_page/model/data_model/data_model.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class PlaylistButton extends StatelessWidget {
  PlaylistButton({Key? key, required this.folderindex, required this.song})
      : super(key: key);
  final int? folderindex;
  final int? song;
  final List<dynamic> songslist = [];
  static List<dynamic> updatelist = [];
  static List<dynamic> dltlist = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (context, value, child) {
        final checkindex =
            value.playlistsong[folderindex!].dbsonglist.contains(song);
        final indexcheck = value.playlistsong[folderindex!].dbsonglist
            .indexWhere((element) => element == song);
        if (checkindex != true) {
          return IconButton(
              onPressed: () async {
                songslist.add(song);
                PlaylistButton.updatelist = [
                  songslist,
                  value.playlistsong[folderindex!].dbsonglist
                ].expand((element) => element).toList();
                final model = Playlistmodel(
                  name: value.playlistsong[folderindex!].name,
                  dbsonglist: PlaylistButton.updatelist,
                  image: value.playlistsong[folderindex!].image,
                );
                await context
                    .read<PlayListProvider>()
                    .updatlist(folderindex, model);
              },
              icon: const Icon(
                Icons.add_task,
                color: Color.fromARGB(255, 135, 255, 145),
              ));
        }
        return IconButton(
          onPressed: () {
            value.playlistsong[folderindex!].dbsonglist.removeAt(indexcheck);
            PlaylistButton.dltlist = [
              songslist,
              value.playlistsong[folderindex!].dbsonglist
            ].expand((element) => element).toList();
            final model = Playlistmodel(
                name: value.playlistsong[folderindex!].name,
                dbsonglist: PlaylistButton.dltlist,
                image: value.playlistsong[folderindex!].image);
            context.read<PlayListProvider>().updatlist(folderindex, model);
          },
          icon:const Icon(
            Icons.highlight_remove_rounded,
            color: Color.fromARGB(255, 235, 61, 61),
          ),
        );
      },
    );
  }
}
