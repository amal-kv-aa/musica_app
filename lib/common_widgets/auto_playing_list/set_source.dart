
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SetSource extends StatelessWidget {
  const SetSource({ Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return 
   Container( 
   ); 
  }
    static  ConcatenatingAudioSource createPLaylist(List<SongModel>? songs) {
    List<AudioSource> sources = [] ;
    for ( var song in songs ! ) {
    sources.add(AudioSource.uri(Uri.parse(song.uri!),tag: MediaItem(id: song.id.toString(), title: song.title,artUri:Uri(path: song.uri)),)); 
    }
    return ConcatenatingAudioSource(children: sources);
    }
  
}