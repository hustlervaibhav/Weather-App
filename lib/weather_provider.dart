import 'package:flutter/material.dart';
import 'package:the_weather_app/weather_model.dart';
import 'package:the_weather_app/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  WeatherService _weatherService =
      WeatherService();

  Weather? get weather => _weather;

  Future<void> fetchWeather(String city) async {
    try {
      _weather =
          await _weatherService.getWeather(city);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchWeatherByLatLng(
      double lat, double lon) async {
    try {
      _weather = await _weatherService
          .getWeatherByLatLng(lat, lon);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }
}
