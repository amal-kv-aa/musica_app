import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static var selectedthem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: ColoredBox(
          color:Colors.black,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return const AlertDialog(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          content: Text(
                            'Musica is a offline music player developed  by \namal kv\nThanks for using\nenjoy music',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'cursive',
                                fontSize: 26),
                          ),
                          actions: [],
                        );
                      });
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.info_outline,color: Colors.white,
                  ),
                  title: Text(
                    'About',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 49, 49, 49),
                          title: const Text(
                            'Reset App ? ',
                            style: TextStyle(
                                color: Colors.white),
                          ),
                          content: const Text(
                            'All Your saved data will be removed !',
                            style: TextStyle(
                                color: Colors.white),
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
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 33, 222, 243)),
                                    )),
                                TextButton(
                                    onPressed: () {
                                    },
                                    child: const Text('Ok',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 33, 222, 243))))
                              ],
                            )
                          ],
                        );
                      });
                },
                leading: const Icon(
                  Icons.replay_circle_filled_rounded,
                  color: Colors.white,
                ),
                title: const Text(
                  'Reset App',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.stay_current_portrait_sharp,
                  color: Colors.white,
                ),
                title: Text(
                  'Version',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Text(
                  '1.0.2',
                  style: TextStyle(
                    color:  Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const ListTile(
                title: Center(
                  child: Text(
                    'Contact',
                    style: TextStyle(
                      color:  Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse('https://github.com/amal-kv-aa'));
                    },
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Image.asset('assets/images/Github-512.webp')),
                  ),
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(
                          'https://www.linkedin.com/public-profile/settings?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_self_edit_contact-info%3B9%2BjHvRruQfW0XmNCXAfRow%3D%3D'));
                    },
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Image.asset(
                            'assets/images/linkedin-icon-png-blue-button-linkedin-social-icon-download-png-512.png')),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
