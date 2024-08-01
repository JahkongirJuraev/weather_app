import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/helper/extensions/string_extension.dart';
import 'package:weather_app/logic/bloc/weather/weather_bloc.dart';
import 'package:weather_app/logic/repository/weather_respository.dart';
import 'package:weather_app/logic/service/weather_api_service.dart';
import 'package:weather_app/presentation/screens/search_screen.dart';
import 'package:weather_app/presentation/screens/settings_screen.dart';
import 'package:weather_app/presentation/widgets/city_part.dart';
import 'package:weather_app/presentation/widgets/temp_part.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String city = 'tashkent';
  @override
  void initState() {
    super.initState();
    //Cubit
    //context.read<WeatherCubit>().getWeather(city);

    //Bloc
    context.read<WeatherBloc>().add(
          LoadWeatherDataEvent(city),
        );
  }

  void _getWeather(String city) {
    //Cubit
    //context.read<WeatherCubit>().getWeather(city);
    //Bloc
    context.read<WeatherBloc>().add(
          LoadWeatherDataEvent(city),
        );
  }

  void _getWeatherData() async {
    final weatherRep = WeatherRespository(
        weatherApiService: WeatherApiService(client: Client()));

    final weather = await weatherRep.weatherApiService.getWeather(city);
    print("Weather tempt: ${weather.temperature}");
    print("Weahter desc: ${weather.desc}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("Weather app"),
        // ),
        body: BlocConsumer<WeatherBloc, WeatherState>(builder: (ctx, state) {
      if (state is WeatherInitial) {
        return const Center(
          child: Text("Please, select the city"),
        );
      }

      if (state is WeatherLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is WeatherLoaded) {
        final weather = state.weather;
        String imageUrl = '';
        String mainWeather = weather.main.toLowerCase();
        if (mainWeather.contains('cloud')) {
          imageUrl = 'assets/cloud.jpg';
        } else if (mainWeather.contains('rain')) {
          imageUrl = 'assets/rainy.jpg';
        } else if (mainWeather.contains('sun')) {
          imageUrl = 'assets/sunny.jpg';
        } else {
          imageUrl = 'assets/night.jpg';
        }
        return Stack(
          children: [
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Container(
              color: Colors.black.withOpacity(0.4),
            ),
            Positioned(
                right: 0,
                top: 40,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final _city = await Navigator.of(context)
                            .pushNamed(SearchScreen.routeName);
                        if (_city != null) {
                          //city = newCity as String;
                          _getWeather(_city as String);
                        }
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(SettingsMenu.routeName),
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 30,
                        ))
                  ],
                )),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CityPart(weather: weather),
                  TempPart(weather: weather),
                ],
              ),
            ))
          ],
        );
      }

      return Container();
    }, listener: (ctx, state) async {
      if (state is WeatherError) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Error"),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK"),
                    ),
                  ],
                ));

        if (state.message.toLowerCase().contains("not found")) {
          city = 'tashkent';
          _getWeather(city);
        }
      }
    }));
  }
}
