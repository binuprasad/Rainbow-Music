import 'package:get/get.dart';
import 'package:music_player/view/favourite/favourite_screen.dart';
import 'package:music_player/view/playlist/playlist_screen.dart';
import 'package:music_player/view/screens/home_screen.dart';
import 'package:music_player/view/screens/search_screen.dart';

class BottomnavigationController extends GetxController {
  var baseindex = 0.obs;
  final pages = [
    HomeScreen(),
    SearchSong(),
    PlaylistScreen(),
    FavouriteScreen(),
  ];

  bottomnavigationontap(newIndex) {
    if (newIndex == 1) {
      Get.to(SearchSong());
    } else {
      baseindex.value = newIndex;
    }
  }
}
