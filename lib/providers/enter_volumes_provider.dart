import 'package:flutter/material.dart';

import '../models/pick_task_model.dart';
import '../utilitys/colors.dart';
import '../utilitys/constants.dart';

class EnterVolumesProvider with ChangeNotifier {
  String volumes = '0';
  int openIndex = -1;
  String selectedTeam = '선택 안됨';
  List<String> teamList = ["선택 안됨", "수거 A팀", "수거 B팀", "수거 C팀"];
  List<PickTaskModel> taskTotal = [];
  List<PickTaskModel> taskListTeam = [];

  String formatDate(String date) {
    return '';
  }

  void addVolumes(double d) {
    // volumes = volumes+d;
    // notifyListeners();
  }

  void changeVolumes(String value) {
    volumes = value;
    notifyListeners();
  }

  void changeOpenIndex(int index) {
    openIndex = index;
    notifyListeners();
  }

  void init() {
    print('init');
    volumes = '0';
    openIndex = -1;
    notifyListeners();
  }

  String volumesText(double? totalVolume) {
    if (totalVolume == 0 || totalVolume == null) {
      return '입력 안됨';
    } else {
      return '${totalVolume.toStringAsFixed(2)}Kg';
    }
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
              fontSize: 30,
              color: (main != null) ? main : KColors.black,
            ),
          ),
          Text(
            '$point',
            style: kLabelTextStyle.copyWith(
                fontSize: 28, color: (sub != null) ? sub : KColors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    } else {
      return Text(
        locationName,
        style: kContentTextStyle.copyWith(fontSize: 30),
      );
    }
  }

  void changeTeam(Object? value) {
    var team = value.toString();
    selectedTeam = team;
    notifyListeners();
  }

  void getTaskListWithTeam() {
    if (selectedTeam.startsWith("수거")) {
      var teamNum = selectedTeam.substring(3, selectedTeam.length - 1);
      taskListTeam =
          taskTotal.where((element) => element.team == teamNum).toList();
    } else {
      taskListTeam = taskTotal;
    }
  }

  String getBtnText(int index) {
    if (index == openIndex) {
      return '수거량 저장하기';
    } else if (index != openIndex && taskListTeam[index].totalVolume != 0) {
      return '수거량 변경하기';
    } else {
      return '수거량 입력하기';
    }
  }

  void btnAction(int index) {
    if (index == openIndex) {
    } else if (index != openIndex && taskListTeam[index].totalVolume != 0) {
    } else {
      if (selectedTeam == "선택 안됨") {
        print('no choice');
      } else {
        changeOpenIndex(index);
      }
    }
  }

  void saveVolumes(int index) {
    taskListTeam[index].totalVolume = double.parse(volumes);
    notifyListeners();
  }
}
