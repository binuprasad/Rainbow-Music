import 'package:flutter/material.dart';
import 'package:music_player/favourite/favourite_db.dart';
import 'package:music_player/full_screen.dart';
import 'package:music_player/get_all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    FavouriteDB.favoriteSongs.notifyListeners();
    return ValueListenableBuilder(
      valueListenable: FavouriteDB.favoriteSongs,
      builder:
          (BuildContext context, List<SongModel> favorData, Widget? child) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Favourite',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: FavouriteDB.favoriteSongs.value.isEmpty
                  ? const Center(
                      child: Text('No FavouriteSongs Found'),
                    )
                  : ValueListenableBuilder(
                      valueListenable: FavouriteDB.favoriteSongs,
                      builder: (BuildContext ctx, List<SongModel> favorData,
                          Widget? child) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: favorData.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: QueryArtworkWidget(
                                id: favorData[index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note_outlined,
                                  color: Colors.black,
                                  size: 35,
                                ),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    FavouriteDB.favoriteSongs.notifyListeners();
                                    FavouriteDB.delete(favorData[index].id);
                                    setState(() {});
                                    const snackbar = SnackBar(
                                        backgroundColor: Colors.black,
                                        content: Text(
                                          'Song deleted from favorite',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        duration: Duration(microseconds: 190));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.black,
                                  )),
                              title: Text(
                                favorData[index].title,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              subtitle: Text(
                                favorData[index].album!,
                                style: const TextStyle(color: Colors.black54),
                              ),
                              onTap: () {
                                FavouriteDB.favoriteSongs.notifyListeners();
                                List<SongModel> newlist = [...favorData];
                                setState(() {});
                                GetAllSongs.player.stop();
                                GetAllSongs.player.setAudioSource(
                                    GetAllSongs.createSongList(newlist),
                                    initialIndex: index);
                                GetAllSongs.player.play();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        FullScreen(playersong: newlist)));
                              },
                            );
                          },
                        );
                      },
                    ),
            ));
      },
    );
  }
}
