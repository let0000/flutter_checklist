import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/covid_controller.dart';
import 'covid_bar_chart.dart';

class CovidDialog extends GetView<CovidController> {
  const CovidDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        child: SizedBox(
          height: 260,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                '확진자 추이',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              AspectRatio(
                  aspectRatio: 1.7,
                  child: Obx(
                    () => controller.weekData.isEmpty
                        ? Container()
                        : CovidBarChart(
                            covidDatas: controller.weekData,
                            maxY: controller.maxDecideValue!,
                          ),
                  ))
            ],
          ),
        ));
  }
}
