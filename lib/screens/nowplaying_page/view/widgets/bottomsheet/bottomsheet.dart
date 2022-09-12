import 'package:flutter/material.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:musica_app/screens/playlist_page/view/widgets/alert/folderadd/folderadd.dart';
import 'package:musica_app/screens/playlist_page/view/widgets/button_playlist/add_button.dart';
import 'package:provider/provider.dart';

class BottomSheets extends StatelessWidget {
  const BottomSheets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static showmodel(BuildContext context, int id) {
    TextEditingController namecontroller = TextEditingController();
    return
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration:
                 const  BoxDecoration(color:Colors.white),
              child: Consumer<PlayListProvider>(
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        InkWell(
                          onTap: () {
                            AddAlert.addfolder(context, namecontroller);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 200, 200, 200),
                              border: Border.all(
                                  width: 2,
                                  color:
                                     const Color.fromARGB(255, 13, 13, 13)),
                            ),
                            child: const Center(
                              child: Text(
                                'Create new Playlist',
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.36,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                              itemCount: context
                                  .watch<PlayListProvider>()
                                  .playlistsong
                                  .length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white30),
                                            borderRadius: BorderRadius.circular(30),
                                        color: Colors.black),
                                    child: ListTile(
                                      title: Text(
                                        context
                                            .watch<PlayListProvider>()
                                            .playlistsong[index]
                                            .name
                                            .toString()
                                            .toUpperCase(),
                                        style:
                                            const TextStyle(color:Colors.white),
                                      ),
                                      trailing: PlaylistButton(
                                          folderindex: index, song: id),
                                    ),
                                  ),
                                );
                              })),
                        ),
                      ],
                    ),
                  );
                },
              ));
        });
  }
}
