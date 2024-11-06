import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_weather_app/weather_model.dart';

class WeatherService {
  final String openWeatherMapApiKey =
      '0f10a8864fb7c9f5d0755686dcedad05';

  Future<Weather> getWeather(String city) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$openWeatherMapApiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to load weather data');
    }
  }

  Future<Weather> getWeatherByLatLng(
      double lat, double lon) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$openWeatherMapApiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to load weather data by location');
    }
  }
}
