import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';
@HiveType(typeId: 1)
class Playlistmodel {
   @HiveField(0)
   String? name;
   @HiveField(1)
   List<dynamic> dbsonglist;
   @HiveField(2)
   String? image; 
   Playlistmodel({ this.name, this.dbsonglist=const[],this.image});
}
