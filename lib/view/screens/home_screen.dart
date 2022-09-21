import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/home_screen_controller.dart';
import 'package:music_player/view/favourite/favourite_button.dart';
import 'package:music_player/db/favourite_db.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:music_player/view/screens/settings_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static List<SongModel> songs = [];
  final homeController = Get.put(HomeScreenController());
  final favorite = FavouriteDB();
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: appgradientcolor),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'All Songs',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(SettingsScreen());
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: FutureBuilder<List<SongModel>>(
          future: homeController.audioquery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, item) {
            final homeSongs = item.data;
            if (homeSongs == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (homeSongs.isEmpty) {
              return const Center(
                child: Text('Songs not foud'),
              );
            }
            HomeScreen.songs = homeSongs;
            if (!FavouriteDB.isInitialized) {
              FavouriteDB().initialise(homeSongs);
            }
            GetAllSongs.songscopy = homeSongs;

            return ListView.separated(
                itemBuilder: (context, index) {
                  return const Divider();
                },
                separatorBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      homeController.listtileOntap(index, homeSongs);
                    },
                    leading: QueryArtworkWidget(
                      id: item.data![index].id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: const Icon(Icons.music_note),
                    ),
                    trailing: FavouriteBtn(song: HomeScreen.songs[index]),
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
      ),
    );
  }
}
