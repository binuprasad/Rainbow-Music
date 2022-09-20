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

  conditionchecking(snapshot){
     bool? currentPlayingStage = snapshot.data.obs;

                if (currentPlayingStage != null && currentPlayingStage) {
                  return const Icon(
                    Icons.pause,
                    size: 35,
                    color: Colors.white,
                  );
                } else {
                  return const Icon(
                    Icons.play_arrow,
                    size: 35,
                    color: Colors.white,
                  );
                }
  }
  
}
