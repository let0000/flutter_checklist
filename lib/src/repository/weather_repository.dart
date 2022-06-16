import 'dart:convert';
import 'package:http/http.dart';

import '../model/weather_model.dart';

class WeatherRepository {
  final String url;

  WeatherRepository(this.url);

  Future<WeatherModel?> getJsonData() async {
    var Purl1 = Uri.parse(url);
    Response response = await get(Purl1);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return WeatherModel.updateData(parsingData);
    }
  }
}