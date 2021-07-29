import 'package:weather_app/services/weather.dart';
import 'package:flutter/material.dart';

import 'daily_detail_card.dart';


class DailyView extends StatelessWidget {
  final int accent;
  final List<Weather> daily;

  DailyView({
    required this.accent,
    required this.daily,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...getDaily(),
      ],
    );
  }

  getDaily() {
    return daily
        .map(
          (e) => DailyDetail(
            accent: accent,
            detail: e,
          ),
        )
        .toList();
  }
}
