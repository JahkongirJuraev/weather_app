import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState(tempUnits: TempUnits.calcius)) {
    on<ToggleTemperatureEvent>((event, emit) {
      toggleTemperature(event, emit);
    });
  }

  void toggleTemperature(ToggleTemperatureEvent event, Emitter emit) {
    if (state.tempUnits == TempUnits.calcius) {
      emit(const SettingsState(tempUnits: TempUnits.fahrenheit));
      print('changed to fahrenheit');
    } else {
      emit(const SettingsState(tempUnits: TempUnits.calcius));
      print('changed to calcius');
    }
  }
}
