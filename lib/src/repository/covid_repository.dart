import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

import '../model/covid_model.dart';


class CovidRepository {
  late var _dio;

  CovidRepository() {
    _dio = Dio(
      BaseOptions(baseUrl: 'http://openapi.data.go.kr', queryParameters: {
        'ServiceKey':
        'IIj99+ce4ws/L0NSwwkw/nwM4tAezI7c8LsYwj5E1aX4RlMTw7Uzm56n3DnLglRJe3zKc+MoK440GDEgIxjShg=='
      }),
    );
  }

  Future<List<Covid19Model?>> fetchCovid19Statistics({required String startDate, required String endDate}) async {
    var query = <String, String>{};
    if(startDate != null) query.putIfAbsent('startCreateDt', () => startDate);
    if(startDate != null) query.putIfAbsent('endCreateDt', () => endDate);
    var response = await _dio.get(
        '/openapi/service/rest/Covid19/getCovid19InfStateJson',
        queryParameters: query);
    final document = XmlDocument.parse(response.data);
    final result = document.findAllElements('item');
    if(result.isNotEmpty){
      return result
          .map<Covid19Model>((element) => Covid19Model.fromXml(element))
          .toList();
    } else {
      return Future.value(null);
    }
  }
}
