import 'package:checklist/src/utils/weather_utils.dart';
import 'package:flutter/material.dart';

class WeatherModel {
  final WeatherUtils _weatherUtils = WeatherUtils();
  double? temp2;
  int? condition;
  String? des;
  int? temp;
  String? cityName;
  Widget? icon;

  WeatherModel({
    this.temp2,
    this.condition,
    this.des,
    this.cityName,
});

  factory WeatherModel.empty() {
    return WeatherModel();
  }

  factory WeatherModel.updateData(dynamic weatherData) {
    return WeatherModel(
    temp2 : weatherData['main']['temp'],
    condition : weatherData['weather'][0]['id'],
    des : weatherData['weather'][0]['description'],
    cityName : weatherData['name']
    );
  }

  void updateData(double temp2, int condition) {
    _getTemp(temp2);
    _getIcon(condition);
  }


  void _getTemp(double temp2) {
    temp = temp2.round();
  }

  void _getIcon(int condition) {
    icon = _weatherUtils.getWeatherIcon(condition);
  }

}