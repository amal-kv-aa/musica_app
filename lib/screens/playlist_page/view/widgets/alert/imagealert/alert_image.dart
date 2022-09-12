import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musica_app/screens/playlist_page/model/data_model/data_model.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:musica_app/screens/playlist_page/view/widgets/alert/show_alert.dart';
import 'package:musica_app/screens/playlist_page/view/widgets/button_playlist/add_button.dart';
import 'package:provider/provider.dart';

class ImageAlert {
  static showAlert(BuildContext context, index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                  onPressed: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image == null) {
                      return;
                    } else {
                      File imagepath = File(image.path);
                      final model = Playlistmodel(
                          name: context
                              .read<PlayListProvider>()
                              .playlistsong[index]
                              .name,
                          dbsonglist: PlaylistButton.updatelist,
                          image: imagepath.path);
                      context.read<PlayListProvider>().updatlist(index, model);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Change Background Image',
                    style: TextStyle(color: Colors.black),
                  )),
              IconButton(
                  onPressed: () {
                    ShowAlert.alert(context, index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          );
        });
  }
}
