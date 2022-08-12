import 'package:flutter/material.dart';
import 'package:music_player/favourite/favourite_db.dart';
import 'package:music_player/favourite/favourite_screen.dart';
import 'package:music_player/get_all_songs.dart';
import 'package:music_player/home_screen.dart';
import 'package:music_player/miniscreen.dart';
import 'package:music_player/playlist/playlist_screen.dart';
import 'package:music_player/search_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

int baseindex = 0;

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final _pages = [
    const HomeScreen(),
    const SearchSong(),
    const PlaylistScreen(),
    const FavouriteScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[baseindex],
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: FavouriteDB.favoriteSongs,
        builder: (BuildContext context, List<SongModel> music, Widget? child) {
          return SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                (GetAllSongs.player.playing) ||
                        (GetAllSongs.player.currentIndex != null)
                    ? const MiniPlayer()
                    : const SizedBox(),
                BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.black,
                    selectedItemColor: Colors.green,
                    unselectedItemColor: Colors.white,
                    currentIndex: baseindex,
                    onTap: (newIndex) {
                      if (newIndex == 1) {
                        setState(() {});
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SearchSong()));
                      } else {
                        setState(() {
                          baseindex = newIndex;

                          FavouriteDB.favoriteSongs.notifyListeners();
                        });
                      }
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.search,
                          ),
                          label: 'Search'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.playlist_add), label: 'Playlist'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite), label: 'Favourite'),
                    ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
