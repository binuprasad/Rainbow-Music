import 'package:flutter/material.dart';
import 'package:music_player/favourite/favourite_db.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteBtn extends StatefulWidget {
  const FavouriteBtn({Key? key, required this.song}) : super(key: key);
  final SongModel song;

  @override
  State<FavouriteBtn> createState() => _FavouriteBtnState();
}

class _FavouriteBtnState extends State<FavouriteBtn> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: FavouriteDB.favoriteSongs,
        builder:
            (BuildContext context, List<SongModel> favorData, Widget? child) {
          return IconButton(
              onPressed: () {
                if (FavouriteDB.isfavor(widget.song)) {
                  FavouriteDB.delete(widget.song.id);
                  const snackBar = SnackBar(
                    content: Text(
                      'Removed From Favorite',
                      style:
                          TextStyle(color: Color.fromARGB(255, 247, 247, 247)),
                    ),
                    duration: Duration(milliseconds: 1500),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  FavouriteDB.add(widget.song);
                  const snackbar = SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      'Song Added to Favorite',
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(milliseconds: 350),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
                FavouriteDB.favoriteSongs.notifyListeners();
              },
              icon: FavouriteDB.isfavor(widget.song)
                  ? const Icon(Icons.favorite,color:Colors.black,)
                  : const Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.black,
                    ));
        });
  }
}
