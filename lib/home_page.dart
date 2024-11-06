import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_weather_app/weather_provider.dart';
import 'package:the_weather_app/map_page.dart'; // Import the new MapPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LatLng _initialPosition;
  final TextEditingController _cityController =
      TextEditingController();
  Color _textColor =
      Colors.black; // Initial text color

  @override
  void initState() {
    super.initState();
    _initialPosition = const LatLng(0, 0);
  }

  Future<void>
      _requestLocationPermission() async {
    LocationPermission permission =
        await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission ==
            LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location permission is required.'),
        ),
      );
    }
  }

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        titleTextStyle: const TextStyle(
          fontSize: 32,
          fontFamily: 'Baskerville',
        ),
        backgroundColor: Colors.teal.shade600,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(
                  255, 13, 135, 142), // Dark blue
              Colors.black, // Black
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _cityController,
                    onChanged: (text) {
                      setState(() {
                        _textColor = text.isEmpty
                            ? Colors.black
                            : const Color
                                .fromARGB(255,
                                255, 255, 255);
                      });
                    },
                    style: TextStyle(
                        color: _textColor),
                    decoration: InputDecoration(
                      hintText: 'Enter city name',
                      hintStyle: const TextStyle(
                          color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                20),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    weatherProvider.fetchWeather(
                        _cityController.text);
                  },
                  child: const Text(
                      'Get Weather by City'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _requestLocationPermission();
                    Position position =
                        await _getCurrentLocation();
                    weatherProvider
                        .fetchWeatherByLatLng(
                      position.latitude,
                      position.longitude,
                    );
                  },
                  child: const Text(
                      'Get Weather of current Location'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) =>
                          MapPage(),
                    ))
                        .then((selectedLocation) {
                      if (selectedLocation !=
                          null) {
                        weatherProvider
                            .fetchWeatherByLatLng(
                          selectedLocation
                              .latitude,
                          selectedLocation
                              .longitude,
                        );
                      } else {
                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Location not found.'),
                          ),
                        );
                      }
                    });
                  },
                  child: const Text(
                      'Open Map to Select Location'),
                ),
                Consumer<WeatherProvider>(
                  builder: (context,
                      weatherProvider, child) {
                    if (weatherProvider.weather ==
                        null) {
                      return const Text("");
                    } else {
                      final weather =
                          weatherProvider
                              .weather!;
                      return Column(
                        children: [
                          Text(
                            '${weather.city}',
                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            '${weather.temperature}°C',
                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            weather.description,
                            style:
                                const TextStyle(
                                    color: Colors
                                        .white),
                          ),
                          Text(
                            'Humidity: ${weather.humidity}%',
                            style:
                                const TextStyle(
                                    color: Colors
                                        .white),
                          ),
                          Text(
                            'Pressure: ${weather.pressure} hPa',
                            style:
                                const TextStyle(
                                    color: Colors
                                        .white),
                          ),
                          Text(
                            'Wind Speed: ${weather.windSpeed} m/s',
                            style:
                                const TextStyle(
                                    color: Colors
                                        .white),
                          ),
                          Text(
                            'Min Temp: ${weather.minTemp}°C',
                            style:
                                const TextStyle(
                                    color: Colors
                                        .white),
                          ),
                          Text(
                            'Max Temp: ${weather.maxTemp}°C',
                            style:
                                const TextStyle(
                                    color: Colors
                                        .white),
                          ),
                          Text(
                            'Sea Level: ${weather.seaLevel} hPa',
                            style:
                                const TextStyle(
                                    color: Colors
                                        .white),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
