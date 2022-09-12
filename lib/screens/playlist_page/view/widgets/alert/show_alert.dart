import 'package:flutter/material.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class ShowAlert extends StatelessWidget {
  const ShowAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  static alert(BuildContext context, index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Delete folder ${context.watch<PlayListProvider>().playlistsong[index].name}?',
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
                        context.read<PlayListProvider>().deleteplaylist(index);
                        Navigator.pop(context);
                        Navigator.pop(context);
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
