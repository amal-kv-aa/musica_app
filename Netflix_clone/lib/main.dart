import 'package:flutter/material.dart';
import 'package:netfix/https_functions/functions.dart';
import 'package:netfix/pages/splash.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Apifunction.getmovies();
    return const MaterialApp(
     home: SplashScreen(),
    );
  }
}
