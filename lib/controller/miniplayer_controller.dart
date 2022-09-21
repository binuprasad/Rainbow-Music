import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view/screens/get_all_songs.dart';

class MiniPlayerController extends GetxController {
  @override
  void onInit() {
    GetAllSongs.player.currentIndexStream.listen((index) {
      if (index != null) {
        update();
      }
    });
    super.onInit();
      update();
  }

  miniplayerplaybutton() async {
    if (GetAllSongs.player.playing) {
      await GetAllSongs.player.pause();
      update();
    } else {
      await GetAllSongs.player.play();
      update();
    }
    update();
  }

  // conditionchecking(currentPlayingStage) {
  //   if (currentPlayingStage != null && currentPlayingStage) {
  //     update();
  //     return const Icon(
  //       Icons.pause,
  //       size: 35,
  //       color: Colors.white,
  //     );
  //   } else {
  //     update();
  //     return const Icon(
  //       Icons.play_arrow,
  //       size: 35,
  //       color: Colors.white,
  //     );
  //   }
    
  // }
}
