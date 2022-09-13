import 'package:flutter/material.dart';
import 'package:musica_app/screens/playlist_page/model/data_model/data_model.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:musica_app/screens/playlist_page/view/widgets/button_playlist/add_button.dart';
import 'package:provider/provider.dart';

class Bottomsheet extends StatelessWidget {
  const Bottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container();
  }

  static alertdialog(BuildContext context, newindex, index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor:Colors.white,
            title: const Text(
              'Delete song ?',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'cancel',
                        style:
                            TextStyle(color: Color.fromARGB(255, 33, 222, 243)),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .watch<PlayListProvider>()
                            .playlistsong[newindex!]
                            .dbsonglist
                            .removeAt(index);
                        PlaylistButton.dltlist = [
                          context
                              .watch<PlayListProvider>()
                              .playlistsong[newindex!]
                              .dbsonglist
                        ].expand((element) => element).toList();
                        final model = Playlistmodel(
                            name: context
                                .watch<PlayListProvider>()
                                .playlistsong[newindex!]
                                .name,
                            dbsonglist: PlaylistButton.dltlist,
                            image: context
                                .watch<PlayListProvider>()
                                .playlistsong[newindex!]
                                .image);
                        context
                            .read<PlayListProvider>()
                            .updatlist(newindex, model);
                      },
                      child: const Text('Ok',
                          style: TextStyle(
                              color: Color.fromARGB(255, 33, 222, 243))))
                ],
              )
            ],
          );
        });
  }
}
