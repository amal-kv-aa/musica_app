import 'package:flutter/material.dart';
import 'package:musica_app/auto_playing_list/set_source.dart';
import 'package:musica_app/screens/favorite_page/provider/provider.dart';
import 'package:musica_app/screens/home_page/home_page.dart';
import 'package:musica_app/screens/nowplaying_page/now_playing.dart';
import 'package:musica_app/screens/search_page/provider/provider_search.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
 
class SearchScreen extends StatelessWidget {

  const SearchScreen({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final searchpro = context.read<SearchProvider>();
    final favprovider = Provider.of<Favsong>(context,listen: false);
    final searchController = TextEditingController();
            return 
                  Container(
                    decoration: favprovider.themvalue == 0  ? const BoxDecoration(image:
                     DecorationImage(image: AssetImage('assets/images/music.jpg',),fit:BoxFit.cover )): 
                       BoxDecoration( gradient:favprovider.themvalue==1 || favprovider.themvalue==null ?  const LinearGradient( begin: Alignment.bottomLeft,
              end: Alignment.topLeft,colors:  [
                Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0),
              ]) : const LinearGradient( begin: Alignment.bottomLeft,
              end: Alignment.topLeft,colors:  [
                Color.fromARGB(255, 122, 0, 57),

                  Color.fromARGB(255, 11, 219, 226),
              
              ])),
                  child: ListView(
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.all(30),
                          child:  TextField(
                            onTap: (){},
                            onChanged: (String?  value){
                              if(value == null || value.isEmpty){
                              searchpro.temp.addAll(HomePage.songs);
                              }
                              searchpro.temp.clear();
                              for (SongModel i  in HomePage.songs ) {
                                if(i.title.toLowerCase().contains(value!.toLowerCase())){
                                  searchpro.temp.add(i);
                                } 
                                context.read<SearchProvider>().notifytemp();
                              }
                            },
                            controller: searchController,
                            decoration: InputDecoration(hintText: 'Search here',
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(25),     
                           ),
                           prefixIcon:const Icon(Icons.search,color: Colors.black,),
                           filled: true,
                            errorBorder: InputBorder.none,
                            fillColor: Colors.white,
                          ),                          
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height*0.6,
                          child: 
                          Consumer<SearchProvider>(builder: (context, searchlist, child) {
                           return ListView.builder(itemBuilder: (ctx, index){
                                 final data=searchlist.temp[index];
                                 return ListTile(
                                   onTap: (){
                                      NowPlaying.player.setAudioSource(
                                          SetSource.createPLaylist(searchlist.temp),
                                          initialIndex: index,                                          
                                        );
                                        NowPlaying.player.play();
                                     Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> NowPlaying(songs: searchlist.temp)));
                                   },
                                   title: Text(data.title,style:const TextStyle( color: Colors.white),overflow: TextOverflow.ellipsis,),
                                   leading: CircleAvatar(child: QueryArtworkWidget(id: data.id, type: ArtworkType.AUDIO,artworkBorder: BorderRadius.circular(0),)),
                                 );
                               },
                               itemCount: searchpro.temp.length,                           
                               );
                          },)
                        ),
                      )
                    ],
                  ),
                  );
  }
}