import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/controller/favourite_screen%20_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteDB {
  static bool isInitialized = false;
  static final favDB = Hive.box<int>('favourite_db');
  final favcontroller = Get.put(FavouriteScreenController());
   initialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isfavor(song)) {
       favcontroller. favoriteSongs.add(song);
      }
    }
    isInitialized = true;
  }

  static bool isfavor(SongModel song) {
    if (favDB.values.contains(song.id)) {
      return true;
    }
    return false;
  }

   add(SongModel song) async {
    favDB.add(song.id);
 favcontroller.   favoriteSongs.add(song);
  }

   delete(int id) async {
    int deletekey = 0;
    if (!favDB.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> favorMap = favDB.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    favDB.delete(deletekey);
   favcontroller .favoriteSongs.removeWhere((song) => song.id == id);
  }
}
