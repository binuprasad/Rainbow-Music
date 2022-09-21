import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/playlist_db.dart';
import 'package:music_player/model/model.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistViewController extends GetxController {

   final hive = Hive.box<MusicModel>('playlist_db').obs;


  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < GetAllSongs.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetAllSongs.songscopy[i].id == data[j]) {
          plsongs.add(GetAllSongs.songscopy[i]);
        }
      }
    }
    return plsongs;
  }

  @override
  void onInit() {
    getAllPlaylist();
    super.onInit();
  }
}
