import 'package:flutter/material.dart';
import 'package:music_player_app/components/my_drawer.dart';
import 'package:music_player_app/models/playlist_provider.dart';
import 'package:music_player_app/models/song.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text("P L A Y L I S T")),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          //get the playlist
          final List<Song> playlist = value.playlist;

          //return list view UI
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index)  {

              //get individual song
              final Song song = playlist[index];

              //return list title ui

              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumImagePath),
                

              );


            },
          );
        },
      ),
    );
  }
}