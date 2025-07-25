import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/service-dart.dart';
import '../weather_models/weather_model.dart';
import '../widget/weather_card.dart';

class MyAppHome extends StatefulWidget {
  const MyAppHome({super.key});

  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  final TextEditingController _cityNameController = TextEditingController();

  final WeatherServices _weatherServices = WeatherServices();

  bool _isLoading = false;

  List<Forecast>? _forecast;

  Weather? _weather;

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final weather = await _weatherServices.fetchWeather(
        _cityNameController.text,
      );
      final forecast = await _weatherServices.fetchForecast(
        _cityNameController.text,
      );
      setState(() {
        _weather = weather;
        _forecast = forecast;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              _weather != null &&
                  _weather!.description.toLowerCase().contains("rain")
              ? const LinearGradient(
                  colors: [Colors.grey, Colors.blueGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : _weather != null &&
                    _weather!.description.toLowerCase().contains('clear')
              ? const LinearGradient(
                  colors: [Colors.orangeAccent, Colors.blueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [Colors.grey, Colors.lightBlue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 300),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 120),
                  Text(
                    "Weather App",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 115),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _cityNameController,
                    decoration: InputDecoration(
                      label: Text(
                        "City",
                        style: TextStyle(color: Colors.white),
                      ),
                      hintText: 'Enter your city:',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _getWeather();
                    },
                    child: Text(
                      "Get Weather",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  if (_isLoading)
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  if (_weather != null && _forecast != null)
                    SizedBox(
                      width: double.infinity,
                      child: WeatherCard(
                        weather: _weather!,
                        forecast: _forecast!,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
