import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/miniplayer_controller.dart';
import 'package:music_player/view/screens/full_screen.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends GetView<MiniPlayerController> {
  MiniPlayer({Key? key}) : super(key: key);

  final miniController = Get.put(MiniPlayerController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniPlayerController>(builder: (controller) => AnimatedContainer(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      duration: const Duration(seconds: 2),
      child: ListTile(
        onTap: () => Get.to(FullScreen(playersong: GetAllSongs.playingSong)),
        leading: QueryArtworkWidget(
            keepOldArtwork: true,
            artworkBorder: BorderRadius.circular(5),
            nullArtworkWidget: const Icon(
              Icons.music_note,
              color:appcolor,
            ),
            id: GetAllSongs.playingSong[GetAllSongs.player.currentIndex!].id,
            type: ArtworkType.AUDIO),
        title: MarqueeText(
          style: const TextStyle(color: appcolor),
          speed: 15,
          text: TextSpan(
              text: GetAllSongs
                  .playingSong[GetAllSongs.player.currentIndex!].title),
        ),
        trailing: IconButton(
          icon: StreamBuilder<bool>(
            stream: GetAllSongs.player.playingStream,
            builder: ((context, snapshot) {
             
              bool? currentPlayingStage = snapshot.data;

              if (currentPlayingStage != null && currentPlayingStage) {
                
                return const Icon(
                  Icons.pause,
                  size: 35,
                  color: Colors.white,
                );
              } else {
                return const Icon(
                  Icons.play_arrow,
                  size: 35,
                  color: Colors.white,
                );
              }
            }),
          ),
          onPressed: () async {
            miniController.miniplayerplaybutton();
          },
        ),
      ),
    ),);
  }
}
