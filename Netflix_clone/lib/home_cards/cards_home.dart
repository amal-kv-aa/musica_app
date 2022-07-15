import 'package:flutter/material.dart';
import 'package:netfix/home_cards/bottom_sheet.dart';
import 'package:netfix/home_cards/fonts.dart';
import 'package:netfix/https_functions/functions.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({ Key? key }) : super(key: key);
  
  @override
  
  Widget build(BuildContext context) {
    final  Size= MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            // width: 500,
            height: Size.height*0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Apifunction.tredingMovies.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Detailes(
                            img: 'https://image.tmdb.org/t/p/w500' +
                                Apifunction.tredingMovies[index]['poster_path'],
                            title: Apifunction.tredingMovies[index]
                                    ['original_title'] ??
                                'Loading......',
                            titledetailes: Apifunction.tredingMovies[index]
                                    ['overview'] ??
                                'Loading......',
                            bgimg: 'https://image.tmdb.org/t/p/w500' +
                                Apifunction.tredingMovies[index]
                                    ['backdrop_path'],
                            relesedate: Apifunction.tredingMovies[index]
                                    ['release_date'] ??
                                'Loading......',
                            rating: Apifunction.tredingMovies[index]
                                    ['vote_average'] ??
                                'Loading......',
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      color: Colors.white,
                      // height: 150,
                      // width: 100,
                      child:
                          // Text(tredingmovieslist[index]['title'] !=null ? tredingmovieslist[index]['title']:'loading'),
                          Image.network(
                        'https://image.tmdb.org/t/p/w500' +
                            Apifunction.tredingMovies[index]['poster_path'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                children: [
                  TextModify(
                    text: 'Now on Treding',
                    colors: Colors.white,
                    fontsize: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            //width: Size.width*0.4,
            height: Size.height*0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Apifunction.tvshow.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    color: Colors.white,
                    // height: 150,
                    // width: 100,
                    child:
                       
                        Image.network(
                      'https://image.tmdb.org/t/p/w500' +
                          Apifunction.tvshow[index]['poster_path'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                children: [
                  TextModify(
                    text: 'Top Rated',
                    colors: Colors.white,
                    fontsize: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            // width: 500,
            height: Size.height*0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Apifunction.movies.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    color: Colors.white,
                    // height: 150,
                    // width: 100,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500' +
                          Apifunction.movies[index]['poster_path'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
           SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                children: [
                  TextModify(
                    text: 'Coming',
                    colors: Colors.white,
                    fontsize: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            // width: 460,
            height: Size.height*0.35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Apifunction.getpopular.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    color: Colors.white,
                    // height: 150,
                    // width: 200,
                    child:
                       
                        Image.network(
                      'https://image.tmdb.org/t/p/w500' +
                          Apifunction.getpopular[index]['poster_path'],
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
           SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                children: [
                  TextModify(
                    text: 'Coming',
                    colors: Colors.white,
                    fontsize: 20,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            // width: 350,
            height: Size.height*0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Apifunction.comingsoon.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    color: Colors.white,
                    height: 150,
                    width: 300,
                    child:
                       
                        Image.network(
                      'https://image.tmdb.org/t/p/w500' +
                          Apifunction.comingsoon[index]['backdrop_path'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.14,
          )
        ],
      ),
    );
  }
}