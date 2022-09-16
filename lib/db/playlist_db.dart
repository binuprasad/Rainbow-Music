import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/favourite_db.dart';
import 'package:music_player/model/model.dart';
import 'package:music_player/view/screens/splash_screen.dart';

ValueNotifier<List<MusicModel>> playlistnotifier = ValueNotifier([]);
Future<void> playlistAdd(MusicModel value) async {
  final playlistDB = Hive.box<MusicModel>('playlist_db');
  await playlistDB.add(value);
  playlistnotifier.value.add(value);
}

Future<void> getAllPlaylist() async {
  final playlistDB = Hive.box<MusicModel>('playlist_db');
  playlistnotifier.value.clear();
  playlistnotifier.value.addAll(playlistDB.values);
  playlistnotifier.notifyListeners();
}

Future<void> playlistDelete(int index) async {
  final playlistDB = Hive.box<MusicModel>('playlist_db');
  await playlistDB.deleteAt(index);
  getAllPlaylist();
}

Future<void> appReset(context) async {
  final playlistDB = Hive.box<MusicModel>('playlist_db');
  final favDB = Hive.box<int>('favourite_db');
  await favDB.clear();
  await playlistDB.clear();
  FavouriteDB.favoriteSongs.value.clear();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SpalshScreen()),
      (route) => false);
}
