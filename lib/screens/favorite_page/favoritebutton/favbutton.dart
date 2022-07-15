import 'package:flutter/material.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:provider/provider.dart';

class FavButton extends StatelessWidget {
  const FavButton({Key? key, this.id}) : super(key: key);
  final int? id;
  @override
  Widget build(BuildContext context) {
    final indexcheck =
        context.watch<Favsong>().dblist.indexWhere((element) => element == id);
    return Consumer<Favsong>(builder: (context, value, _) {
      if (value.dblist.contains(id) == true) {
        return IconButton(
            onPressed: () {
              value.removeList(indexcheck);
            },
            icon: Icon(
              Icons.favorite,
              color: value.themvalue != 2
                  ? const Color.fromARGB(255, 0, 255, 208)
                  : const Color.fromARGB(255, 195, 12, 85),
            ));
      }
      return IconButton(
          onPressed: () async {
            await value.addfavsong(id);
          },
          icon: Icon(Icons.favorite_border_outlined,
              color: value.themvalue != 2
                  ? const Color.fromARGB(255, 21, 143, 145)
                  : const Color.fromARGB(255, 22, 16, 70)));
    });
  }
}
