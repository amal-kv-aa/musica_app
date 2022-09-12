import 'package:flutter/material.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:provider/provider.dart';

class ButtonFav extends StatelessWidget {
  const ButtonFav({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context) {
    return Consumer<Favbutton>(builder: (context, value, _) {
      final indexcheck = value.dblist.indexWhere((element) => element == id);
      if (value.dblist.contains(id) == true) {
        return IconButton(
            onPressed: () {
              context.read<Favbutton>().removeList(indexcheck);
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,size: 18,
            ));
      }
      return IconButton(
          onPressed: () async {
            await context.read<Favbutton>().addfavsong(id);
          },
          icon: const Icon(Icons.favorite_border_outlined,
              color:Colors.white,size: 18,));
    });
  }
}
