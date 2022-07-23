import 'package:flutter/material.dart';
import 'package:musica_app/screens/theme/theme.dart';
import 'package:provider/provider.dart';

class AlertFav extends StatelessWidget {
  const AlertFav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
 static showfavalert(BuildContext context,index){
     final themechange = Provider.of(context,listen: false)<Themeset>();
   
     showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    backgroundColor: themechange.themvalue != 2
                                        ? const Color.fromARGB(255, 49, 49, 49)
                                        : const Color.fromARGB(255, 48, 7, 20),
                                    title: const Text(
                                      'Remove from favorite?',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 33, 243, 226)),
                                    ),
                                    content: const Text(
                                        'the song will be permenantly removed  !!',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 115, 170, 180))),
                                    actions: [
                                      Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'cancel',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 31, 207, 199)),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                // context.read<Favbutton>().removeList(index);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Ok',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 31, 213, 219))))
                                        ],
                                      )
                                    ],
                                  );
                                });
  }
}