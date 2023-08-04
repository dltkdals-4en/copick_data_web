import 'package:copick_data_web/models/waste_location_model.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class AdminProvider with ChangeNotifier {
  SideMenuController sideMenuController = SideMenuController();
  PageController pageController = PageController(initialPage: 1);
  List<String> manageTitleList = ['카페 관리하기', '수거 경로 관리하기', '수거 기록 관리하기'];
  List<WasteLocationModel> locList = [];
  void changePage(int index) {
    pageController.jumpToPage(index);
    sideMenuController.changePage(index);
    notifyListeners();
  }

  void sortLocList(List<WasteLocationModel> list) {
    locList = list;
    locList.sort((a, b) => a.locationName!.compareTo(b.locationName!),);

  }

}
