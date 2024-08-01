part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class LoadWeatherDataEvent extends WeatherEvent {
  String city;
  LoadWeatherDataEvent(this.city);
}
