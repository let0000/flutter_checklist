import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'package:checklist/src/utils/xml_utils.dart';

import '../utils/data_utils.dart';


class Covid19Model {
  String? createDt;
  DateTime? stateDt;
  String? stateTime;
  String? updateDt;
  double? seq;
  double? deathCnt;
  double? decideCnt;
  double clacdeathCnt = 0;
  double calcdecideCnt = 0;

  Covid19Model({
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19Model.empty() {
    return Covid19Model();
  }

  factory Covid19Model.fromXml(XmlElement xml){
    return Covid19Model(
      createDt : xmlUtils.searchResultForString(xml, 'createDt'),
      stateDt : xmlUtils.searchResultForString(xml, 'stateDt') != ''
          ? DateTime.parse(xmlUtils.searchResultForString(xml, 'stateDt'))
          : null,
      stateTime : xmlUtils.searchResultForString(xml, 'stateTime'),
      updateDt : xmlUtils.searchResultForString(xml, 'updateDt'),
      deathCnt : xmlUtils.searchResultForDouble(xml, 'deathCnt'),
      decideCnt : xmlUtils.searchResultForDouble(xml, 'decideCnt'),
      seq : xmlUtils.searchResultForDouble(xml, 'seq'),
    );
  }

  void updateCalcAboutYesterday(Covid19Model yesterDayData) {
    _updateCalcDecideCnt(yesterDayData.decideCnt!);
    _updateCalcDeathCnt(yesterDayData.deathCnt!);
  }

  void _updateCalcDecideCnt(double beforeCnt) {
    calcdecideCnt = decideCnt! - beforeCnt;
  }

  void _updateCalcDeathCnt(double beforeCnt) {
    clacdeathCnt = deathCnt! - beforeCnt;
  }

  String? get standardDayString => stateDt == null
      ? ''
      : '${DataUtils.simpleDateFormat(stateDt!)} $stateTime 기준';
}

