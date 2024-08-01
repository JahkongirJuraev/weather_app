import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/logic/service/weather_api_service.dart';

class WeatherRespository {
  final WeatherApiService weatherApiService;

  WeatherRespository({required this.weatherApiService});

  Future<Weather> getWeather(String city) async {
    return await weatherApiService.getWeather(city);
  }
}
