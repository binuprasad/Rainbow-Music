import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/view/screens/full_screen.dart';
import 'package:music_player/view/screens/get_all_songs.dart';
import 'package:music_player/model/model.dart';
import 'package:music_player/view/playlist/add_to_playlist.dart';
import 'package:music_player/db/playlist_db.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView(
      {Key? key, required this.playlist, required this.folderindex})
      : super(key: key);
  final MusicModel playlist;
  final int folderindex;

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  late List<SongModel> playlistsong;

  @override
  Widget build(BuildContext context) {
    getAllPlaylist();
    return Container(
      decoration:const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.yellow, Colors.white])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.playlist.name,
            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<MusicModel>('playlist_db').listenable(),
          builder: (BuildContext context, Box<MusicModel> value, Widget? child) {
            playlistsong =
                listPlaylist(value.values.toList()[widget.folderindex].songIds);
            return playlistsong.isEmpty
                ? const Center(
                    child: Text('Add your songs'),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          List<SongModel> newlist = [...playlistsong];
                          GetAllSongs.player.stop();
                          GetAllSongs.player.setAudioSource(
                              GetAllSongs.createSongList(newlist),
                              initialIndex: index);
                          GetAllSongs.player.play();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  FullScreen(playersong: GetAllSongs.playingSong)));
                        },
                        leading: QueryArtworkWidget(
                          id: playlistsong[index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                          errorBuilder: (context, excepion, gdb) {
                            setState(() {});
                            return Image.asset('');
                          },
                        ),
                        title: Text(
                          playlistsong[index].title,
                          style:
                              const TextStyle(fontSize: 15, color: Colors.black),
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          playlistsong[index].artist!,
                          style: const TextStyle(color: Colors.black54),
                          maxLines: 1,
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Remove song?'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('No')),
                                        TextButton(
                                            onPressed: () {
                                              widget.playlist.deleteData(
                                                  playlistsong[index].id);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Yes'))
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.delete)),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: playlistsong.length);
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) =>
                    AddToPlaylist(playlist: widget.playlist))));
          },
          child: const Icon(
            Icons.add,
            color: Colors.yellowAccent,
          ),
        ),
      ),
    );
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < GetAllSongs.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetAllSongs.songscopy[i].id == data[j]) {
          plsongs.add(GetAllSongs.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
