import 'package:flutter/material.dart';
import 'package:music_player/full_screen.dart';
import 'package:music_player/get_all_songs.dart';

import 'package:music_player/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchSong extends StatefulWidget {
  const SearchSong({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SearchSong> {
  final List<SongModel> _allsongs = HomeScreen.songs;

  List<SongModel> _foundSongs = [];
  @override
  initState() {
    _foundSongs = _allsongs;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<SongModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allsongs;
    } else {
      results = _allsongs
          .where((name) =>
              name.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundSongs = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white70,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
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
              TextField(
                  onChanged: (value) => _runFilter(value),
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
                  )),
              const SizedBox(
                height: 7,
              ),
              Expanded(
                child: _foundSongs.isNotEmpty
                    ? ListView.builder(
                        itemCount: _foundSongs.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(_foundSongs[index].id),
                          color:  Colors.white,
                          
                          margin: const EdgeInsets.symmetric(vertical: 7),
                          child: ListTile(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              GetAllSongs.player.setAudioSource(
                                  GetAllSongs.createSongList(_foundSongs),
                                  initialIndex: index);
                              GetAllSongs.player.play();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FullScreen(playersong: _foundSongs),
                                ),
                              );
                            },
                            leading: QueryArtworkWidget(
                              id: _foundSongs[index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(Icons.music_note),
                            ),
                            title: Text(_foundSongs[index].title),
                          ),
                        ),
                      )
                    : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
