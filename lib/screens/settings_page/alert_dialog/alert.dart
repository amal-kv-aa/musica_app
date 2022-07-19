import 'package:flutter/material.dart';
import 'package:musica_app/screens/splash_page/splash_screen.dart';
import 'package:musica_app/screens/theme/theme.dart';
import 'package:provider/provider.dart';

class AlertSettings extends StatelessWidget {
  const AlertSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  static alertShow(BuildContext context) {
    final themechange = Provider.of<Themeset>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 49, 49, 49),
            title: const Text(
              'select your theme ',
              style: TextStyle(color: Color.fromARGB(255, 20, 211, 221)),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        themechange.checktheme(0);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (ctx) => const SplashScreen()),
                            (route) => false);
                      },
                      child: const Text(
                        'Default',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        themechange.checktheme(1);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (ctx) => const SplashScreen()),
                            (route) => false);
                      },
                      child: const Text('Dark',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)))),
                  ElevatedButton(
                      onPressed: () {
                        themechange.checktheme(2);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (ctx) => const SplashScreen()),
                            (route) => false);
                      },
                      child: const Text('Gradient',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)))),
                ],
              )
            ],
          );
        });
  }
}
