extension StringExtension on String {
  String capitilizeString() => '${this[0].toUpperCase()}${this.substring(1)}';
}
