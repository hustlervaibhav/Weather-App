import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_weather_app/weather_model.dart';

class WeatherService {
  final String apiKey =
      '0f10a8864fb7c9f5d0755686dcedad05'; // Replace with your actual API key

  Future<Weather> getWeather(String city) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to fetch weather data');
    }
  }
}
