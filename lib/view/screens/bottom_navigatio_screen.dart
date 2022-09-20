import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/bottomnavigation_controller.dart';
import 'package:music_player/controller/favourite_screen%20_controller.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:music_player/view/screens/miniscreen.dart';
import 'package:music_player/view/screens/search_screen.dart';

class BottomNavigationScreen extends GetView<BottomnavigationController> {
   BottomNavigationScreen({
    Key? key,
  }) : super(key: key);


  final favcontroller = Get.put(FavouriteScreenController());
  final bottomnavcontroller = Get.put(BottomnavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => bottomnavcontroller.pages[bottomnavcontroller.baseindex.value]),
        bottomNavigationBar: GetBuilder<BottomnavigationController>(
          builder: (controller) => SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                (GetAllSongs.player.playing) ||
                        (GetAllSongs.player.currentIndex != null)
                    ? MiniPlayer()
                    : const SizedBox(),
                Obx(
                  () => BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.black,
                    selectedItemColor: Colors.yellow,
                    unselectedItemColor: Colors.white,
                    currentIndex: bottomnavcontroller.baseindex.value,
                    onTap: (newIndex) {
                      if (newIndex == 1) {
                      
                       Get.to(SearchSong());
                      } else {
                     
                          bottomnavcontroller.baseindex.value = newIndex;

                      
                      }
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.search,
                          ),
                          label: 'Search'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.playlist_add), label: 'Playlist'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite), label: 'Favourite'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
