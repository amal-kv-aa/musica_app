import 'package:flutter/material.dart';
import 'package:musica_app/screens/playlist_page/model/data_model/data_model.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class AddAlert extends StatelessWidget {
  const AddAlert({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  static addfolder(BuildContext context, namecontroller) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor:const Color.fromARGB(245, 215, 215, 215),
            content: TextField(
                style: const TextStyle(color: Colors.black),
                controller: namecontroller,
                decoration: const InputDecoration(
                    hintText: 'Enter title',
                    
                    hintStyle:
                        TextStyle(color: Colors.black))),
            actions: [
             ElevatedButton(
                      onPressed: () {
                        if (namecontroller.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'title required',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 60, 223, 235)),
                            ),
                            behavior: SnackBarBehavior.fixed,
                            backgroundColor: Color.fromARGB(58, 148, 148, 148),
                          ));
                          Navigator.pop(context);
                        }
                        if (namecontroller.text.isNotEmpty) {
                          final name = namecontroller.text;
                          final model =
                              Playlistmodel(name: name, dbsonglist: []);
                          context
                              .read<PlayListProvider>()
                              .addplaylist(model: model);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Done',
                          style: TextStyle(
                              color: Color.fromARGB(255, 100, 240, 255))),
                              style: ElevatedButton.styleFrom(primary: Colors.black),
                              )
            ],
          );
        });
  }
}
