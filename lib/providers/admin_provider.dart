import 'dart:js_interop';

import 'package:copick_data_web/models/waste_location_model.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import '../utilitys/colors.dart';
import '../utilitys/constants.dart';

class AdminProvider with ChangeNotifier {
  SideMenuController sideMenuController = SideMenuController();
  PageController pageController = PageController(initialPage: 1);
  List<String> manageTitleList = ['카페 관리하기', '수거 경로 관리하기', '수거 기록 관리하기'];
  List<WasteLocationModel> locTotalList = [];
  List<WasteLocationModel> locList = [];
  bool locSync = false;
  // List<String> locFilter=[''];
  void changePage(int index) {
    pageController.jumpToPage(index);
    sideMenuController.changePage(index);
    notifyListeners();
  }

  void sortLocList() {
    locList.sort(
      (a, b) => a.locationName!.compareTo(b.locationName!),
    );
  }

  Widget setLocName(String locationName, {Color? main, Color? sub}) {
    if (locationName.contains('(')) {
      var i = locationName.split('(');
      String name = i.first;
      String point = i.last.substring(0, i.last.length - 1);
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: kContentTextStyle.copyWith(
              fontSize: 16,
              color: (main != null) ? main : KColors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          kSmW,
          Text(
            '$point',
            style: kLabelTextStyle.copyWith(
                fontSize: 14, color: (sub != null) ? sub : KColors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    } else {
      return Text(
        locationName,
        style: kContentTextStyle.copyWith(fontSize: 16),
      );
    }
  }

  void findLoc(String value) {
    print(value);
    if(value == ''){
      print('null');
      locList = locTotalList;
    }else {
      print('not null');
      locList = locList
          .where((element) => element.locationName!.contains(value))
          .toList();
    }
    print(locList.length);
    notifyListeners();
  }

  void setLocList(List<WasteLocationModel> list) {
    locTotalList = list;
    if (locTotalList.isNotEmpty ) {
      locList = list;
    }

  }
}
