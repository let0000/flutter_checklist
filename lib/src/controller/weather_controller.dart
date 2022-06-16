import 'package:checklist/src/model/weather_model.dart';
import 'package:get/get.dart';
import '../repository/weather_repository.dart';
import '../repository/my_location.dart';

const apikey = '3d9dc8ab0aeba4bb77554214de6d1ecb';

class WeatherController extends GetxController {
  final Rx<WeatherModel> _weatherData = WeatherModel().obs;
  double? lat;
  double? lon;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    lat = myLocation.latitude2;
    lon = myLocation.longitude2;
    print(lat);
    print(lon);

    WeatherRepository weatherRepository = WeatherRepository(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apikey&units=metric',
    );

    var weatherData = await weatherRepository.getJsonData();
    if(weatherData != null) {
      weatherData.updateData(weatherData.temp2!, weatherData.condition!);
      print(weatherData);
      _weatherData(weatherData);
    }
  }

  WeatherModel get weatherData => _weatherData.value;
}