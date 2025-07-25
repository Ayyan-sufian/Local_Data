import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../services/service-dart.dart';
import '../weather_models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final List<Forecast> forecast;
  const WeatherCard({super.key, required this.weather, required this.forecast});

  String formateTime(int timestemp) {
    final date = DateTime.fromMicrosecondsSinceEpoch(timestemp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            weather.description.contains('rain')
                ? 'assets/rain.json'
                : weather.description.contains('clear')
                ? 'assets/cloudy.json'
                : 'assets/sunny.json',

            height: 150,
            width: 150,
          ),
          Text(
            weather.cityName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10),
          Text(
            '${weather.temperature.toStringAsFixed(1)}°C',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(height: 10),
          Text(
            weather.description,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Humidity : ${weather.humidity}%',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Wind Speed : ${weather.windspeed}m/s',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                  Text(
                    'Sun Rise : ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    formateTime(weather.sunrise),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.nights_stay_outlined, color: Colors.purple),
                  Text(
                    'Sun set : ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    formateTime(weather.sunset),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 50),
          const Text(
            '5-Day Forecast',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: forecast.length,
              itemBuilder: (context, index) {
                final f = forecast[index];
                final dateTime = DateFormat(
                  'EEE, hh a',
                ).format(DateTime.parse(f.date));
                return Card(
                  margin: const EdgeInsets.all(8),
                  color: Colors.white30,
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(dateTime, style: const TextStyle(fontSize: 12)),
                        Image.network(
                          'https://openweathermap.org/img/wn/${f.icon}@2x.png',
                          width: 50,
                          height: 50,
                          errorBuilder: (_, __, ___) => const Icon(Icons.cloud),
                        ),
                        Text('${f.temp.toStringAsFixed(0)}°C'),
                        Text(
                          f.description,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
