import 'package:flutter/material.dart';
import 'package:music_player_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
//playlist of songs
  final List<Song> _playlist = [
    //song 1

    Song(
        songName: "Thankyou",
        artistName: "Dido",
        albumImagePath: "dido.jpg",
        audioPath: "dido.mp3"),

    //song 2

    Song(
        songName: "All the way up",
        artistName: "Fatjoe",
        albumImagePath: "fatjoe.jpg",
        audioPath: "fatjoe.mp3"),
  ];

  //current song playing index
  int? _currentSongIndex;

  /*

  Getters


  */

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  /*

  
  
  setters
  
  */
}