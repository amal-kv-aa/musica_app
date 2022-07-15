import 'package:flutter/material.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:musica_app/screens/loby_page/home_main.dart';
import 'package:provider/provider.dart';

class GetSplash extends StatefulWidget {
  const GetSplash({ Key? key }) : super(key: key);
  
  @override
  State<GetSplash> createState() => _GetSplashState();
}

class _GetSplashState extends State<GetSplash> {
  @override
  void initState() {
    gotohome(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final favprovider = Provider.of<Favsong>(context,listen: false); 
  favprovider.gettheme(); 
    return Scaffold(
      
      body: 
      Container(
         decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255)),
        child: Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.23,),
              Container(height: MediaQuery.of(context).size.height*0.16,
              width: MediaQuery.of(context).size.width*0.5,
              decoration: const BoxDecoration(           
               image: DecorationImage(image: AssetImage('assets/images/img mu.png',),fit: BoxFit.cover),
               
              ),
              ),  const Text('musica',style:TextStyle(color: Color.fromARGB(248, 0, 0, 0),fontSize: 40,fontFamily: 'cursive',shadows: [
                   Shadow(
                    blurRadius:10,
                    offset: Offset(8,-7),
                    color: Color.fromARGB(255, 0, 0, 0)
                  )
                ])),
                SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                Container(height: MediaQuery.of(context).size.height*0.2,
                width: MediaQuery.of(context).size.width*0.5,
                  decoration:const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/loading-spinner-gif-3.gif'),fit: BoxFit.fitHeight)),
                )
            ],
          ),
        ),
      ),
    );
  }
}
Future  gotohome(BuildContext context)async{
 await Future.delayed(const Duration(seconds: 3)) ;
 return {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> const HomeScreen()))
 };
} 