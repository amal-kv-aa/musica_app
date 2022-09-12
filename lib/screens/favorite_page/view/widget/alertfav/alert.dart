import 'package:flutter/material.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:provider/provider.dart';

class AlertFav {
  static showfavalert(BuildContext context, index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Remove from favorite?',
              style: TextStyle(),
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
                        style: TextStyle(color:  Color.fromARGB(255, 0, 208, 212)),
                      )),
                  TextButton(
                      onPressed: () {
                        context.read<Favbutton>().removeList(index);
                        Navigator.pop(context);
                      },
                      child: const Text('Ok',
                          style: TextStyle(color: Color.fromARGB(255, 0, 208, 212))))
                ],
              )
            ],
          );
        });
  }
}
