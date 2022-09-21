import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddToPlaylistController extends GetxController{
final OnAudioQuery audioQuery = OnAudioQuery();
  ifcondition(item){
     if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return const Center(
                child: Text(
                  'NO Songs Found',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              );
            }
  }  

   void playlistCheck(SongModel data, MusicModel playlist) {
    if (!playlist.isValueIn(data.id)) {
      playlist.add(data.id);
      Get.snackbar('Song Added', "Song added to playlist",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(milliseconds: 950));
    } else {
      playlist.deleteData(data.id);
      Get.snackbar('Song removed', "Song removed from the playlist",
          snackPosition: SnackPosition.BOTTOM);
    }
    update();
  }

  


}