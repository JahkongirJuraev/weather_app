import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/helper/extensions/string_extension.dart';
import 'package:weather_app/logic/bloc/settings/settings_bloc.dart';

class TempPart extends StatelessWidget {
  const TempPart({
    super.key,
    required this.weather,
  });

  final Weather weather;

  String _showTemperature(double temp, BuildContext context) {
    //final tempUnit = context.watch<SettingsCubit>().state.tempUnits;

    //bloc
    final tempUnit = context.watch<SettingsBloc>().state.tempUnits;

    if (tempUnit == TempUnits.fahrenheit) {
      return '${((temp * 9 / 5) + 32).toStringAsFixed(0)}°F';
    }
    return '${temp.toStringAsFixed(0)}°C';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _showTemperature(weather.temperature, context),
          style:
              const TextStyle(color: Colors.white, fontSize: 70, height: 0.6),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              'https://openweathermap.org/img/wn/${weather.icon}.png',
              height: 60,
              width: 60,
            ),
            Text(
              weather.main.capitilizeString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        )
      ],
    );
  }
}
