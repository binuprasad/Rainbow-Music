import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/fullscreen_controller.dart';
import 'package:music_player/view/favourite/favourite_button.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FullScreen extends GetView<FullScreencontroller> {
  FullScreen({Key? key, required this.playersong}) : super(key: key);
  final List<SongModel> playersong;

  final fullScreencontroller = Get.put(FullScreencontroller());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: appgradientcolor)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'Now Playing',
                style: TextStyle(color: black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  fullScreencontroller.goback();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: black,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Obx(
                          () => QueryArtworkWidget(
                            artworkHeight: height / 2.3,
                            artworkWidth: width,
                            artworkFit: BoxFit.fill,
                            keepOldArtwork: true,
                            id: playersong[
                                    fullScreencontroller.currentIndexes.value]
                                .id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: SizedBox(
                              height: height / 2.5,
                              width: width,
                              child: Icon(
                                Icons.music_note,
                                size: height / 4,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            playersong[
                                    fullScreencontroller.currentIndexes.value]
                                .displayNameWOExt,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        Text(
                          playersong[fullScreencontroller.currentIndexes.value]
                              .artist
                              .toString(),
                          maxLines: 1,
                        )
                      ],
                    ),
                    SizedBox(
                      height: height / 12,
                    ),
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 14,
                            spreadRadius: 16,
                            color: black.withOpacity(0.2))
                      ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4,sigmaY: 4),
                          child: Container(
                           
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 1.5,color: white.withOpacity(0.2)),
                              color: white.withOpacity(0.2)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  StreamBuilder<DurationState>(
                                    stream: fullScreencontroller.durationStateStream,
                                    builder: (context, snapshot) {
                                      final durationState = snapshot.data;
                                      final progress =
                                          durationState?.position ?? Duration.zero;
                                      final total =
                                          durationState?.total ?? Duration.zero;
                                      return ProgressBar(
                                        timeLabelTextStyle: const TextStyle(
                                            color: black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                        progress: progress,
                                        total: total,
                                        barHeight: 3.0,
                                        thumbRadius: 5,
                                        progressBarColor: black,
                                        thumbColor: black,
                                        baseBarColor: grey,
                                        bufferedBarColor: grey,
                                        buffered: const Duration(milliseconds: 2000),
                                        onSeek: (duration) {
                                          GetAllSongs.player.seek(duration);
                                        },
                                      );
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          GetAllSongs.player.loopMode == LoopMode.one
                                              ? GetAllSongs.player
                                                  .setLoopMode(LoopMode.all)
                                              : GetAllSongs.player
                                                  .setLoopMode(LoopMode.one);
                                        },
                                        icon: StreamBuilder(
                                          stream: GetAllSongs.player.loopModeStream,
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            return fullScreencontroller
                                                .repeatSong(snapshot);
                                          },
                                        ),
                                      ),
                                      FavouriteBtn(
                                          song: playersong[fullScreencontroller
                                              .currentIndexes.value]),
                                      StreamBuilder<bool>(
                                        stream:
                                            GetAllSongs.player.shuffleModeEnabledStream,
                                        builder: (context, snapshot) {
                                          final shuffleModeEnabled =
                                              snapshot.data ?? false;
                                          return IconButton(
                                            onPressed: () {
                                              GetAllSongs.player.setShuffleModeEnabled(
                                                  !shuffleModeEnabled);
                                            },
                                            icon: shuffleModeEnabled
                                                ? const Icon(Icons.shuffle_rounded)
                                                : const Icon(
                                                    Icons.shuffle_rounded,
                                                    color: grey,
                                                  ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          fullScreencontroller.previousbutton();
                                        },
                                        icon: const Icon(
                                          Icons.skip_previous,
                                        ),
                                        iconSize: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 29, right: 25),
                                        child: IconButton(
                                          onPressed: () async {
                                            fullScreencontroller.playButton();
                                          },
                                          icon: StreamBuilder(
                                            stream: GetAllSongs.player.playingStream,
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              return fullScreencontroller
                                                  .playarrowbutton(snapshot);
                                            },
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          fullScreencontroller.playnextbutton();
                                        },
                                        icon: const Icon(Icons.skip_next),
                                        iconSize: 50,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
