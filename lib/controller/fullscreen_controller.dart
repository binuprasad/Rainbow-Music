import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:rxdart/rxdart.dart' as rx;

class FullScreencontroller extends GetxController {
  RxInt currentIndexes = 0.obs;

  @override
  void onInit() {
    GetAllSongs.player.currentIndexStream.listen((index) {
      if (index != null) {
        currentIndexes.value = index;
        GetAllSongs.currentIndex = index;
      }
    });
    super.onInit();
  }

  playButton() async {
    if (GetAllSongs.player.playing) {
      await GetAllSongs.player.pause();
      update();
    } else {
      await GetAllSongs.player.play();
      update();
    }
  }

  previousbutton() async {
    if (GetAllSongs.player.hasPrevious) {
      await GetAllSongs.player.seekToPrevious();
      await GetAllSongs.player.play();
    } else {
      await GetAllSongs.player.play();
    }
  }

  playnextbutton() async {
    if (GetAllSongs.player.hasNext) {
      await GetAllSongs.player.seekToNext();
      await GetAllSongs.player.play();
    } else {
      GetAllSongs.player.play();
    }
  }

  void changeInSeeconds(int second) {
    Duration duration = Duration(seconds: second);
    GetAllSongs.player.seek(duration);
  }

  goback(){
    Get.back();
    update();
  }

  playarrowbutton(snapshot){
     bool? playingStage = snapshot.data;
                                if (playingStage != null && playingStage) {
                                  return const Icon(
                                    Icons.pause,
                                    size: 60,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.play_arrow,
                                    size: 60,
                                  );
                                }
  }

   Stream<DurationState> get durationStateStream =>
      rx.Rx.combineLatest2<Duration, Duration?, DurationState>(
          GetAllSongs.player.positionStream,
          GetAllSongs.player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
}



class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}

