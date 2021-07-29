

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'api_helper.dart';
import 'weather.dart';

class Location {
  late double lat;
  late double lon;
  late Weather weather;
  List<Weather> daily = [];
  List<Weather> hourly = [];

  String apiKey = "ee3ea3c138da18505bb8125cb2d16611";

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      lat = position.latitude;
      lon = position.longitude;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getLocationData() async {
    if (lat == null || lon == null) {
      throw ("No lat or lon data found");
    }
    APIService apiService = APIService(
      url:
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey",
    );
    var decoded = await apiService.fetchData();

    weather = Weather(
      name: decoded['name'],
      timezone: decoded['timezone'],
      sunset: decoded['sys']['sunset'],
      sunrise: decoded['sys']['sunrise'],
      humidity: decoded['main']['humidity'],
      condition: decoded['weather'][0]['id'],
      latitude: decoded['coord']['lat'].toDouble(),
      longitude: decoded['coord']['lon'].toDouble(),
      windSpeed: decoded['wind']['speed'].toString(),
      temperature: decoded['main']['temp'].toDouble(),
      description: decoded['weather'][0]['description'],
      date: 0, tempMin: 0, tempMax: 0
    );
  }

  Future<void> getCityData(String cityName) async {
    APIService apiService = APIService(
      url:
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey",
    );
    var decoded = await apiService.fetchData();

    weather = Weather(
      name: decoded['name'],
      timezone: decoded['timezone'],
      sunset: decoded['sys']['sunset'],
      sunrise: decoded['sys']['sunrise'],
      humidity: decoded['main']['humidity'],
      condition: decoded['weather'][0]['id'],
      latitude: decoded['coord']['lat'].toDouble(),
      longitude: decoded['coord']['lon'].toDouble(),
      windSpeed: decoded['wind']['speed'].toString(),
      temperature: decoded['main']['temp'].toDouble(),
      description: decoded['weather'][0]['description'],
        date: 0, tempMin: 0, tempMax: 0
    );
  }

  Future<void> getForecast(double latitude, double longitude) async {
    if (latitude == null || longitude == null) {
      throw ("No lat or lon data found");
    }

    APIService apiService = APIService(
      url:
          "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely,current&appid=$apiKey",
    );
    var decoded = await apiService.fetchData();

    final List<dynamic> dailyData = decoded['daily'];
    final List<dynamic> hourlyData = decoded['hourly'];

    dailyData.forEach((data) {
      daily.add(Weather(
        name: weather.name,
        timezone: weather.timezone,
        date: data['dt'],
        sunset: data['sunset'],
        sunrise: data['sunrise'],
        humidity: data['humidity'],
        condition: data['weather'][0]['id'],
        tempMin: data['temp']['min'].toDouble(),
        tempMax: data['temp']['max'].toDouble(),
        windSpeed: data['wind_speed'].toString(),
        description: data['weather'][0]['description'], 
          latitude: 0,
        longitude: 0, temperature: 0
      ));
    });

    hourlyData.forEach((data) {
      hourly.add(Weather(
        name: weather.name,
        timezone: weather.timezone,
        date: data['dt'],
        humidity: data['humidity'],
        condition: data['weather'][0]['id'],
        temperature: data['temp'].toDouble(),
        windSpeed: data['wind_speed'].toString(),
        description: data['weather'][0]['description'],
        longitude: 0, tempMax: 0, latitude: 0, sunrise: 0, sunset: 0, tempMin: 0
      ));
    });
  }

  getWeather() => weather;

  getHourly() => hourly;

  getDaily() => daily;

  @override
  String toString() {
    return 'Location(lat: $lat, long: $lon, Weather: ${weather.toString()})';
  }
}
