import 'dart:io';
import 'package:flutter/material.dart';
import 'package:musica_app/screens/folder_playlist/view/playlist_folder.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:musica_app/screens/playlist_page/view/widgets/alert/folderadd/folderadd.dart';
import 'package:musica_app/screens/playlist_page/view/widgets/alert/imagealert/alert_image.dart';
import 'package:provider/provider.dart';

class PlayList extends StatelessWidget {
  PlayList({Key? key, this.addplaylist}) : super(key: key);
  final TextEditingController namecontroller = TextEditingController();
  final int? addplaylist;
  @override
  Widget build(BuildContext context) {
    final provider = context.read<PlayListProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Row(
            children: [
              const Text('create new playlist'),
              IconButton(
                  onPressed: () {
                    AddAlert.addfolder(context, namecontroller);
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
        ],
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Consumer<PlayListProvider>(
                    builder: (context, playlist, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 160,
                              mainAxisExtent: 140,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            physics: const BouncingScrollPhysics(),
                            itemCount: playlist.playlistsong.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => PlaylistFolder(
                                                  newindex: index,
                                                )));
                                  },
                                  onLongPress: () {
                                    ImageAlert.showAlert(context, index);
                                  },
                                  child: provider.playlistsong[index].image !=
                                          null
                                      ? (Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: FileImage(File(provider
                                                      .playlistsong[index]
                                                      .image!)),
                                                  fit: BoxFit.cover),
                                              border: Border.all(
                                                width: 1,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: ColoredBox(
                                              color: Colors.black26,
                                              child: Text(
                                                playlist
                                                    .playlistsong[index].name
                                                    .toString()
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ))
                                      : Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255)),
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                              child: ColoredBox(
                                            color: Colors.black26,
                                            child: Text(
                                              playlist.playlistsong[index].name
                                                  .toString()
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ))));
                            }),
                      );
                    },
                  ))
            ],
          )),
    );
  }
}
