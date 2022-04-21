import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../features/splitter/controllers/splitter_controller.dart';

class NativeFunctions {
  /// Channel Name
  static MethodChannel channel = const MethodChannel('com.turingalan.splitter');

  /// Set Audio
  static Future<int> init() async {
    // Invoke Method
    channel.setMethodCallHandler(nativeMethodCallHandler);

    int ret = 0;
    try {
      dynamic _value = await channel.invokeMethod('init', {});

      // check if the value is okay
      ret = _value;
    } on Exception catch (_) {}

    // return value
    return ret;
  }

  /// Dispose Audio
  static Future<void> disposeAudio() async {
    try {
      await channel.invokeMethod('uninit');
    } on Exception catch (_) {}
  }

  // static Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
  //   if (methodCall.method == "onPlayed") {
  //     if (kDebugMode) print("played: " + methodCall.arguments.toString());
  //   }

  //   return null;
  // }

  static Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    if (methodCall.method == "onPlayed") {
      // if (kDebugMode) print("played: " + methodCall.arguments.toString());
    } else if (methodCall.method == "onLoaded") {
      // if (kDebugMode) print("loadded: " + methodCall.arguments.toString());
      onLoaded(methodCall.arguments.toString());
      return methodCall.arguments.toString();
    } else if (methodCall.method == "onInited") {
      // if (kDebugMode) print("loadded: " + methodCall.arguments.toString());
      // print("onInited: " + methodCall.arguments.toString());
      return methodCall.arguments.toString();
    }
  }

  /// Set Audio
  static Future<bool> loadAudio(String path) async {
    int _playSize = 0;
    // Invoke Method
    try {
      dynamic _value =
          await channel.invokeMethod('loadAudio', {'audioPath': path});

      // check if the value is okay
      _playSize = _value;
      if (kDebugMode) print("Play size is $_playSize");
    } on Exception catch (_) {}

    // int durationSeconds = _playSize ~/ 44100;

    return _playSize == 1 ? true : false;
  }

  /// Plays the audio
  static Future<bool> playAudio(int seek) async {
    bool playRet = false;
    try {
      dynamic _value = await channel.invokeMethod('play', {
        'seek': seek,
      });

      // check if the value is okay
      playRet = _value;
    } on Exception catch (_) {}

    return playRet;
  }

  /// Pause currently playing audio
  static Future<void> pauseAudio() async {
    return await channel.invokeMethod('pause');
  }

  /// Adjust The Audio Properties
  static Future<void> adjustAudio({
    int? vocal,
    int? piano,
    int? drum,
    int? bass,
    int? others,
  }) async {
    await channel.invokeMethod('adjust', {
      'vocal': vocal,
      'piano': piano,
      'drum': drum,
      'bass': bass,
      'others': others,
    });
  }

  /// Get total percentage of buffered
  static Future<int> getProgress() async {
    int _theProgress = await channel.invokeMethod('progress');
    return _theProgress;
  }

  /// Save the modified audio to device
  static Future<void> saveAudioOne({required String path}) async {
    return await channel.invokeMethod('saveOne', {
      'outWavePath': path,
    });
  }

  /* <-----------------------> 
      Native Method Handler    
   <-----------------------> */

  static Future<void> onLoaded(String arguments) async {
    final _splitter = Get.find<SplitterController>();
    bool _isInitialized = _splitter.initialized;
    if (_isInitialized) {
      int _theDuration = int.tryParse(arguments) ?? 0;
      int _durationSeconds = _theDuration ~/ 44100;
      _splitter.totalPlaySize = _theDuration;
      _splitter.totalDurationSeconds = _durationSeconds.toDouble();
      _splitter.applyTotalDuration(_durationSeconds);
      _splitter.update();
    }
  }

  static Future<double> onInited() async {
    double _value = double.parse(
        await nativeMethodCallHandler(const MethodCall('onInited')));
    return _value;
  }
}
