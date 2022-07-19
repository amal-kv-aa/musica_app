import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:musica_app/screens/home_page/provider/home_provider.dart';
import 'package:musica_app/screens/loby_page/provider/home_provider.dart';
import 'package:musica_app/screens/miniplayer/miniplayer.dart';
import 'package:musica_app/screens/miniplayer/provider/mini_provider.dart';
import 'package:musica_app/screens/nowplaying_page/provider/nowplayer_provider.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:musica_app/screens/search_page/provider/provider_search.dart';
import 'package:musica_app/screens/theme/theme.dart';
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

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Themeset()),
    ChangeNotifierProvider(create: (_)=> SearchProvider()),
    ChangeNotifierProvider(create: (_)=>PlayListProvider()),
    ChangeNotifierProvider(create: (_)=> HomeProvider()),
    ChangeNotifierProvider(create: (_)=>MiniProvider()),
    ChangeNotifierProvider(create: (_)=>NowplayProvider()),
    ChangeNotifierProvider(create: (_)=>Favbutton()),
    ChangeNotifierProvider(create: (_)=>LobyProvider())
  ],
  child:const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false ,
    );
  }
}

