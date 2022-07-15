import 'package:flutter/material.dart';

class FastLaughs extends StatelessWidget {
  const FastLaughs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body: Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://messengernews.fb.com/wp-content/uploads/2021/11/ST360_03_MindFlayer.png?w=1920&h=1080&crop=1'),)),),
    );
  }
}