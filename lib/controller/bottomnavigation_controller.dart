import 'package:get/get.dart';
import 'package:music_player/view/favourite/favourite_screen.dart';
import 'package:music_player/view/playlist/playlist_screen.dart';
import 'package:music_player/view/screens/home_screen.dart';
import 'package:music_player/view/screens/search_screen.dart';

class BottomnavigationController extends GetxController{
   final pages = [
     HomeScreen(),
     SearchSong(),
     PlaylistScreen(),
     FavouriteScreen(),
  ];
  var baseindex = 0.obs;
  
}