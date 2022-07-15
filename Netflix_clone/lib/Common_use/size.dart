import 'package:flutter/material.dart';

class Size extends StatelessWidget {
   Size({ Key? key, this.h,this.w }) : super(key: key);
  dynamic h;
  dynamic w;
  @override
  Widget build(BuildContext context) {
   
    return SizedBox(height:h !=null?  MediaQuery.of(context).size.height*h:0,width:w !=null? MediaQuery.of(context).size.width*w:0,);
  }
}