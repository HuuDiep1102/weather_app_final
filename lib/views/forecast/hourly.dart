import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/views/forecast/hourly_detail_chip.dart';

class HourlyView extends StatelessWidget {
  final int accent;
  final List<Weather> hourly;

  HourlyView({
    required this.accent,
    required this.hourly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: 24),
          ...getHours(),
        ],
      ),
    );
  }

  List<Widget> getHours() {
    return hourly
        .map(
          (e) => HourlyDetail(
            accent: accent,
            detail: e,
          ),
        )
        .toList();
  }
}
