import 'package:flutter/material.dart';

class LogoTop extends StatelessWidget {
  const LogoTop({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.20,
        decoration: BoxDecoration(
            border: Border.all(color:const Color.fromARGB(188, 0, 0, 0), width: 2),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [BoxShadow(
              blurRadius: 5,
              offset: Offset(0,0),
              color: Colors.white,
            )],
            color:const Color.fromARGB(255, 0, 0, 0)),
        child: const Center(
            child: Text(
          'musica',
          style: TextStyle(
              fontFamily: 'cursive', fontSize: 15, color: Color.fromARGB(251, 35, 255, 237)),
        ),
        ),
      ),
    );
  }
}