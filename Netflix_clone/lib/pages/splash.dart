import 'package:flutter/material.dart';
import 'package:netfix/pages/loby_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);
  @override
 
  State<SplashScreen> createState() => _SplashScreenState();
}
   
class _SplashScreenState extends State<SplashScreen> {
   initState(){
  gotohome();
  }
  @override
  Widget build(BuildContext context) {
     return Container(
    color: Colors.black,
    child: Center(
      child: Image.network('https://variety.com/wp-content/uploads/2020/05/netflix-logo.png',height: MediaQuery.of(context).size.height*0.13,),
    ), 
    );
  }

  Future gotohome() async{
    
  await Future.delayed(Duration(seconds: 4));
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>HomeScreen()));
 
  
  }

  }
