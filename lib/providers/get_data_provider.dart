import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';

import '../models/card_data_model.dart';
import '../models/gathering_place_model.dart';
import '../models/pick_task_model.dart';
import '../models/waste_location_model.dart';
import 'db_helper.dart';
import 'fb_helper.dart';

class GetDataProvider with ChangeNotifier {
  bool haveWasteLocationData = false;
  bool havePickTaskData = false;
  bool haveServerData = false;
  bool haveLocalData = false;
  bool haveCardData = false;
  bool haveGatheringData = false;
  Database? _database;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  List<PickTaskModel> pickTaskList = [];
  List<WasteLocationModel> wasteLocationList = [];
  List<CardDataModel> cardDataList = [];
  List<GatheringPlaceModel> gatheringList = [];
  List<WasteLocationModel> locList = [];
  List<PickTaskModel> taskList = [];
  bool hasLocData = false;
  bool hasTaskData = false;

  // Future<void> locVersionCheck() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? serverVersion;
  //   await FbHelper().getLocVersion().then((value) {
  //     serverVersion = value.docs[0].data()['num'];
  //   }).then((value) async {
  //     var localVersion = await prefs.getString('locVersion');
  //     if (localVersion == null || localVersion != serverVersion) {
  //       await prefs.setString('locVersion', serverVersion!);
  //       getLocList();
  //     }
  //   });
  // }

  Future<void> getLocList() async {
    if (hasLocData == false) {
      print('getLoc()');
      QuerySnapshot<Map<String, dynamic>> data = await FbHelper().getLocData();
      locList.clear();
      for (var element in data.docs) {
        locList.add(WasteLocationModel.fromJson(element.data(), element.id));
      }
      hasLocData = true;
      notifyListeners();
    }
  }

  Future<void> getTaskList() async {
    if (hasTaskData == false) {
      print('getTask()');
      QuerySnapshot<Map<String, dynamic>> data = await FbHelper().getTaskData();
      taskList.clear();
      for (var element in data.docs) {
        taskList.add(PickTaskModel.fromJson(element.data(), element.id));
      }
      print(taskList.length);
      hasTaskData = true;
      notifyListeners();
    }
  }

  Future<void> updateCondition(
      CardDataModel card, String? conditionRadioValue, String team) async {
    var condition = int.parse(conditionRadioValue!);
    final db = await DbHelper().database;
    await db!
        .rawQuery(
            "update pick_task set condition = $condition , pick_up_date = '${card.pickUpDate}' where pick_doc_id = '${card.pickDocId}'")
        .then((value) async {
      await FbHelper()
          .updateTaskConditionData(card, condition)
          .then((value) async {
        await FbHelper()
            .insertRecordData(card.locationId!, condition, card.track!, team)
            .then((value) {
          notifyListeners();
        });
      });
    });
  }

  init() {
    hasTaskData = false;
    hasLocData = false;
    notifyListeners();
  }

  Future<void> updateVolumes(PickTaskModel card, String volumes) async {
    var totalVolumes = double.parse(volumes);

    await FbHelper().updateVolumes(card, totalVolumes).then((value) async {
      notifyListeners();
    });
  }

  Future<void> deleteDB() async {
    await DbHelper().deleteDb();
    haveWasteLocationData = false;
    havePickTaskData = false;
    haveCardData = false;
    haveGatheringData = false;
    notifyListeners();
  }

  List<PickTaskModel> getTaskTeamList() {
    return taskList.where((element) => element.condition == 1).toList();
  }
}
