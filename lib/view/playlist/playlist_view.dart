// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/playlistview_controller.dart';
import 'package:music_player/view/screens/full_screen.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:music_player/model/model.dart';
import 'package:music_player/view/playlist/add_to_playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistView extends GetView<PlaylistViewController> {
  PlaylistView({Key? key, required this.playlist, required this.folderindex})
      : super(key: key);
  final MusicModel playlist;
  final int folderindex;

  late List<SongModel> playlistsong;

  final playlistviewcontroller = Get.put(PlaylistViewController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: appgradientcolor)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            playlist.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<MusicModel>('playlist_db').listenable(),
          builder:
              (BuildContext context, Box<MusicModel> value, Widget? child) {
            playlistsong = playlistviewcontroller
                .listPlaylist(value.values.toList()[folderindex].songIds);
            return playlistsong.isEmpty
                ? const Center(
                    child: Text('Add your songs'),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          List<SongModel> newlist = [...playlistsong]; 
                          GetAllSongs.player.stop();
                          GetAllSongs.player.setAudioSource(
                              GetAllSongs.createSongList(newlist),
                              initialIndex: index);
                          GetAllSongs.player.play();
                          Get.to(
                              FullScreen(playersong: GetAllSongs.playingSong));
                        },
                        leading: QueryArtworkWidget(
                          id: playlistsong[index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                        title: Text(
                          playlistsong[index].title,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          playlistsong[index].artist!,
                          style: const TextStyle(color: Colors.black54),
                          maxLines: 1,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Remove song?',
                              content: const Text(
                                  'Are you sure to remove the song from playlist?'),
                              confirm: TextButton(
                                onPressed: () {
                                  playlist.deleteData(playlistsong[index].id);
                                  Get.back();
                                },
                                child: const Text('Yes'),
                              ),
                              cancel: TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('No'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: playlistsong.length);
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Get.to(AddToPlaylist(playlist: playlist));
          },
          child: const Icon(
            Icons.add,
            color: appcolor,
          ),
        ),
      ),
    );
  }
}
