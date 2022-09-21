import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/add_to_playlist_controller.dart';
import 'package:music_player/model/model.dart';
import 'package:music_player/db/playlist_db.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddToPlaylist extends StatefulWidget {
  const AddToPlaylist({Key? key, required this.playlist}) : super(key: key);
  final MusicModel playlist;

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends State<AddToPlaylist> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final addtocontroller = Get.put(AddToPlaylistController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: appgradientcolor,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'AddSongs',
            style: TextStyle(color: Colors.black),
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
        body: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return const Center(
                child: Text(
                  'NO Songs Found',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              );
            }
            return SingleChildScrollView(
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      leading: QueryArtworkWidget(
                        id: item.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(
                          Icons.music_note,
                          color: Colors.black,
                        ),
                        artworkFit: BoxFit.fill,
                        artworkBorder:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      title: Text(
                        item.data![index].displayNameWOExt,
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        "${item.data![index].artist}",
                        maxLines: 1,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              playlistCheck(item.data![index]);
                              playlistnotifier.notifyListeners();
                            },
                          );
                        },
                        icon: !widget.playlist.isValueIn(item.data![index].id)
                            ? const Icon(
                                Icons.playlist_add_check_circle,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: item.data!.length),
            );
          },
        ),
      ),
    );
  }

  void playlistCheck(SongModel data) {
    if (!widget.playlist.isValueIn(data.id)) {
      widget.playlist.add(data.id);
      Get.snackbar('Song Added', "Song added to playlist",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(milliseconds: 950));
    } else {
      widget.playlist.deleteData(data.id);
      Get.snackbar('Song removed', "Song removed from the playlist",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
