import 'package:get/get.dart';
import 'package:music_player/db/favourite_db.dart';

class FavouriteButtonController extends GetxController {
  conditionfvrtbtn(song) {
    if (FavouriteDB.isfavor(song)) {
      FavouriteDB().delete(song.id);
      update();
      Get.snackbar('Song Removed', 'Song removed from favourite',
          duration: const Duration(milliseconds: 750),
          snackPosition: SnackPosition.BOTTOM);
    } else {
      FavouriteDB().add(song);
      update();
      Get.snackbar('Song Added', 'Sing added to favourite',
          duration: const Duration(milliseconds: 750),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
