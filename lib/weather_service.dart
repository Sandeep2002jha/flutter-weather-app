import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  static const String apiKey = 'Your_Key_here';
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> getWeather(String city) async {
    final url = Uri.parse(
      '$baseUrl?q=${Uri.encodeComponent(city)}&appid=$apiKey&units=metric',
    );

    final response = await http.get(url);

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    print('Request URL: $url');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception(
        'Failed to load weather data. Status: ${response.statusCode}, Body: ${response.body}',
      );
    }
  }
}
