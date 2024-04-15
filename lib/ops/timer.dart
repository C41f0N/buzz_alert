class Timer {
  DateTime startTime;

  Timer(this.startTime);

  Duration getTimeSinceStart() {
    return Duration(
        milliseconds: DateTime.now().millisecondsSinceEpoch -
            startTime.millisecondsSinceEpoch);
  }
}
