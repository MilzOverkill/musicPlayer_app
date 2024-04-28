import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  //playlist of songs
  final List<Song> _playlist = [
    //song 1

    Song(
        songName: "Thankyou",
        artistName: "Dido",
        albumImagePath: "assets/image/dido.jpg",
        audioPath: "assets/audio/dido.mp3"),

    //song 2

    Song(
        songName: "All the way up",
        artistName: "Fatjoe",
        albumImagePath: "assets/image/fatjoe.jpg",
        audioPath: "assets/audio/fatjoe.mp3"),
  ];

  //current song playing index
  int? _currentSongIndex;

  /*
  A U D I O  P L A Y E R
  
  */

  //audio player

  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider() {
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;

  //play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current playing song
    await _audioPlayer.play(AssetSource(path)); //play the new song
    _isPlaying = true;
    notifyListeners();
  }

  //pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        //go tot he next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() async {
    //if more than 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        //if it's the first song, loop back to last song
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //listen to duration
  void listenToDuration() {
    //listen for the total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //listen for the current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //dispose audio player

  /*

  Getters


  */

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*

  
  
  setters
  
  */

  set currentSongIndex(int? newIndex) {
    //update current song
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }

    //update ui
    notifyListeners();
  }
}
