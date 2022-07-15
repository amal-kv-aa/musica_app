import 'package:flutter/material.dart';
import 'package:netfix/pages/Downloads.dart';
import 'package:netfix/pages/coming_soon.dart';
import 'package:netfix/pages/fast_laughs.dart';
import 'package:netfix/pages/home_page.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({ Key? key }) : super(key: key);
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
    int _currentIndex = 0; 

   // final PageController _pagecontroller = PageController(initialPage: 0);

   final _bottomnavigationbaritem = [
    BottomNavigationBarItem(
        icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
               
                color:const Color.fromARGB(97, 0, 0, 0),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    width: 1, color:const Color.fromARGB(255, 0, 0, 0))),
            child: const Icon(
              Icons.home_outlined,
              
            ),
         ),
        label: 'Home'),
         BottomNavigationBarItem(
        icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
               
                color:const Color.fromARGB(97, 0, 0, 0),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    width: 1, color:const Color.fromARGB(255, 0, 0, 0))),
            child: const Icon(
              Icons.collections_outlined,
             
            )),
        label: 'Coming soon'),
    BottomNavigationBarItem(
        icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              
                color:const Color.fromARGB(97, 0, 0, 0),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    width: 1,  color:const Color.fromARGB(255, 0, 0, 0))),
            child: const Icon(
              Icons.emoji_emotions_outlined,
             
            )),
        label: 'Fast Laughs'),
    BottomNavigationBarItem(
        icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color:const Color.fromARGB(97, 0, 0, 0),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    width: 1, color:const Color.fromARGB(255, 0, 0, 0))),
            child: const Icon(
              Icons.download_for_offline_rounded
             
            )),
        label: 'Downloads'),
   
  ];
  final List _pages=const[ HomePage(), ComingSoon(), FastLaughs(), Downloads()];

  Widget build(BuildContext context) {
     return 
    Scaffold(
      extendBody:true,
      body:_pages[_currentIndex],
      bottomNavigationBar:  BottomNavigationBar(
                  backgroundColor:Colors.black,
                  elevation: 0,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  selectedItemColor:const Color.fromARGB(255, 255, 255, 255),
                  unselectedItemColor:const Color.fromARGB(255, 70, 69, 69),        
                  items: _bottomnavigationbaritem,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  onTap: (NewIndedx){
                  setState(() {
                    _currentIndex = NewIndedx;
                  });
                  },
               
                  
      ),
    );
    
    
      
    
  }
}
 
