import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/controller/favourite_screen%20_controller.dart';
import 'package:music_player/model/model.dart';
import 'package:music_player/view/screens/splash_screen.dart';

List<MusicModel> playlistnotifier = [];

Future<void> playlistAdd(MusicModel value) async {
  final playlistDB = Hive.box<MusicModel>('playlist_db');
  await playlistDB.add(value);
  playlistnotifier.add(value);
}

Future<void> getAllPlaylist() async {
  final playlistDB = Hive.box<MusicModel>('playlist_db');
  playlistnotifier.clear();
  playlistnotifier.addAll(playlistDB.values);
}

Future<void> playlistDelete(int index) async {
  final playlistDB = Hive.box<MusicModel>('playlist_db');
  await playlistDB.deleteAt(index);
  getAllPlaylist();
}

Future<void> appReset() async {
  final playlistDB = Hive.box<MusicModel>('playlist_db');
  final favDB = Hive.box<int>('favourite_db');
  await favDB.clear();
  await playlistDB.clear();
FavouriteScreenController().favoriteSongs.clear();
 Get.offAll( const SpalshScreen());
}
