import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copick_data_web/models/pick_task_model.dart';
import 'package:copick_data_web/providers/http_helper.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';

import '../models/card_data_model.dart';
import '../models/gathering_place_model.dart';
import '../models/pick_record_model.dart';
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
  List<PickRecordModel> pickTaskList = [];
  List<WasteLocationModel> wasteLocationList = [];
  List<CardDataModel> cardDataList = [];
  List<GatheringPlaceModel> gatheringList = [];
  List<WasteLocationModel> locList = [];
  List<PickRecordModel> recordList = [];
  List<PickTaskModel> taskList = [];
  bool hasLocData = false;
  bool hasRecordData = false;
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

  Future<void> getRecordList() async {
    if (hasRecordData == false) {
      print('getRecord');
      QuerySnapshot<Map<String, dynamic>> data =
          await FbHelper().getRecordData();
      recordList.clear();
      for (var element in data.docs) {
        recordList.add(PickRecordModel.fromJson(element.data(), element.id));
      }
      print(recordList.length);
      hasRecordData = true;
      notifyListeners();
    }
  }

  Future<void> getTaskList() async {
    if (hasTaskData == false) {
      print('getTask');
      QuerySnapshot<Map<String, dynamic>> data =
          await FbHelper().getTaskData(null);
      taskList.clear();
      for (var element in data.docs) {
        var locationName = locList
            .firstWhere((e) => e.locationId == element.data()['location_id'])
            .locationName;
        taskList.add(
            PickTaskModel.fromJson(element.data(), element.id, locationName));
      }
      print(taskList.length);
      hasTaskData = true;
      notifyListeners();
    }
  }

  init() {
    hasRecordData = false;
    hasLocData = false;
    notifyListeners();
  }

  Future<void> updateVolumes(PickRecordModel card, String volumes) async {
    var totalVolumes = double.parse(volumes);

    await FbHelper().updateVolumes(card, totalVolumes).then((value) async {
      await HttpHelper().addWasteInfo(card, volumes).then((value) {
        notifyListeners();
      });
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

  List<PickRecordModel> getTaskTeamList() {
    return recordList.where((element) => element.condition == 1).toList();
  }
}
