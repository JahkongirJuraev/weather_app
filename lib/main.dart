import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weather_app/logic/bloc/settings/settings_bloc.dart';
import 'package:weather_app/logic/bloc/weather/weather_bloc.dart';
import 'package:weather_app/logic/cubit/settings/settings_cubit.dart';
import 'package:weather_app/logic/cubit/weather/weather_cubit.dart';
import 'package:weather_app/logic/repository/weather_respository.dart';
import 'package:weather_app/logic/service/weather_api_service.dart';
import 'package:weather_app/presentation/screens/main_screen.dart';
import 'package:weather_app/presentation/screens/search_screen.dart';
import 'package:weather_app/presentation/screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRespository(
          weatherApiService: WeatherApiService(client: Client())),
      child: MultiBlocProvider(
        providers: [
          //Cubit
          // BlocProvider(
          //     create: (ctx) => WeatherCubit(
          //         weatherRespository: ctx.read<WeatherRespository>())),
          // BlocProvider(
          //   create: (ctx) => SettingsCubit(),
          // ),

          //Bloc
          BlocProvider(
            create: (ctx) => WeatherBloc(
              weatherRespository: ctx.read<WeatherRespository>(),
            ),
          ),
          BlocProvider(
            create: (ctx) => SettingsBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const MainScreen(),
          routes: {
            SearchScreen.routeName: (ctx) => SearchScreen(),
            SettingsMenu.routeName: (ctx) => const SettingsMenu(),
          },
        ),
      ),
    );
  }
}
