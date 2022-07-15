import 'package:flutter/material.dart';
import 'package:netfix/home_cards/fonts.dart';

class FullDetailes extends StatelessWidget {
  FullDetailes({ Key? key,required this.img ,required this.relsedate,required this.title,required this.detailes,required this.rating,required this.profimg}) : super(key: key);
  dynamic img;
  String title;
  String relsedate;
  String detailes;
  dynamic rating;
  String profimg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
    appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0, actions:const [Icon(Icons.search,color: Colors.white,)],),
    body: SafeArea(
      child: Column(
        children: [
          Container(
            height:MediaQuery.of(context).size.height*0.3,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(img),fit: BoxFit.cover)
            ),
            
          ),
          Padding(
            padding:  EdgeInsets.all(MediaQuery.of(context).size.height*0.02),
            child: SizedBox(
              child: Column(children: [
                  Row(children: [
                const Icon(Icons.star,color: Colors.yellow,),
                TextModify(text: '$rating',colors: Colors.white,)
              ],),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            
            Row(
              children: [
                 Padding(
                                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.026),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.28,
                                    maxHeight: MediaQuery.of(context).size.width * 0.28,
                                  ),
                                  child: Image.network(
                                     profimg,
                                      fit: BoxFit.fill
                                  ),
                                ),
                              ),
                              SizedBox( width: MediaQuery.of(context).size.width * 0.05,),
                            SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                        child: TextModify(
                                          text: title,
                                         colors: Colors.white,
                                         fontsize: 20,
                                        ),
                                      ),
                                    ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            Row(
              children: [
                 TextModify(text: 'Releas on     $relsedate',colors: Colors.white),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
             TextModify(text: detailes,colors: Colors.white54,)
              ],),
            ),
          )
       
        ],
      ),
    ),
    );
  }
}