import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/helper/extensions/string_extension.dart';

class CityPart extends StatelessWidget {
  const CityPart({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weather.city.capitilizeString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        Text(
          weather.desc.capitilizeString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
