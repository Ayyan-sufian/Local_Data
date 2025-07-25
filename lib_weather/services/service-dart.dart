import 'dart:convert';

import 'package:http/http.dart' as http;

import '../weather_models/weather_model.dart';

class WeatherServices {
  final String ApiKey = '6ef27302ad4e791331a56b278e0bd755';
  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$ApiKey',
    );
    final responce = await http.get(url);

    if (responce.statusCode == 200) {
      return Weather.fromJson(json.decode(responce.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }

  Future<List<Forecast>> fetchForecast(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$ApiKey&units=metric&cnt=40',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List list = jsonData['list'];
      return list.map((item) => Forecast.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load forecast.');
    }
  }
}
