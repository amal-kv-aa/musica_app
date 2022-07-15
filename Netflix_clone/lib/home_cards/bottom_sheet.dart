import 'package:flutter/material.dart';
import 'package:netfix/home_cards/fonts.dart';
import 'package:netfix/pages/full_detailes.dart';

class Detailes extends StatelessWidget {
   Detailes({ Key? key,required this.img, required this.title ,required this.titledetailes,required this.bgimg,required this.relesedate,required this.rating}) : super(key: key);
  dynamic img;
  String title;
  String titledetailes;
  dynamic bgimg;
  String relesedate;
  dynamic rating;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height*0.33,
        color:Color.fromARGB(255, 79, 78, 78),
        child: 
        SizedBox(
                    width: MediaQuery.of(context).size.width * 0.94,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      color :Color.fromARGB(179, 86, 85, 85),
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,top: MediaQuery.of(context).size.height*0.026),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.35,
                                    maxHeight: MediaQuery.of(context).size.width * 0.35,
                                  ),
                                  child: Image.network(
                                     img,
                                      fit: BoxFit.fill
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.56,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                        child: TextModify(
                                          text: title,
                                         colors: Colors.white,
                                         fontsize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.56,
                                      
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                        child: 
                                        TextModify(
                                          text: titledetailes,
                                          colors: Colors.white54,
                                          fontsize: 13,
                                          
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                             Expanded(
                               child: IconButton(icon:const Icon(Icons.dangerous,color: Color.fromARGB(255, 184, 182, 182),),onPressed: (){
                                Navigator.pop(context);
                               },),
                             )
                            ],
                          ),
                         SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                          SizedBox(
                            height:  MediaQuery.of(context).size.width * 0.07,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                CircleAvatar(child: Icon(Icons.play_arrow_rounded,color: Colors.black,),backgroundColor: Color.fromARGB(255, 255, 255, 255),),
                                CircleAvatar(child: Icon(Icons.download,color: Color.fromARGB(255, 255, 255, 255),),backgroundColor: Color.fromARGB(255, 0, 0, 0),),
                                 CircleAvatar(child: Icon(Icons.add,color: Color.fromARGB(255, 255, 255, 255),),backgroundColor: Color.fromARGB(255, 0, 0, 0),),
                                 CircleAvatar(child: Icon(Icons.share_outlined,color: Color.fromARGB(255, 255, 255, 255),),backgroundColor: Color.fromARGB(255, 0, 0, 0),),
                              ],
                            ),
                          ),
                               ListTile(leading: const Icon(Icons.info,color: Colors.white,),
                              title:TextModify(text: 'Detailes & More',colors: Colors.white,fontsize: 12,) ,
                              trailing:const Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>FullDetailes(img: bgimg,title: title,detailes:titledetailes,rating: rating,profimg: img,
                                relsedate: relesedate,
                                )));
                              },
                              ), 
                        ],
                      ),
                    ),
                  ),          
      ),
    );
          
    
  }
}