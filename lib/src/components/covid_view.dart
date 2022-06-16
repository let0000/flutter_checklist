import 'package:checklist/src/components/covid_dialog.dart';
import 'package:checklist/src/controller/covid_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../canvos/arrow_clip_path.dart';
import '../utils/data_utils.dart';

class CovidView extends GetView<CovidController> {
  const CovidView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;
    switch (controller.calculrateUpDown(controller.todayData.calcdecideCnt)) {
      case ArrowDirection.UP:
        color = const Color(0xffcf5f51);
        break;
      case ArrowDirection.MIDDLE:
        // TODO: Handle this case.
        break;
      case ArrowDirection.DOWN:
        color = const Color(0xff3749be);
        break;
    }

    return Center(child: Obx(() {
      return GestureDetector(
        onTap: () {
          Get.dialog(CovidDialog());
        },
        child: controller.todayData.decideCnt != null
            ? Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('일일 확진자',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipPath(
                        clipper: ArrowClipPath(
                            direction: controller.calculrateUpDown(
                                controller.todayData.calcdecideCnt)),
                        child: Container(
                          width: 20,
                          height: 20,
                          color: color,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                          DataUtils.numberFormat(
                              controller.todayData.calcdecideCnt),
                          style: TextStyle(
                              color: color,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
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
              ),
      );
    }));
  }
}
