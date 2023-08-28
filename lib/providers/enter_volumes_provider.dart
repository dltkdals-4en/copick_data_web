import 'package:flutter/material.dart';

import '../models/pick_record_model.dart';
import '../utilitys/colors.dart';
import '../utilitys/constants.dart';

class EnterVolumesProvider with ChangeNotifier {
  String volumes = '0';
  int openIndex = -1;
  String selectedTeam = '선택 안됨';
  List<String> teamList = ["선택 안됨", "수거 A팀", "수거 B팀", "수거 C팀", "추가 요청"];
  List<PickRecordModel> taskTotal = [];
  List<PickRecordModel> taskListTeam = [];

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
    print('changeIndex');
    openIndex = index;
    notifyListeners();
  }

  void initTeam() {
    selectedTeam = '선택 안됨';

    notifyListeners();
  }

  void init() {
    print('init');
    volumes = '0';
    openIndex = -1;
    print('$volumes // $openIndex');
    notifyListeners();
  }

  String volumesText(double? totalVolume) {
    if (totalVolume == null) {
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
    int? teamNum;
    switch (selectedTeam) {
      case "수거 A팀":
        teamNum = 10;
        break;
      case "수거 B팀":
        teamNum = 20;
        break;
      case "수거 C팀":
        teamNum = 30;
        break;
      case "추가 요청":
        teamNum = 40;
        break;
      default:
        teamNum = 0;
        break;
    }
    if (selectedTeam.startsWith("수거")) {
      taskListTeam =
          taskTotal.where((element) => element.team == teamNum).toList();
    } else if (selectedTeam == "추가 요청") {
      taskListTeam = taskTotal.where((element) => element.team == 40).toList();
    } else {
      taskListTeam = taskTotal;
    }
    taskListTeam.sort(
      (a, b) => a.totalVolume!.compareTo(b.totalVolume!),
    );
  }

  String getBtnText(int index) {
    if (index == openIndex) {
      return '수거량 저장하기';
    } else if (index != openIndex && taskListTeam[index].totalVolume != null) {
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

  Color getBtnColor(int index) {
    if (index == openIndex) {
      return KColors.lightPrimary;
    } else if (index != openIndex && taskListTeam[index].totalVolume != null) {
      return KColors.orange;
    } else {
      return KColors.lightPrimary;
    }
  }

  int doneVolumesLength() {
    return taskListTeam.where((element) => element.totalVolume != 0).length;
  }
}
