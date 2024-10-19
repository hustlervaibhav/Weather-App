// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_weather_app/home_page.dart';
import 'package:the_weather_app/weather_model.dart';
import 'package:the_weather_app/weather_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('HomePage title test',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => WeatherProvider(),
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    // Act
    final titleFinder = find.text('Weather App');

    // Assert
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Weather data display test',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => WeatherProvider(),
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    // Act
    final weatherProvider =
        Provider.of<WeatherProvider>(
            tester.element(find.byType(HomePage)),
            listen: false);
    weatherProvider.weather = Weather(
        city: 'New York',
        temperature: 25,
        description: 'Sunny',
        icon: '01d');
    await tester.pump();

    // Assert
    expect(find.text('New York'), findsOneWidget);
    expect(find.text('25°C'), findsOneWidget);
    expect(find.text('Sunny'), findsOneWidget);
  });
}
