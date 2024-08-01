import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(tempUnits: TempUnits.calcius));

  void toggleTemperature() {
    if (state.tempUnits == TempUnits.calcius) {
      emit(const SettingsState(tempUnits: TempUnits.fahrenheit));
      print('changed to fahrenheit');
    } else {
      emit(const SettingsState(tempUnits: TempUnits.calcius));
      print('changed to calcius');
    }
  }
}
