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

  listtileOntap(index, homeSongs) {
    GetAllSongs.player.setAudioSource(GetAllSongs.createSongList(homeSongs),
        initialIndex: index);
    GetAllSongs.player.play();
    Get.to(FullScreen(playersong: homeSongs));
  }

  songcheckingConditions(homeSongs) {
    if (homeSongs == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (homeSongs.isEmpty) {
      return const Center(
        child: Text('Songs not foud'),
      );
    }
    HomeScreen.songs = homeSongs;
    if (!FavouriteDB.isInitialized) {
      FavouriteDB().initialise(homeSongs);
    }
    GetAllSongs.songscopy = homeSongs;
  }
}
