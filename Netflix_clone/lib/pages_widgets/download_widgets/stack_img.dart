
import 'package:flutter/material.dart';

class ImageCollaps extends StatelessWidget {
   ImageCollaps({ Key? key,required this.height,required this.width,required this.angle,required this.img,required this.mrgleft, required this.mrgright}) : super(key: key);
 final double height;
 final double width;
 final dynamic angle;
 final dynamic img;
 final double mrgleft;
 final double mrgright;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
            angle:angle,
            child: Container(
             height: height,
             width: width,
             decoration: BoxDecoration(image: DecorationImage(image:
              NetworkImage(img
              ),fit: BoxFit.fill
             ),
             borderRadius:const BorderRadius.all(Radius.circular(8)),
             ),margin: EdgeInsets.only(left: mrgleft,right:mrgright,
        
              )             
            ),
          );
  }
}
