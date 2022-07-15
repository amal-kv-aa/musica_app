import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:musica_app/screens/search_page/provider/provider_search.dart';
import 'package:provider/provider.dart';
import 'screens/splash_page/splash_screen.dart';


void main() async{

  //=======landscap rotation lock=========//
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  //===============================////////////////////=====================================//
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(PlaylistmodelAdapter().typeId))
  {
   Hive.registerAdapter(PlaylistmodelAdapter()); 
  }
  await Hive.openBox('song_db');
  await Hive.openBox<Playlistmodel>('PlayListsongs_dB');
 await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  //PlaylistFunctions.getplayList();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Favsong()),
    ChangeNotifierProvider(create: (_)=> SearchProvider()),
    ChangeNotifierProvider(create: (_)=>PlayListProvider())
  ],
  child:const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    home: GetSplash(),
    debugShowCheckedModeBanner: false ,
    );
  }
}

