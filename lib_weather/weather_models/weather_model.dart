class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windspeed;
  final int sunset;
  final int sunrise;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windspeed,
    required this.sunset,
    required this.sunrise,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'] - 273.15,
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windspeed: json['wind']['speed'],
      sunrise: json['sys']['sunset'],
      sunset: json['sys']['sunrise'],
    );
  }
}

class Forecast {
  final String date;
  final double temp;
  final String description;
  final String icon;

  Forecast({
    required this.date,
    required this.temp,
    required this.description,
    required this.icon,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: json['dt_txt'], // e.g., "2025-07-25 15:00:00"
      temp: json['main']['temp'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
