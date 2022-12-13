import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/playlist_screen_controller.dart';
import 'package:music_player/model/model.dart';
import 'package:music_player/view/playlist/playlist_view.dart';

class PlaylistScreen extends GetView<PlaylistscreenController> {
  PlaylistScreen({Key? key}) : super(key: key);

  final playlistcontroller = Get.put(PlaylistscreenController());

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return GetBuilder<PlaylistscreenController>(
      builder: (controller) => Container(
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
            title: const Text(
              'Playlist',
              style:
                  TextStyle(color: black, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Hive.box<MusicModel>('playlist_db').isEmpty
                ? const Center(
                    child: Text('Your Playlist is Empty'),
                  )
                : GetBuilder<PlaylistscreenController>(
                    builder: (controller) => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: playlistcontroller.hive.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data =
                            playlistcontroller.hive.values.toList()[index];

                        return GestureDetector(
                          onTap: () {
                            Get.to(PlaylistView(
                                playlist: data, folderindex: index));
                          },
                          child: Container(
                            color: black,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  width: double.infinity,
                                  height: 130,
                                  child: Image.asset(
                                    'assets/headphone.webp',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Center(
                                          child: Text(
                                            data.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: () {
                                            playlistcontroller
                                                .deleteplaylist(index);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: SizedBox(
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Enter  the Playlist Name',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Form(
                              key: playlistcontroller.formKey,
                              child: TextFormField(
                                controller: playlistcontroller.nameController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: ' Playlist Name'),
                                validator: (value) {
                                  return playlistcontroller
                                      .validationCondition(value);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 100.0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: black),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      'Cancel',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100.0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: black),
                                    onPressed: () {
                                      if (playlistcontroller
                                          .formKey.currentState!
                                          .validate()) {
                                        playlistcontroller.whenButtonClicked();
                                        Get.back();
                                      }
                                    },
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: const Icon(
              Icons.playlist_add,
              color: appcolor,
            ),
          ),
        ),
      ),
    );
  }
}
