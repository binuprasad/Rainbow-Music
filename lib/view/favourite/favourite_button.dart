import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/favourite_button_controller.dart';
import 'package:music_player/db/favourite_db.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../colors/colors.dart';

class FavouriteBtn extends GetView<FavouriteButtonController> {
  FavouriteBtn({Key? key, required this.song}) : super(key: key);
  final SongModel song;
  final favouritecontroller = Get.put(FavouriteButtonController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteButtonController>(
      init: FavouriteButtonController(),
      builder: (controller) {
        return IconButton(
          onPressed: () {
            favouritecontroller.conditionfvrtbtn(song);
          },
          icon: FavouriteDB.isfavor(song)
              ? const Icon(Icons.favorite, color: black)
              : const Icon(Icons.favorite_border_outlined, color: white),
        );
      },
    );
  }
}
