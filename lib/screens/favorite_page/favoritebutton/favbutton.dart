import 'package:flutter/material.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:musica_app/screens/home_page/home_page.dart';
import 'package:musica_app/screens/theme/theme.dart';
import 'package:provider/provider.dart';

class ButtonFav extends StatelessWidget {
   ButtonFav({Key? key,required this.id}) : super(key: key);
  int id;
  @override
  Widget build(BuildContext context) {
    final themechange = context.watch<Themeset>();
    return Consumer<Favbutton>(builder: (context, value, _) {
      final indexcheck = value.dblist.indexWhere((element) => element == id);
      if (value.dblist.contains(id) == true) {
        return IconButton(
            onPressed: () {
              context.read<Favbutton>().removeList(indexcheck);
            },
            icon: Icon(
              Icons.favorite,
              color: themechange.themvalue != 2
                  ? const Color.fromARGB(255, 0, 255, 208)
                  : const Color.fromARGB(255, 195, 12, 85),
            ));
      }
      return IconButton(
          onPressed: () async {
            await context
                .read<Favbutton>()
                .addfavsong(id);
          },
          icon: Icon(Icons.favorite_border_outlined,
              color: themechange.themvalue != 2
                  ? const Color.fromARGB(255, 21, 143, 145)
                  : const Color.fromARGB(255, 22, 16, 70)));
    });
  }
}
