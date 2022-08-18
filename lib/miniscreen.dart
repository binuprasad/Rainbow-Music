import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player/full_screen.dart';
import 'package:music_player/get_all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {

  @override
  void initState() {
    GetAllSongs.player.currentIndexStream.listen((index) {
      if (index != null && mounted()) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      duration: const Duration(seconds: 2),
      child: ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                FullScreen(playersong: GetAllSongs.playingSong))),
        leading: QueryArtworkWidget(
            keepOldArtwork: true,
            artworkBorder: BorderRadius.circular(5),
            nullArtworkWidget: const Icon(
              Icons.music_note,
              color: Colors.amber,
            ),
            id: GetAllSongs.playingSong[GetAllSongs.player.currentIndex!].id,
            type: ArtworkType.AUDIO),
        title: MarqueeText(
          style: const TextStyle(color: Colors.amber),
          speed: 15,
          text: TextSpan(
              text: GetAllSongs.playingSong[GetAllSongs.player.currentIndex!]
                  .title),
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
            if (GetAllSongs.player.playing) {
              await GetAllSongs.player.pause();
              setState(() {});
            } else {
              await GetAllSongs.player.play();
              setState(() {});
            }
          },
        ),
      ),
    );
  }
}
