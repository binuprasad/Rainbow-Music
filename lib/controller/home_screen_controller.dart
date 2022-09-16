import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/favourite_db.dart';
import 'package:music_player/view/screens/full_screen.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:music_player/view/screens/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreenController extends GetxController {
  final audioquery = OnAudioQuery();


  @override
  void onInit() {
    requestPermision();
    super.onInit();
  }

  void requestPermision() async {
    await Permission.storage.request();
    update();
  }

  // homeConditions(item) {
  //   if (item.data == null) {
  //     return const Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   }
  //   if (item.data.isEmpty) {
  //     return const Center(
  //       child: Text('Songs not foud'),
  //     );
  //   }
  //   HomeScreen.songs = item.data;
  //   if (!FavouriteDB.isInitialized) {
  //     FavouriteDB.initialise(item.data);
  //   }
  //   GetAllSongs.songscopy = item.data;
  // }

  homeListview(item, index) {
    GetAllSongs.player.setAudioSource(GetAllSongs.createSongList(item.data),
        initialIndex: index);
    GetAllSongs.player.play();
    GetAllSongs.player.play();
    
    Get.to(FullScreen(playersong: item.data));
    update();
  }
}
