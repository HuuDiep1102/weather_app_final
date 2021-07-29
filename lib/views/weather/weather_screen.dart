import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/theme/gradients.dart';
import 'package:weather_app/views/weather/weather_error.dart';
import 'package:weather_app/views/weather/weather_view.dart';

class LocationScreen extends StatelessWidget {
  final int accent;
  final bool loading;
  final Location location;
  final Animation<double> controller;

  LocationScreen({
    required this.location,
    required this.loading,
    this.accent = 0,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    if (loading) {
      return Center(
        child: SpinKitPulse(
          size: 100,
          color: GradientValues().gradients[accent].gradient[0],
        ),
      );
    } else {
      Weather weather = location.getWeather();
      if (weather == null) {
        return ErrorView();
      } else {
        return LocationView(
          controller: controller,
          weather: weather,
          accent: accent,
        );
      }
    }
  }
}
