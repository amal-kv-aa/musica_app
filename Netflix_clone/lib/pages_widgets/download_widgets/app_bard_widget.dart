import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        IconButton(
                                  onPressed: () {}, icon: const Icon(Icons.search)),

                           CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg',),
                          )
      ],
    );
  }
}