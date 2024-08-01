part of 'settings_cubit.dart';

enum TempUnits {
  calcius,
  fahrenheit,
}

@immutable
class SettingsState {
  final TempUnits? tempUnits;

  const SettingsState({this.tempUnits});
}
