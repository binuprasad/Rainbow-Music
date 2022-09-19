
// import 'package:get/get.dart';
// import 'package:music_player/view/screens/home_screen.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class SearchScreenController extends GetxController{
//    final List<SongModel> allsongs = HomeScreen.songs;
//   late List<SongModel> foundSongs = [];
//   List<SongModel> _results = [];
//   @override
//   void onInit() {
//     foundSongs = allsongs;

//     super.onInit();
//   }

//  void   runFilter(String enteredKeyword) {
    
//     if (enteredKeyword.isEmpty) {
//       _results =  allsongs;
//     } else {
//       _results =  allsongs
//           .where((name) =>
//               name.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
//           .toList();
//     }

  
//       foundSongs = _results;
//         update();
//       // return foundSongs;
     

//   }

// }

import 'package:get/get.dart';
import 'package:music_player/view/screens/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Searchcontroller extends GetxController{
   final List<SongModel> allsongs = HomeScreen.songs;

  List<SongModel> foundSongs = [];

  @override
  void onInit() {
     foundSongs = allsongs;
    super.onInit();
  }
    void runFilter(String enteredKeyword) {
    List<SongModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = allsongs;
    } else {
      results = allsongs
          .where((name) =>
              name.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
  
      foundSongs = results;
      update();
  
  }
}