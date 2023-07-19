import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future<void> getLocList() async {
    if (hasLocData == false) {
      print('getLoc()');
      QuerySnapshot<Map<String, dynamic>> data =
          await _firestore.collection('waste_location_anseong').get();
      locList.clear();
      for (var element in data.docs) {
        locList.add(WasteLocationModel.fromJson(element.data(), element.id));
      }
      hasLocData = true;
      notifyListeners();
    }
  }

  Future<void> getTaskList() async {
    var today = DateTime.now();
    var todayZero = DateFormat('yy-MM-dd').format(today).toString();
    var date = DateFormat('yy-MM-dd hh:mm:ss').parse('$todayZero 00:00:00');

    if (hasTaskData == false) {
      print('getTask()');
      QuerySnapshot<Map<String, dynamic>> data = await _firestore
          .collection('pick_record_anseong')
          .where('pick_up_date', isGreaterThan: date)
          .get();
      taskList.clear();
      for (var element in data.docs) {
        taskList.add(PickTaskModel.fromJson(element.data(), element.id));
      }
      print(taskList.length);
      hasTaskData = true;
      notifyListeners();
    }
  }

  Future<void> getGatheringData() async {
    final db = await DbHelper().database;
    gatheringList.clear();
    if (haveGatheringData == false) {
      await db!
          .rawQuery('delete from gathering_place')
          .then((value) async => await FbHelper().getGathering().then((value) {
                value.docs.forEach((element) {
                  gatheringList.add(
                      GatheringPlaceModel.fromJson(element.data(), element.id));
                });
              }).then((value) async {
                await db
                    .rawQuery('select * from gathering_place')
                    .then((value) {
                  if (value.isEmpty) {
                    gatheringList.forEach((element) {
                      db.insert('gathering_place', element.toMap());
                    });
                  }
                }).then((value) {
                  haveGatheringData = true;
                  notifyListeners();
                });
              }));
    }
  }

  Future<void> getWasteLocationData() async {
    if (haveWasteLocationData == false) {
      await FbHelper().getLocData().then((value) {
        wasteLocationList.clear();
        value.docs.forEach((element) {
          wasteLocationList
              .add(WasteLocationModel.fromJson(element.data(), element.id));
        });
      }).whenComplete(() async {
        print('location: ${wasteLocationList.length}');
        haveWasteLocationData = true;
        notifyListeners();
      });
    }
  }

  Future<void> getPickTaskData() async {
    if (havePickTaskData == false) {
      await FbHelper().getTaskData().then((value) {
        pickTaskList.clear();
        for (var element in value.docs) {
          pickTaskList.add(PickTaskModel.fromJson(element.data(), element.id));
        }
      }).whenComplete(() {
        print('task ${pickTaskList.length}');
        havePickTaskData = true;
        notifyListeners();
      });
    }
  }

  Future<void> getCardData() async {
    if (haveCardData == false) {
      cardDataList.clear();
      pickTaskList.forEach((element) {
        cardDataList.add(CardDataModel(
          locationId: element.locationId,
          locationName: wasteLocationList
              .firstWhere((e) => e.locationId == element.locationId)
              .locationName,
          condition: element.condition,
          pickUpDate: element.pickUpDate,
          pickOrder: element.pickOrder,
          track: element.track,
          team: element.team,
        ));
      });
    }
  }

  Future<void> fbGetTaskData() async {
    await FbHelper().getTaskDummyData().then((value) {
      for (var element in value.docs) {
        pickTaskList.add(PickTaskModel.fromJson(element.data(), element.id));
      }
    });
  }

  Future<void> fbUpdateTask() async {}

  Future<void> fbUpdateAllCondition() async {
    await _firestore.collection('pick_task_anseong').get().then((data) {
      data.docs.forEach((element) async {
        await _firestore
            .collection('pick_task_anseong')
            .doc(element.id)
            .update({'condition': 0});
      });
    });
  }

  Future<void> fbUpdatePickRecord(
      String title, int condition, int track, String team) async {
    var teamNum = '전체';
    if (team.startsWith("수거")) {
      teamNum = team.substring(3, team.length - 1);
    } else {
      teamNum = '전체';
    }
    await _firestore.collection('pick_record_anseong').add({
      'condition': condition,
      'location_id': title,
      'pick_up_date': DateTime.now(),
      'track': track,
      'team': teamNum,
      'user_code': '000',
    });
  }

  Future<void> initAllCondition() async {
    final db = await DbHelper().database;
    await fbUpdateAllCondition().then((value) async {
      await db!.rawQuery('delete from waste_location').then((value) async {
        await db.rawQuery('delete from pick_task').then((value) async {
          await db.rawQuery('delete from gathering_place').then((value) {
            haveWasteLocationData = false;
            havePickTaskData = false;
            haveCardData = false;
            haveGatheringData = false;
            notifyListeners();
          });
        });
      });
    });
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
            .insertRecordDataAnseong(
                card.locationId!, condition, card.track!, team)
            .then((value) {
          notifyListeners();
        });
      });
    });
  }

  Future<void> updateVolumes(CardDataModel card, String volumes) async {
    var totalVolumes = double.parse(volumes);
    final db = await DbHelper().database;
    await db!
        .rawQuery(
            "update pick_task set pick_total_waste = $totalVolumes  where pick_doc_id = '${card.pickDocId}'")
        .then((value) async {
      await FbHelper().updateVolumes(card, totalVolumes).then((value) async {
        notifyListeners();
      });
    });
  }

  Future<void> fbLogout() async {
    await FirebaseAuth.instance.signOut();
    haveWasteLocationData = false;
    havePickTaskData = false;
    haveCardData = false;
    notifyListeners();
  }

  Future<void> updateRecord() async {
    final db = await _database;
  }

  Future<void> volumeEnd() async {
    //await FbHelper().endVolumes();
  }

  Future<void> deleteDB() async {
    await DbHelper().deleteDb();
    haveWasteLocationData = false;
    havePickTaskData = false;
    haveCardData = false;
    haveGatheringData = false;
    notifyListeners();
  }
}