import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musica_app/data_model/data_model.dart';
import 'package:musica_app/screens/playlist_page/playlist_folder.dart';
import 'package:musica_app/screens/playlist_page/provider/playlist_provider.dart';
import 'package:musica_app/screens/playlist_page/widgets/alert/show_alert.dart';
import 'package:musica_app/screens/playlist_page/widgets/button_playlist/add_button.dart';
import 'package:musica_app/screens/theme/theme.dart';
import 'package:provider/provider.dart';


class PlayList extends StatelessWidget {
  PlayList({Key? key  , this.addplaylist }) : super(key: key);
  final namecontroller = TextEditingController();
   String? name ;
   int? addplaylist ;
  @override
  Widget build(BuildContext context) {
     
      final playprovider = Provider.of<PlayListProvider>(context,listen: false);
    final themechange = Provider.of<Themeset>(context,listen: false);
    // playprovider.getplayList();
    return Scaffold(
      body: Container(
        decoration: themechange.themvalue == 0  ? const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/music.jpg',
              ),
              fit: BoxFit.cover),
        ):   BoxDecoration( gradient:themechange.themvalue==1 || themechange.themvalue==null ?  const LinearGradient( begin: Alignment.bottomLeft,
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
              padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width*0.2 , left: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.width*0.05),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:const Color.fromRGBO(19, 29, 44, 1).withOpacity(0.8),),
                height: MediaQuery.of(context).size.height * 0.06,
                child: Center(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01, left: MediaQuery.of(context).size.width*0.08, right: MediaQuery.of(context).size.width*0.08),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              backgroundColor:themechange.themvalue!=2 ?
                                    const    Color.fromARGB(255, 49, 49, 49) :const  Color.fromARGB(57, 135, 91, 100),
                              content: TextField(
                                  style:const TextStyle(color: Colors.white),
                                  controller: namecontroller,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter title',hintStyle: TextStyle(color: Color.fromARGB(255, 99, 214, 240)))),
                              actions: [
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          if (namecontroller.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                'title required',
                                                style: TextStyle(
                                                    color: Color.fromARGB(255, 60, 223, 235)),
                                              ),
                                              behavior: SnackBarBehavior.fixed,
                                              backgroundColor: Color.fromARGB(58, 148, 148, 148),
                                            ));
                                             Navigator.pop(context);
                                          }
                                          if(namecontroller.text.isNotEmpty){
                                              final name = namecontroller.text;
                                         final model = Playlistmodel(
                                              name: name, dbsonglist: []);
                                          playprovider.addplaylist(
                                              model: model);
                                          Navigator.pop(context);
                                          }                                       
                                        },
                                      child: const Text('Done',
                                            style: TextStyle(
                                                color: Color.fromARGB(255, 100, 240, 255))))
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    leading:const Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 33, 205, 243),
                    ),
                    title: const Text(
                      'Create Playlist',
                      style: TextStyle(color: Color.fromARGB(255, 110, 236, 255)),
                    ),
                    
                  ),
                ),
              ),
            ),
            
            SizedBox(height:  MediaQuery.of(context).size.height * 0.02,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child:
              Consumer<PlayListProvider
              >(builder: (context, playlist, child) {
                return
                 Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 160,
                            mainAxisExtent: 140,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: playlist.playlistsong.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return InkWell(
                              onTap: () {
                               
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => PlaylistFolder(
                                          newindex: index,
                                        )));
                                
                              },
                              onLongPress: ( 
                              ) {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        backgroundColor:themechange.themvalue !=2 ?const Color.fromARGB(255, 56, 56, 56):  const Color.fromARGB(57, 135, 91, 100),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery );
                                                if (image == null){
                                                  return;
                                                } else {
                                                  File imagepath = 
                                                      File(image.path);
                                                   final model= Playlistmodel(name: playprovider.playlistsong[index].name,dbsonglist:PlaylistButton.updatelist,image: imagepath.path);
                                                   playprovider.updatlist(index, model);
                                                   Navigator.pop(context);
                                                }
                                              },
                                              child:
                                              const    Text('Change Background Image' ,style: TextStyle(color: Color.fromARGB(255, 36, 226, 207)),)),
                                          IconButton(
                                              onPressed: () {
                                               ShowAlert.alert(context,index);
                                              },
                                              icon:const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ],
                                      );
                                    });
                              },
                              child:
                              playprovider.playlistsong[index].image !=null ?(  Container(
                                decoration:BoxDecoration(image: DecorationImage(image: FileImage(File(playprovider.playlistsong[index].image!)),fit: BoxFit.cover),
                                border: Border.all(width: 2,color:const Color.fromARGB(255, 255, 255, 255)),
                                borderRadius: BorderRadius.circular(20)
                                ),
                                   
                                  child: Center(
                                    child: Text(
                                  playlist.playlistsong[index].name.toString().toUpperCase(),
                                  style:const TextStyle(fontWeight: FontWeight.w500,color:Color.fromARGB(255, 0, 167, 201),fontSize: 18),
                                  ),
                                ), 
                              )) : 
                               Container(
                                decoration: BoxDecoration(border: Border.all(width: 2,color:const  Color.fromARGB(255, 255, 255, 255)),color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20)),
                                  child: Center(child: Text(playlist.playlistsong[index].name.toString().toUpperCase(),style: const TextStyle(fontWeight: FontWeight.w500,color:Color.fromARGB(255, 0, 167, 201),fontSize: 18),))
                              )
                            );
                          }),
                    );
              },)
            )
          ],
        )),
    );
  }
}
