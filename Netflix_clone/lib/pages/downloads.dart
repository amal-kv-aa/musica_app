import 'dart:math';
import 'package:flutter/material.dart';
import 'package:netfix/home_cards/cards_home.dart';
import 'package:netfix/home_cards/fonts.dart';
import 'package:netfix/https_functions/functions.dart';
import 'package:netfix/pages_widgets/download_widgets/app_bard_widget.dart';
import 'package:netfix/pages_widgets/download_widgets/stack_img.dart';

class Downloads extends StatelessWidget {
 const Downloads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: TextModify(
          text: 'Downloads',
          colors: Colors.white,
          fontsize: 18,
        ),
        actions: [
        AppbarWidget(),
          SizedBox(width: size.width*0.05,)
        ],
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding:  EdgeInsets.all(size.width*0.04),
        child: SizedBox(
           height: size.height,
                width: size.width,
          child: ListView(
            children: [
              Row(
                children: [
                 const Icon(Icons.settings,color: Colors.white54,),
                  TextModify(text: 'Smart Downloads',colors: Colors.white54,),
                ],
              ),
              SizedBox(height: size.height*0.05,),
              SizedBox(height: size.height*0.05,
              child:TextModify(text: 'Introducing Downloads For You',colors: Colors.white,fontsize: 20,),
              ),
              TextModify(text: "we'll download a personalised selection of movies and shows for you,so there's always something to watch on your phone.",colors: Colors.white54,),
              SizedBox(height: size.height*0.01,),
              Stack(alignment: Alignment.center, children: [
                 CircleAvatar(
                  radius: size.height*0.16,
                  backgroundColor:const Color.fromARGB(255, 50, 50, 50),
                ),
                ImageCollaps(
                  height: size.height * 0.23,
                  width: size.width * 0.37,
                  angle: 45 * pi / 280,
                  img: 'https://image.tmdb.org/t/p/w500' +
                      Apifunction.comingsoon[2]['poster_path'],
                  mrgleft: 150,
                  mrgright: 0.0,
                ),
                ImageCollaps(
                    height: size.height * 0.23,
                    width: size.width * 0.37,
                    angle: -50 * pi / 260,
                    img: 'https://image.tmdb.org/t/p/w500' +
                        Apifunction.tredingMovies[1]['poster_path'],
                    mrgright: 150,
                    mrgleft: 0.0),
                ImageCollaps(
                    height: size.height * 0.26,
                    width: size.width * 0.37,
                    angle: 0.0,
                    img: 'https://image.tmdb.org/t/p/w500' +
                        Apifunction.tredingMovies[12]['poster_path'],
                    mrgleft: 0.0,
                    mrgright: 0.0)
              ]),
              SizedBox(height: size.height*0.08,),
              ElevatedButton(onPressed: (){}, child: TextModify(text: 'Set Up',colors: Colors.white,))
            ],
          ),
        ),
      ),
    );
  }
}
