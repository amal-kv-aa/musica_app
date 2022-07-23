import 'package:flutter/material.dart';

class LogoTop extends StatelessWidget {
  const LogoTop({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
          border: Border.all(color:const Color.fromARGB(255, 19, 201, 98), width: 2),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [BoxShadow(
            blurRadius: 5,
            offset: Offset(0,0),
            color: Color.fromARGB(255, 14, 225, 179),
          )],
          color:const Color.fromARGB(255, 0, 0, 0)),
      child: const Center(
          child: Text(
        'musica',
        style: TextStyle(
            fontFamily: 'cursive', fontSize: 25, color: Color.fromARGB(251, 35, 255, 237)),
      ),
      ),
    );
  }
}