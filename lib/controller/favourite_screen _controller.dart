import 'package:get/get.dart';
import 'package:music_player/db/favourite_db.dart';
import 'package:music_player/view/screens/full_screen.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteScreenController extends GetxController {
  List<SongModel> favoriteSongs = [];

  // trailingbutton(index) {
  //   //notifier removed
  //   FavouriteDB.delete(FavouriteScreenController.favoriteSongs[index].id);
  //   //setstate removed
  //   Get.snackbar('Song Removed', 'Song removed from favourite',
  //       duration: const Duration(milliseconds: 750),snackPosition: SnackPosition.BOTTOM);
  //   update();
  // }

  // listileOntap(index) {
  //   List<SongModel> newlist = [...FavouriteScreenController.favoriteSongs];
  //   //setstate removed
  //   GetAllSongs.player.stop();
  //   GetAllSongs.player.setAudioSource(GetAllSongs.createSongList(newlist),
  //       initialIndex: index);
  //   GetAllSongs.player.play();
  //   Get.to(FullScreen(playersong: newlist));
  //   update();
  // }
  listileOntap(index) {
    List<SongModel> newlist = [...favoriteSongs];

    GetAllSongs.player.stop();
    GetAllSongs.player.setAudioSource(GetAllSongs.createSongList(newlist),
        initialIndex: index);
    GetAllSongs.player.play();
    Get.to(FullScreen(playersong: newlist));
    update();
  }

  deletesong(index) {
    FavouriteDB().delete(favoriteSongs[index].id);
    update();
    Get.snackbar(
      'Song Removed ',
      'Song removed from favourite',
      duration: const Duration(milliseconds: 940),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
