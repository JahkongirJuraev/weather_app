import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/cubit/weather/weather_state.dart';
import 'package:weather_app/logic/repository/weather_respository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRespository weatherRespository;

  WeatherCubit({required this.weatherRespository}) : super(WeatherInitial());

  Future<void> getWeather(String city) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRespository.getWeather(city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
