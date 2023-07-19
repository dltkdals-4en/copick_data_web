import 'package:flutter/material.dart';

class EnterVolumesProvider with ChangeNotifier{
  String volumes = '0';
  int openIndex = -1;
  String formatDate(String date){

    return '';
  }
  void addVolumes(double d){
    // volumes = volumes+d;
    // notifyListeners();
  }

  void changeVolumes(String value) {
    volumes =value;
    notifyListeners();
  }

  void changeOpenIndex(int index) {
    openIndex =index;
    notifyListeners();
  }

  void init() {
    volumes = '0';
    openIndex = -1;
    notifyListeners();
  }

  String volumesText(double? totalVolume) {
    if(totalVolume ==0 || totalVolume == null){
      return '입력 안됨';
    }else{
      return '${totalVolume.toStringAsFixed(2)}Kg';
    }
  }

}