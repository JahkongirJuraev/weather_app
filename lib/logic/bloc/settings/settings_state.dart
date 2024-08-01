part of 'settings_bloc.dart';

enum TempUnits {
  calcius,
  fahrenheit,
}

@immutable
class SettingsState {
  final TempUnits? tempUnits;

  const SettingsState({this.tempUnits});
}
