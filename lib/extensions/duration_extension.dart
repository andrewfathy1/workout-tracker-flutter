extension DurationExtensions on int {
  String toReadableDuration() {
    final hours = this ~/ 3600;
    final minutes = (this % 3600) ~/ 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}m';
    }
  }
}
