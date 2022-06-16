import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../canvos/arrow_clip_path.dart';
import '../model/covid_model.dart';
import '../repository/covid_repository.dart';

class CovidController extends GetxController {

  late CovidRepository _covidRepository;
  final Rx<Covid19Model?> _todayData = Covid19Model().obs;
  final RxList<Covid19Model?> _weekDatas = <Covid19Model>[].obs;
  double? maxDecideValue = 0;

  @override
  void onInit() {
    _covidRepository = CovidRepository();
    fetchCovidState();
    super.onInit();
  }

  void fetchCovidState() async {
    var startDate = DateFormat('yyyyMMdd').format(DateTime.now().subtract(const Duration(days: 8)));
    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());
    var result = await _covidRepository.fetchCovid19Statistics(startDate: startDate, endDate: endDate);
    if(result.isNotEmpty) {
      for(var i = 0; i < result.length; i++){
        if(i < result.length - 1) {
          result[i]?.updateCalcAboutYesterday(result[i+1]!);
          if (maxDecideValue! < result[i]!.calcdecideCnt) {
            maxDecideValue = result[i]!.calcdecideCnt;
          }
        }
      }
      _weekDatas.addAll(result.sublist(0, result.length - 1).reversed);
      _todayData(_weekDatas.last);
    }
  }

  Covid19Model get todayData => _todayData.value!;
  RxList<Covid19Model?> get weekData => _weekDatas;
  ArrowDirection calculrateUpDown(double value){
    if(value == 0){
      return ArrowDirection.MIDDLE;
    } else if(value > 0) {
      return ArrowDirection.UP;
    } else {
      return ArrowDirection.DOWN;
    }
  }
}