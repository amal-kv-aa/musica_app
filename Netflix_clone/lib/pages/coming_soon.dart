import 'package:flutter/material.dart';
import 'package:netfix/Common_use/size.dart';
import 'package:netfix/home_cards/cards_home.dart';
import 'package:netfix/home_cards/fonts.dart';
import 'package:netfix/https_functions/functions.dart';
import 'package:netfix/pages_widgets/download_widgets/app_bard_widget.dart';
class ComingSoon extends StatelessWidget {
  const ComingSoon({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  size = MediaQuery.of(context).size;
    return  Scaffold(
          backgroundColor:const Color.fromARGB(255, 0, 0, 0),
    appBar: AppBar(backgroundColor: Colors.black,
    actions: [
      const AppbarWidget(),
      Size(w: 0.03,h: 0,)
    ],
    ),
    body: 
      Container(
        child: ListView.builder(
        itemCount: Apifunction.comingsoon.length,
        itemBuilder: ((context, index) {
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: TextModify(text:  Apifunction.comingsoon[index]['original_title'],colors: Colors.white,fontsize: 20,)),
                  ],
                ),
                SizedBox(height: size.height*0.03,),
                Container(
                  height: size.height*0.26,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: 
                    NetworkImage( 'https://image.tmdb.org/t/p/w500' +
                                      Apifunction.comingsoon[index]['backdrop_path']),
                                      fit: BoxFit.cover
                    ),
                  ),

                ),
                
                SizedBox(height: size.height*0.02,),
                SizedBox(
                  child: TextModify(text: Apifunction.tredingMovies[index]
                                    ['overview'] ??
                                'Loading......',colors: Colors.white.withOpacity(0.9),))
              ],
            ),
          );
        })),
      )
    );
  }
}