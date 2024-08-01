import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/bloc/settings/settings_bloc.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  static const String routeName = "/settings-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListTile(
        title: const Text('Temperature unit'),
        subtitle: const Text('Celcius / Fahrenheit (default:Celcius)'),
        trailing: Switch.adaptive(
          //cubit
          // value: context.watch<SettingsCubit>().state.tempUnits ==
          //         TempUnits.calcius
          //     ? true
          //     : false,

          //bloc
          value:
              context.watch<SettingsBloc>().state.tempUnits == TempUnits.calcius
                  ? true
                  : false,
          onChanged: (value) =>
              //Cubit
              //    context.read<SettingsCubit>().toggleTemperature(),
              context.read<SettingsBloc>().add(
                    ToggleTemperatureEvent(),
                  ),
        ),
      ),
    );
  }
}
