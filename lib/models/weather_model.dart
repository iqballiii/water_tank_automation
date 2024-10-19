import 'package:equatable/equatable.dart';

class CurrentWeather extends Equatable {
  final double temp;
  final WeatherCondition condition;
  final WeatherLocation location;

  @override
  List<Object> get props => [temp, condition, location];

  CurrentWeather.fromJson(Map<String, dynamic> json)
      : temp = json['current']['temp_c'],
        location = WeatherLocation.fromJson(json['location']),
        condition = WeatherCondition.fromJson(json['current']['condition']);

  @override
  String toString() {
    return 'CurrentWeather{temp: $temp, condition: $condition, location: $location}';
  }
}

class WeatherLocation extends Equatable {
  final String name;
  final String country;

  WeatherLocation.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        country = json['country'];

  @override
  List<Object?> get props => [name, country];

  @override
  String toString() {
    return 'WeatherLocation{name: $name, country: $country}';
  }
}

class WeatherCondition extends Equatable {
  final String text;
  final String icon;

  WeatherCondition.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        icon = json['icon'];

  @override
  List<Object?> get props => [text, icon];

  @override
  String toString() {
    return 'WeatherCondition{text: $text, icon: $icon}';
  }
}
