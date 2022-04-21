import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/native_bridge/functions.dart';
import '../../../core/utils/app_toast.dart';
import '../../../core/utils/duration_formatted.dart';

enum SplitterState { loadingAudio, playing, paused, adjusting, exporting }

class SplitterController extends GetxController {
  final String filePath;
  final String songName;
  SplitterController({required this.filePath, required this.songName});

  /// Song Name when it is laoded
  String loadedSongName = 'song_name';

  /// Load Audio on Initial State
  SplitterState state = SplitterState.loadingAudio;

  Future<bool> loadAudio({bool isMultiThreaded = false}) async {
    //await Future.delayed(const Duration(seconds: 3));
    loadedSongName = songName;

    /// Load Audio Here
    bool _isLoaded = await NativeFunctions.loadAudio(filePath);
    //await NativeFunctions.playAudio(0); //for test

    return _isLoaded;
  }

  // is the audio playing
  /// Play Size
  int totalPlaySize = 0;

  //
  double totalDurationSeconds = 0; // in seconds
  int totalPlayedDuration = 0; // in seconds
  String totalDurationString = '00:00';
  String totalDurationPlayedString = '00:00';

  /// Applies the total duration when loading the audio
  void applyTotalDuration(int totalSeconds) {
    totalDurationString =
        DurationUtil.getString(Duration(seconds: totalSeconds));
  }

  /// Get current played duration
  /// Should run every seconds
  void applyCurrentPlayedDuration() {
    if (state == SplitterState.playing &&
        totalPlayedDuration < totalDurationSeconds) {
      totalPlayedDuration = totalPlayedDuration + 1;
      totalDurationPlayedString =
          DurationUtil.getString(Duration(seconds: totalPlayedDuration));
    }

    if (totalPlayedDuration == totalDurationSeconds) {
      onPause();
    }
  }

  /// Music Controls
  void onPlay({int? seek}) async {
    double _onePercentOfPlaySize = totalPlaySize / 100;
    double _totalPlayedDurationIn100 =
        (totalPlayedDuration / totalDurationSeconds) * 100;

    int _totalPlayedDurationPlaySize = totalPlayedDuration == 0
        ? 0
        : _totalPlayedDurationIn100.toInt() * _onePercentOfPlaySize.toInt();

    /// converts incoming playSize seeks to seonds
    double _playfrom = seek == null ? 0 : seek / 44100;

    await NativeFunctions.playAudio(seek ?? _totalPlayedDurationPlaySize);
    totalPlayedDuration =
        seek == null ? totalPlayedDuration : _playfrom.toInt();

    state = SplitterState.playing;
    update();
  }

  void onPause() async {
    await NativeFunctions.pauseAudio();
    state = SplitterState.paused;
    update();
  }

  // How long the audio has been processed
  double totalProcessedAudio = 0;

  /// Get Total Buffered Audio
  void getProcessedAudio() async {
    if (totalProcessedAudio < totalDurationSeconds) {
      int theProgress = await NativeFunctions.getProgress();
      if (kDebugMode) print("Total Buffered Audio $theProgress%");
      totalProcessedAudio = theProgress.toDouble();
      update();
    }
  }

  /// On duration Slider clicked
  void onDurationSliderPressed(double? seek) {
    if (seek != null) {
      double _onePercentOfPlaySize = totalPlaySize / 100;
      double _seekIn100 = (seek / totalDurationSeconds) * 100;

      double seekInPlaySize = _seekIn100 * _onePercentOfPlaySize;

      double _processedAudioInPlaySize =
          totalProcessedAudio * _onePercentOfPlaySize;

      print("Processed Audio In Play Size $_processedAudioInPlaySize");
      print("Seek in play is : $seekInPlaySize");

      if (seekInPlaySize >= _processedAudioInPlaySize) {
        AppToast.showDefaultToast('Please wait for the audio loading...');
      } else {
        totalPlayedDuration = seek.toInt();
        if (state == SplitterState.playing) {
          onPlay(seek: seekInPlaySize.toInt());
        } else {
          totalDurationPlayedString =
              DurationUtil.getString(Duration(seconds: totalPlayedDuration));
          update();
        }
        // update();
        if (kDebugMode) print("Total Played duration is :$totalPlayedDuration");
      }
    }
  }

  /* <---- Audio Adjust -----> */
  /// bass of music
  double bassLevel = 100;

  /// vocal of music
  double vocalLevel = 100;

  /// drum level of music
  double drumLevel = 100;

  /// piano level of music
  double pianoLevel = 100;

  /// others level of music
  double othersLevel = 100;

  /// Adjust the audio accoridingly
  Future<void> adjustAudio({
    double? bass,
    double? vocal,
    double? piano,
    double? drum,
    double? others,
  }) async {
    bassLevel = bass ?? bassLevel;
    vocalLevel = vocal ?? vocalLevel;
    pianoLevel = piano ?? pianoLevel;
    drumLevel = drum ?? drumLevel;
    othersLevel = others ?? othersLevel;
    update();
    await NativeFunctions.adjustAudio(
      bass: bass?.toInt(),
      vocal: vocal?.toInt(),
      piano: piano?.toInt(),
      drum: drum?.toInt(),
      others: others?.toInt(),
    );
  }

  /// Save this audio
  Future<void> saveThisAudio() async {
    final _directory = await getExternalStorageDirectory();
    if (_directory != null) {
      if (kDebugMode) print("Found the path ${_directory.path}");
      await NativeFunctions.saveAudioOne(path: _directory.path);
    }
  }

  /// Used for checking processed audio
  late Timer? _timer;

  /// On Init
  @override
  void onInit() async {
    super.onInit();
    await loadAudio();

    state = SplitterState.paused;
    update();
  }

  /// On UI Ready
  @override
  void onReady() async {
    super.onReady();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      // If we should run this function more
      if (totalProcessedAudio <= totalDurationSeconds) {
        getProcessedAudio();
      }

      applyCurrentPlayedDuration();
    });

    // await Future.delayed(const Duration(seconds: 5));
    // totalDuration = await NativeFunctions.onLoaded();
  }

  /// On Close
  @override
  void onClose() {
    super.onClose();
    NativeFunctions.disposeAudio();
    if (_timer != null) _timer!.cancel();
  }
}
