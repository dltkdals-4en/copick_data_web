import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../models/card_data_model.dart';
import '../models/pick_task_model.dart';

class FbHelper {
  FbHelper._();

  static final FbHelper _fb = FbHelper._();

  factory FbHelper() => _fb;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  //카페 정보
  Future<QuerySnapshot<Map<String, dynamic>>> getLocData() async {
    return await _firestore.collection('waste_location_anseong').get();
  }

  Future<void> insertLocData() async {}

  Future<void> updateLocData() async {}

  Future<void> deleteLocData() async {}

  //태스크 정보
  Future<QuerySnapshot<Map<String, dynamic>>> getTaskData() async {
    var today = DateTime.now();
    var todayZero = DateFormat('yy-MM-dd').format(today).toString();
    var date = DateFormat('yy-MM-dd hh:mm:ss').parse('$todayZero 00:00:00');
    return await _firestore
        .collection('pick_record_anseong')
        .where('pick_up_date', isGreaterThan: date)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getGathering() async {
    return await _firestore
        .collection('gathering_place')
        .where('location_code', isEqualTo: 'AN')
        .get();
  }

  Future<void> insertTaskData(List<PickTaskModel> list) async {}

  Future<void> updateTaskConditionData(
      CardDataModel card, int condition) async {
    await _firestore
        .collection('pick_task_anseong')
        .doc(card.pickDocId!)
        .update({'condition': condition});
  }

  Future<void> updateVolumes(CardDataModel card, double volumes) async {
    print('fb_update_volumes');
    await _firestore.collection('volume_record_anseong').add({
      'location_id': card.locationId,
      'volumes': volumes,
      'location_name': card.locationName,
      'complete_time': DateTime.now()
    });
  }

  Future<void> deleteTaskData() async {}

  //테스트용 태스크 정보
  Future<QuerySnapshot<Map<String, dynamic>>> getTaskDummyData() async {
    var today = DateTime.now().weekday;

    return await _firestore
        .collection('pick_task_anseong')
        .where('track', isEqualTo: today)
        .get();
  }

  //테스트용 태스크 모두 넣기
  Future<void> insertAllTaskDummyData(List<PickTaskModel> list) async {
    list.forEach((element) async {
      await _firestore.collection('pick_task_anseong').add(element.toMap());
    });
  }

  //수거 기록
  Future<void> insertRecordData(
      String title, int condition, int track, String team) async {
    var teamNum = 99;
    if (team.startsWith("수거")) {
      teamNum = int.parse(team.substring(3, team.length - 1));
    } else {
      teamNum = 0;
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

  Future<void> insertRecordDataAnseong(
      String title, int condition, int track, String team) async {
    if (team.startsWith("수거")) {
      team = team.substring(3, team.length - 1);
    } else {
      team = '전체';
    }

    await _firestore.collection('pick_record_anseong').add({
      'condition': condition,
      'location_id': title,
      'pick_up_date': DateTime.now(),
      'track': track,
      'team': team,
      'user_code': '000',
    });
  }

  Future<void> insertPartnerLoc(CardDataModel card) async {
    await _firestore.collection('partner_location_tracking').add({
      'partner_id': user!.uid,
      'location_id': card.locationId,
      'location_gps_lat': card.locationGpsLat,
      'location_gps_long': card.locationGpsLong,
      'tracking_time': DateTime.now(),
    });
  }

  Future<void> fbSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> endVolumes(String seletedTeam) async {
    await _firestore
        .collection('end_volumes')
        .add({'seletedTeam': seletedTeam, 'complete_time': DateTime.now()});
  }
}
