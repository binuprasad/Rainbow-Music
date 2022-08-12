import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/model/model.dart';
import 'package:music_player/playlist/playlist_db.dart';
import 'package:music_player/playlist/playlist_view.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

final nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _PlaylistScreenState extends State<PlaylistScreen> {
 
  @override
  Widget build(BuildContext context) {
       FocusManager.instance.primaryFocus?.unfocus();
    return ValueListenableBuilder(
      valueListenable: Hive.box<MusicModel>('playlist_db').listenable(),
      builder:
          (BuildContext context, Box<MusicModel> musicList, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
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
                      return ValueListenableBuilder(
                        valueListenable:
                            Hive.box<MusicModel>('playlist_db').listenable(),
                        builder: (BuildContext context,
                            Box<MusicModel> musicList, Widget? child) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PlaylistView(
                                      playlist: data, folderindex: index)));
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
                                                  color: Colors.white,fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Delete playlist'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text('No')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  musicList
                                                                      .deleteAt(
                                                                          index);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: const Text(
                                                                    'Yes'))
                                                          ],
                                                        );
                                                      });
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
                      );
                    },
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
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: ' Playlist Name'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter playlist name";
                                      } else {
                                        return null;
                                      }
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
                                              primary: Colors.black),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Cancel',
                                          ))),
                                  SizedBox(
                                      width: 100.0,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary:  Colors.black
                                                  ),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              whenButtonClicked();
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.white),
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
            child: const Icon(Icons.playlist_add,color: Colors.green, ),
          ),
        );
      },
    );
  }

  Future<void> whenButtonClicked() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return;
    } else {
      final music = MusicModel(
        songIds: [],
        name: name,
      );
      playlistAdd(music);
      nameController.clear();
    }
  }
}
