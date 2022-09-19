import 'package:get/get.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistViewController extends GetxController{

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

  
}