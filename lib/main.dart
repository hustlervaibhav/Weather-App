import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_weather_app/splash_page.dart';
import 'package:the_weather_app/weather_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    ),
  );
}
