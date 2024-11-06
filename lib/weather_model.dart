class Weather {
  final String city;
  final double temperature;
  final String description;
  final String iconCode; // Add icon code
  final double humidity; // Add humidity
  final double pressure; // Add pressure
  final double windSpeed; // Add wind speed
  final double minTemp; // Add minimum temperature
  final double maxTemp; // Add maximum temperature
  final double seaLevel; // Add sea level

  Weather(
      {required this.city,
      required this.temperature,
      required this.description,
      required this.iconCode, // Add icon code
      required this.humidity, // Add humidity
      required this.pressure, // Add pressure
      required this.windSpeed, // Add wind speed
      required this.minTemp, // Add minimum temperature
      required this.maxTemp, // Add maximum temperature
      required this.seaLevel}); // Add sea level});

  factory Weather.fromJson(
      Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temperature: json['main']['temp'],
      description: json['weather'][0]
          ['description'],
      iconCode: json['weather'][0]['icon'],
      humidity:
          json['main']['humidity'].toDouble(),
      pressure:
          json['main']['pressure'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      minTemp:
          json['main']['temp_min'].toDouble(),
      maxTemp:
          json['main']['temp_max'].toDouble(),
      seaLevel:
          json['main']['sea_level'].toDouble(),
    );
  }
}
