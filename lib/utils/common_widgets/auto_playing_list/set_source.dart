
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SetSource {
    static  ConcatenatingAudioSource createPLaylist(List<SongModel>? songs) {
    List<AudioSource> sources = [] ;
     sources.clear();
    for ( var song in songs ! ) {
    sources.add(AudioSource.uri(Uri.parse(song.uri!),tag: MediaItem(id: song.id.toString(), title: song.title,artUri:Uri(path: song.uri)),)); 
    }
    return ConcatenatingAudioSource(children: sources);
    }
  
}