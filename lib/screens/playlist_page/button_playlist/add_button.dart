import 'package:flutter/material.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class PlaylistButton extends StatefulWidget {
  PlaylistButton(
      {Key? key,
      required this.index,
      required this.folderindex,
      required this.song})
      : super(key: key);
  int? index;
  int? folderindex;
  int? song;
  List<dynamic> songslist = [];
  static List<dynamic> updatelist = [];
  static List<dynamic> dltlist = [];
  @override
  State<PlaylistButton> createState() => _PlaylistButtonState();
}

class _PlaylistButtonState extends State<PlaylistButton> {
  @override
  Widget build(BuildContext context) {
     final playprovider = Provider.of<PlayListProvider>(context,listen: false);
    final checkindex = 
        playprovider.playlistsong[widget.folderindex!].dbsonglist
        .contains(widget.song);
    final indexcheck = playprovider
        .playlistsong[widget.folderindex!].dbsonglist
        .indexWhere((element) => element ==widget.song);
    if (checkindex != true) {
      return IconButton(
          onPressed: () async {
            playprovider.getplayList();
            widget.songslist.add(widget.song);
            PlaylistButton.updatelist = [
              widget.songslist,
              playprovider
                  .playlistsong[widget.folderindex!].dbsonglist
            ].expand((element) => element).toList();
            final model = Playlistmodel(
              name: playprovider
                  .playlistsong[widget.folderindex!].name,
              dbsonglist: PlaylistButton.updatelist,
              image: playprovider
                  .playlistsong[widget.folderindex!].image,
            );
            await playprovider.updatlist(widget.folderindex, model);
          setState(() {});
          },
          icon: const Icon(
            Icons.adjust_rounded,
            color: Color.fromARGB(255, 135, 255, 145),
          ));
    }
    return IconButton(
        onPressed: ()  {
          playprovider.getplayList();
          playprovider.playlistsong[widget.folderindex!].dbsonglist
              .removeAt(indexcheck);
          PlaylistButton.dltlist = [
            widget.songslist,
            playprovider.playlistsong[widget.folderindex!].dbsonglist
          ].expand((element) => element).toList();
          final model = Playlistmodel(
              name: playprovider
                  .playlistsong[widget.folderindex!].name,
              dbsonglist: PlaylistButton.dltlist,
              image: playprovider
                  .playlistsong[widget.folderindex!].image);
           playprovider.updatlist(widget.folderindex, model);
          setState(() {});
         
        },
        icon: Icon(
          Icons.adjust_rounded,
          color: Colors.red.shade200,
        ));
  }
}
