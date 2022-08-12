

import 'package:flutter/material.dart';
import 'package:music_player/favourite/favourite_button.dart';
import 'package:music_player/favourite/favourite_db.dart';
import 'package:music_player/full_screen.dart';
import 'package:music_player/get_all_songs.dart';
import 'package:music_player/settings_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
    static List<SongModel> songs = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    requestPermision();
  }

  void requestPermision() async{
   await Permission.storage.request();
   setState(() {
     
   });
  }

  final audioquery = OnAudioQuery();
 

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'All Songs',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen()));
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ))
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: audioquery.querySongs(
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
              child: Text('Songs not foud'),
            );
          }
           HomeScreen.songs = item.data!;
          if (!FavouriteDB.isInitialized) {
            FavouriteDB .initialise(item.data!);
          }
          GetAllSongs.songscopy = item.data!;

          return ListView.separated(
              itemBuilder: (context, index) {
                return const Divider();
              },
              separatorBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                GetAllSongs.player.setAudioSource(
                          GetAllSongs.createSongList(item.data!),
                          initialIndex: index);
                      GetAllSongs.player.play();
                      setState(() {});
                      GetAllSongs.player.play();
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreen(playersong:item.data!,)
                          ));
                  },
                  leading: QueryArtworkWidget(
                    id: item.data![index].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Icon(Icons.music_note),
                  ),
                  trailing: FavouriteBtn(song:HomeScreen.songs[index] )
                ,
                  title: Text(
                    item.data![index].displayNameWOExt,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    "${item.data![index].artist}",
                    maxLines: 1,
                  ),
                );
              },
              itemCount: item.data!.length);
        },
      ),
    );
  }
}
