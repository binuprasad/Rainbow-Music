import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/playlist_db.dart';
import 'package:music_player/model/model.dart';

class PlaylistscreenController extends GetxController {
  final nameController = TextEditingController();

  Future<void> whenButtonClicked() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return;
    } else {
      final music = MusicModel(
        songIds: [],
        name: name,
      );
      playlistAdd(music);
      nameController.clear();
      update();
    }
  }

  validationCondition(value) {
    if (value == null || value.isEmpty) {
      return "Please enter playlist name";
    } else {
      return null;
    }
  }

  // creatingplaylist(index) {
  //   Get.defaultDialog(
  //     title: 'Delete playlist?',
  //     content: const Text('Are you sure to delete the playlist'),
  //     onCancel: () {
  //       Get.back();
  //     },
  //     onConfirm: () {
  //     //  playlistnotifier.removeAt(index);

  //       Get.back();
  //        },
  //     );
  // }
}
