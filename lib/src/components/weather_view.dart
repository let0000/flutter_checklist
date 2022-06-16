import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/weather_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherView extends GetView<WeatherController> {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Obx(() {
      var info = controller.weatherData;
      return info.cityName != null
          ? GestureDetector(
              onTap: () {
                print('날씨 다이얼로그 오픈');
              },
              child: Column(
                  children: [
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      info.cityName!,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(children: [
                      Column(
                        children: [
                          info.icon!,
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            info.des!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${info.temp.toString()} °',
                        style: const TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ],
                ),
              )
          : Column(
              children: const [
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 200,
                    child: SpinKitCircle(color: Colors.black, size: 40.0)),
              ],
            );
    }));
  }
}
