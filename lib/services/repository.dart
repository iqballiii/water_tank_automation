import 'package:dio/dio.dart';
import 'package:water_tank_automation/models/weather_model.dart';

const (double, double) currLatLng = (17.362451779964893, 78.4645146001037);

class URLProvider {
  static const weatherAPIUrl = '';
}

const apiKey = 'cfa505caf5b94acc9b384823242109';

class NetworkRepository {
  Future<bool> checkConnection() async {
    return true;
  }

  Future<CurrentWeather?> getWeather() async {
    Response response = await Dio().get(
        // "https://api.weatherapi.com/v1/current.json?key=cfa505caf5b94acc9b384823242109&q=Hyderabad,India&aqi=no");
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=${currLatLng.$1},${currLatLng.$2}&aqi=no');
    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(response.data);
    } else if (response.statusCode == 400) {
      var error = response.data as Map<String, dynamic>;
      throw error['error']['message'];
    } else {
      throw 'Unknown (${response.statusCode})';
    }
  }
}
