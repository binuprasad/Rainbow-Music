import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteDB {
  static bool isInitialized = false;
  static final favDB = Hive.box<int>('favourite_db');
  static ValueNotifier<List<SongModel>> favoriteSongs = ValueNotifier([]);
  static initialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isfavor(song)) {
        favoriteSongs.value.add(song);
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

  static add(SongModel song) async {
    favDB.add(song.id);
    favoriteSongs.value.add(song);
    FavouriteDB.favoriteSongs.notifyListeners();
  }

  static delete(int id) async {
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
    favoriteSongs.value.removeWhere((song) => song.id == id);
  }
}
