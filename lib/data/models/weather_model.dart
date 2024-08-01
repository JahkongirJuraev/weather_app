// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  final String id;
  final String main;
  final String desc;
  final String icon;
  final double temperature;
  final String city;
  Weather({
    required this.id,
    required this.main,
    required this.desc,
    required this.icon,
    required this.temperature,
    required this.city,
  });
}
