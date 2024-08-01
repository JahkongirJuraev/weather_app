import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/logic/repository/weather_respository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRespository weatherRespository;
  WeatherBloc({required this.weatherRespository}) : super(WeatherInitial()) {
    on<LoadWeatherDataEvent>((event, emit) async {
      await getWeather(event, emit);
    });
  }

  Future<void> getWeather(LoadWeatherDataEvent event, Emitter emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRespository.getWeather(event.city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
