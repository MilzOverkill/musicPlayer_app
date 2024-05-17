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
      albumImagePath: "assets/image/dido.png",
      audioPath: "audio/dido.wav",
    ),

    //song 2

    Song(
      songName: "All the way up",
      artistName: "Fatjoe",
      albumImagePath: "assets/image/fatjoe.png",
      audioPath: "audio/fatjoe.wav",
    ),

    //song 3

    Song(
      songName: "Good Life",
      artistName: "Ryan Mack",
      albumImagePath: "assets/image/goodlife.png",
      audioPath: "audio/goodlife.wav",
    ),

    //song 4

    Song(
      songName: "Happy",
      artistName: "Kyle Hume",
      albumImagePath: "assets/image/happy.png",
      audioPath: "audio/happy.wav",
    ),

    //song 5

    Song(
      songName: "Happy - Despicable Me",
      artistName: "Pharrell Williams",
      albumImagePath: "assets/image/minions.png",
      audioPath: "audio/minions.wav",
    ),

    //song 6

    Song(
      songName: "The One That You Call",
      artistName: "Mackenzy Mackay",
      albumImagePath: "assets/image/onecall.png",
      audioPath: "audio/onecall.wav",
    ),

    //song 7

    Song(
      songName: "I Want It That Way",
      artistName: "Backstreet Boys",
      albumImagePath: "assets/image/iwantitthatway.png",
      audioPath: "audio/iwantitthatway.wav",
    ),

    //song 8

    Song(
      songName: "Mamma Mia!",
      artistName: "Random Australian Singer",
      albumImagePath: "assets/image/mammamia.png",
      audioPath: "audio/mammamia.wav",
    ),

    //song 9

    Song(
      songName: "Sweet Tooth",
      artistName: "Ryan Mack",
      albumImagePath: "assets/image/sweettooth.png",
      audioPath: "audio/sweettooth.wav",
    ),

    //song 10

    Song(
      songName: "Country Roads",
      artistName: "John Denver",
      albumImagePath: "assets/image/countryroads.png",
      audioPath: "audio/countryroads.wav",
    ),
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
