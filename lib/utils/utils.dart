class Utils {
  ///converts a millisecond to time in hour-minute-seconds format
  static String convertFrom(int duration, [bool isUsedOnSlider = false]) {
    var hours = duration ~/ 3600000;
    final hoursRemainder = duration.remainder(3600000);
    var minutes = (hoursRemainder ~/ 60000);
    final minutesRemainder = hoursRemainder.remainder(60000);
    var seconds = (minutesRemainder / 1000).round();

    if (minutes == 60) {
      minutes = 0;
      hours += 1;
    }

    if (seconds == 60) {
      seconds = 0;
      minutes += 1;
    }

    final correctedHours = _ensureTwoDigits(hours);
    final correctedMinutes = _ensureTwoDigits(minutes);
    final correctedSeconds = _ensureTwoDigits(seconds);

    final hoursLabel = _getLabel(hours, 'hr');
    final minutesLabel = _getLabel(minutes, 'min');

    return isUsedOnSlider
        ? hours == 0
            ? '$correctedMinutes : $correctedSeconds '
            : '$correctedHours : $correctedMinutes : $correctedSeconds '
        : hours == 0
            ? minutes == 0
                ? '$correctedSeconds sec '
                : '$correctedMinutes $minutesLabel '
            : '$correctedHours $hoursLabel $correctedMinutes $minutesLabel ';
  }

  static String _ensureTwoDigits(int number) {
    final isLong = number.toString().length > 1;
    return !isLong ? '0$number' : '$number';
  }

  static String _getLabel(int number, String singularLabel) {
    return number > 1 ? '${singularLabel}s' : singularLabel;
  }
}
