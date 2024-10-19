import 'package:flutter/material.dart';
import 'package:the_weather_app/weather_model.dart';
import 'package:the_weather_app/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  set weather(Weather? value) {
    _weather = value;
    notifyListeners();
  }

  Future<void> fetchWeather(String city) async {
    try {
      weather =
          await WeatherService().getWeather(city);
    } catch (e) {
      // Handle errors
    }
  }
}
