import 'package:flutter/material.dart';
import 'package:netfix/home_cards/cards_home.dart';
import 'package:netfix/home_cards/fonts.dart';
import 'package:netfix/https_functions/functions.dart';
import 'package:netfix/pages_widgets/download_widgets/app_bard_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
   
  Widget build(BuildContext context) {    
    return Scaffold(
      extendBodyBehindAppBar: true,
        backgroundColor:const Color.fromRGBO(0, 0, 0, 1),
        body: CustomScrollView(
          
          slivers: [
            SliverAppBar(
              
              collapsedHeight: 90,
              centerTitle: null,
              toolbarHeight: 90,
              title: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.14, top: MediaQuery.of(context).size.height*0.05),
                child: Row(
                  children: [
                    TextModify(text: 'TV Show',fontsize: 16,colors: Colors.white,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                     TextModify(text: 'Movies',fontsize: 16,colors: Colors.white,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Row(
                      children:  [
                       TextModify(text: 'Categories',fontsize: 16,colors: Colors.white,),
                        const SizedBox(
                          width: 3,
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.black54,
              expandedHeight: 500,
              pinned:true ,
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                decoration:    BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                             'https://image.tmdb.org/t/p/w500' +
                                Apifunction.getpopular[2]['poster_path']
                           ),
                        fit: BoxFit.cover)
                        ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SafeArea(
                        child: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          leading: Image.network(
                              'https://user-images.githubusercontent.com/33750251/59487006-313d6080-8e73-11e9-8c50-3a5660761138.png'),
                          actions: [
                           const AppbarWidget(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.43,
                        ),
                        child: Expanded(
                          child: Container(
                             decoration:  BoxDecoration(color: Colors.transparent,boxShadow: [
                            BoxShadow(
                             blurRadius: 60,
                             spreadRadius: 55,
                              color: Colors.black.withOpacity(0.9),
                            
                            )
                          ]),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'offbeat -',
                                            style: TextStyle(color: Colors.white),
                                          )),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'psychological -',
                                            style: TextStyle(color: Colors.white),
                                          )),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'thriller ',
                                            style: TextStyle(color: Colors.white),
                                          )),
                                    ],
                                  ),
                                   Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'My List',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Colors.white,
                                  height: MediaQuery.of(context).size.height * 0.043,
                                  child: Row(children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width * 0.03),
                                    const Icon(Icons.play_arrow),
                                    const Text('Play'),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.04,
                                    )
                                  ]),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'info',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255)),
                                    ),
                                  ],
                                ),
                              ],
                                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: const [
                        Text(
                          'Popular on netflix',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
           const HomeCard(),
          ],
        ));
  }
}
