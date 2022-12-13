import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/add_to_playlist_controller.dart';
import 'package:music_player/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddToPlaylist extends StatelessWidget {
  AddToPlaylist({Key? key, required this.playlist}) : super(key: key);
  final MusicModel playlist;

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
            style: TextStyle(color: black),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: black,
            ),
          ),
        ),
        body: FutureBuilder<List<SongModel>>(
          future: addtocontroller.audioQuery.querySongs(
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
              child: GetBuilder<AddToPlaylistController>(
                builder: (controller) => ListView.separated(
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
                          addtocontroller.playlistCheck(
                              item.data![index], playlist);
                        },
                        icon: !playlist.isValueIn(item.data![index].id)
                            ? const Icon(
                                Icons.playlist_add_check_circle,
                                color: black,
                              )
                            : const Icon(
                                Icons.close,
                                color: red,
                              ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: item.data!.length,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
