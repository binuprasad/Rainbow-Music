import 'package:get/get.dart';
import 'package:music_player/view/screens/get_all_songs.dart';

class FullScreencontroller extends GetxController {
  RxInt currentIndexes = 0.obs;

  @override
  void onInit() {
    GetAllSongs.player.currentIndexStream.listen((index) {
      if (index != null) {
        currentIndexes.value=index;

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

  previousbutton()async{
    if (GetAllSongs.player.hasPrevious) {
                              await GetAllSongs.player.seekToPrevious();
                              await GetAllSongs.player.play();
                            } else {
                              await GetAllSongs.player.play();
                            }
  }
  playnextbutton()async{
     if (GetAllSongs.player.hasNext) {
                              await GetAllSongs.player.seekToNext();
                              await GetAllSongs.player.play();
                            } else {
                              GetAllSongs.player.play();
                            }
                        
  }
}
