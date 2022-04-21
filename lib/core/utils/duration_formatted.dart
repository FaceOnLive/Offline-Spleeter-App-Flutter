class DurationUtil {
  /// Get duration in String from seconds
  static String getString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String minuteSecond = '$twoDigitMinutes:$twoDigitSeconds';
    // if the hour is 00 we don't want to return it
    return twoDigits(duration.inHours) == '00'
        ? minuteSecond
        : "${twoDigits(duration.inHours)}:$minuteSecond";
  }
}
