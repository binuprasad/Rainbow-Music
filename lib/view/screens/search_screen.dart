import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/search_screen_controller.dart';
import 'package:music_player/view/screens/full_screen.dart';
import 'package:music_player/view/screens/get_all_songs.dart';

import 'package:on_audio_query/on_audio_query.dart';

class SearchSong extends GetView<Searchcontroller> {
   SearchSong({Key? key}) : super(key: key);

  final searchcontroller = Get.lazyPut(() => Searchcontroller());



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:appcolor)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                 Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            title: const Text(
              'Search Your Songs',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 7.0,
                ),
                GetBuilder<Searchcontroller>(builder: (controller) => TextField(
                    onChanged: (value) => controller.runFilter(value),
                    decoration: InputDecoration(
                      hintText: "Search your song",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),),),
                const SizedBox(
                  height: 7,
                ),
              GetBuilder <Searchcontroller>(builder: (controller) =>    Expanded(
                  child: controller.foundSongs.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.foundSongs.length,
                          itemBuilder: (context, index) => Card(
                            key: ValueKey(controller.foundSongs[index].id),
                            color:  const Color.fromARGB(255, 226, 211, 73),
                            
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            child: ListTile(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                GetAllSongs.player.setAudioSource(
                                    GetAllSongs.createSongList(controller.foundSongs),
                                    initialIndex: index);
                                GetAllSongs.player.play();
                                Get.to(FullScreen(playersong: controller.foundSongs));
                               
                              },
                              leading: QueryArtworkWidget(
                                id: controller.foundSongs[index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(Icons.music_note),
                              ),
                              title: Text(controller.foundSongs[index].title),
                            ),
                          ),
                        )
                      : const Text(
                          'No results found',
                          style: TextStyle(fontSize: 24),
                        ),
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
