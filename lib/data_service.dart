// ignore: unused_import

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:network_request_two/appid.dart';
import 'package:network_request_two/models.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    //https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': AppId().appId,
      'units': 'metric',
    };
    final uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParameters);
    final response = await http.get(uri);

    final json = jsonDecode(response.body);

    return WeatherResponse.fromJson(json);
  }
}
