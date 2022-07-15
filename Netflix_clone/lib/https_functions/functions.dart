
// import 'package:http/http.dart' as http;

//  class functions{
//  static Future<void>getdata()async{
//      final _response = await http.get(Uri.parse('https://api.themoviedb.org/3/trending/movie/week?api_key=d9479731a4afed0c0780f951d8dbd5e5'));

//      print(_response.body);
//   }
// }

import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

 class Apifunction extends StatefulWidget {
   Apifunction({ Key? key }) : super(key: key);

 static List tredingMovies=[];
static List comingsoon=[];
 static List tvshow=[];
 static List movies=[];
 static List getpopular=[];
static getmovies()async{
   final String apikey='d9479731a4afed0c0780f951d8dbd5e5';
 final String readaccesstoken ='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOTQ3OTczMWE0YWZlZDBjMDc4MGY5NTFkOGRiZDVlNSIsInN1YiI6IjYyYWQ2M2U0ZWI2NGYxMDA2NDMxMTk2NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KG-LrxvlkbDho30U4XNm9QWnSA0dv4IuJlvA9H4qPxg';
 
  TMDB tmdbithcoustomLogs = TMDB(ApiKeys(apikey, readaccesstoken),
  logConfig:const ConfigLogger(
  showLogs:true,
  showErrorLogs:true,
  )
  );
  Map tredingresult = await tmdbithcoustomLogs.v3.trending.getTrending();
  Map tvshowresult=await tmdbithcoustomLogs.v3.tv.getPopular();
  Map movieresults=await tmdbithcoustomLogs.v3.movies.getTopRated();
  Map comingsoon=await tmdbithcoustomLogs.v3.movies.getUpcoming();
 Map getpopular=await tmdbithcoustomLogs.v3.movies.getPopular();
 Apifunction.tredingMovies = tredingresult['results'];
     Apifunction.tvshow=tvshowresult['results'];
     Apifunction.movies=movieresults['results'];
     Apifunction.comingsoon=comingsoon['results'];
     Apifunction.getpopular= getpopular['results'];

  }
  @override

  State<Apifunction> createState() => _ApifunctionState();
}

class _ApifunctionState extends State<Apifunction> {
  @override
  
  Widget build(BuildContext context) {
    return Container();
  }

 
}