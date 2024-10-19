import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_weather_app/weather_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context);
    final TextEditingController cityController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan[600],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade300,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/weathhy.jpg',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                              20),
                      gapPadding: 2,
                      borderSide:
                          const BorderSide(
                              color:
                                  Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255),
                              width: 10)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  weatherProvider.fetchWeather(
                      cityController.text);
                },
                child: const Text('Get Weather'),
              ),
              Consumer<WeatherProvider>(
                builder: (context,
                    weatherProvider, child) {
                  if (weatherProvider.weather ==
                      null) {
                    return const CircularProgressIndicator();
                  } else {
                    final weather =
                        weatherProvider.weather!;
                    return Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      children: [
                        Text(
                          '${weather.city}',
                          style: const TextStyle(
                              fontSize: 24),
                        ),
                        Text(
                          '${weather.temperature}°C',
                          style: const TextStyle(
                              fontSize: 32),
                        ),
                        Text(weather.description),
                        // Display weather icon using flutter_svg or other image libraries
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
