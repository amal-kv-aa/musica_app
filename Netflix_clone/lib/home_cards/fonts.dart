import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextModify extends StatelessWidget {
  final String? text;
  final Color ?colors;
  final double? fontsize;
   TextModify({ Key? key, required this.text, this.colors, this.fontsize }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??'no name',style:GoogleFonts.breeSerif(color: colors,fontSize: fontsize),maxLines: 4,
    );
  }
}