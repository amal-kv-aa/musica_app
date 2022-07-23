import 'package:flutter/material.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:musica_app/screens/theme/theme.dart';
import 'package:provider/provider.dart';

class ShowAlert extends StatelessWidget {
  const ShowAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static alert(BuildContext context, index) {
    final themechange = Provider.of<Themeset>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: themechange.themvalue != 2
                ? const Color.fromARGB(255, 44, 44, 44)
                : const Color.fromARGB(255, 80, 39, 52),
            title: Text(
              'Delete folder ${context.watch<PlayListProvider>().playlistsong[index].name}?',
              style: const TextStyle(color: Color.fromARGB(255, 62, 221, 239)),
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
