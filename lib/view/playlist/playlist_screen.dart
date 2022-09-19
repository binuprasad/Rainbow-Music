import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/playlist_screen_controller.dart';
import 'package:music_player/model/model.dart';
import 'package:music_player/view/playlist/playlist_view.dart';

class PlaylistScreen extends StatelessWidget {
  PlaylistScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final playlistcontroller = Get.put(PlaylistscreenController());

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return ValueListenableBuilder(
      valueListenable: Hive.box<MusicModel>('playlist_db').listenable(),
      builder:
          (BuildContext context, Box<MusicModel> musicList, Widget? child) {
        return Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: appcolor)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Playlist',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Hive.box<MusicModel>('playlist_db').isEmpty
                  ? const Center(
                      child: Text('Your Playlist is Empty'),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: musicList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = musicList.values.toList()[index];

                        return GestureDetector(
                          onTap: () {
                            Get.to(PlaylistView(
                                playlist: data, folderindex: index));
                          },
                          child: Container(
                            color: Colors.black,
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
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              onPressed: () {
                                                Get.defaultDialog(
                                                  title: 'Delete playlist?',
                                                  content: const Text(
                                                      'Are you sure to delete the playlist'),
                                                  onCancel: () {
                                                    Get.back();
                                                  },
                                                  onConfirm: () {
                                                    musicList.deleteAt(index);

                                                    Get.back();
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              )))
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
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                // Get.defaultDialog(
                //   content: Actions(actions: [], child: child)
                // );
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
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Form(
                                  key: _formKey,
                                  child: TextFormField(
                                      controller:
                                          playlistcontroller.nameController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: ' Playlist Name'),
                                      validator: (value) {
                                        playlistcontroller
                                            .validationCondition(value);

                                        // if (value == null || value.isEmpty) {
                                        //   return "Please enter playlist name";
                                        // } else {
                                        //   return null;
                                        // }
                                      }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 100.0,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text(
                                              'Cancel',
                                            ))),
                                    SizedBox(
                                        width: 100.0,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                playlistcontroller
                                                    .whenButtonClicked();
                                                Get.back();
                                              }
                                            },
                                            child: const Text(
                                              'Save',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: const Icon(
                Icons.playlist_add,
                color: Colors.yellowAccent,
              ),
            ),
          ),
        );
      },
    );
  }
}
