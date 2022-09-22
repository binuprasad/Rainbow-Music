import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/playlist_db.dart';
import 'package:music_player/model/model.dart';

class PlaylistscreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final hive = Hive.box<MusicModel>('playlist_db');

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

  deleteplaylist(index) {
    Get.defaultDialog(
      title: 'Delete playlist?',
      content: const Text('Are you sure to delete the playlist'),
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        hive.deleteAt(index);
        update();
        Get.back();
      },
    );
  }
}
