import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CardDataModel {
  String? pickDocId;
  int? pickOrder;
  String? userName;
  String? locationName;
  String? taskAllocateTime;
  String? locationPostal;
  String? locationTel;
  String? locationAddress;
  double? locationGpsLat;
  double? locationGpsLong;
  String? locationId;
  String? pickDetails;
  double? totalVolume;
  int? failCode;
  String? failReason;
  String? pickUpDate;
  int? condition;
  int? track;
  String? team;

  CardDataModel({
    this.pickDocId,
    this.pickOrder,
    this.userName,
    this.locationName,
    this.taskAllocateTime,
    // this.pickUpDate,
    this.locationId,
    this.totalVolume,
    this.pickDetails,
    this.failReason,
    this.failCode,
    this.pickUpDate,
    this.locationPostal,
    this.condition,
    this.track,
    this.locationTel,
    this.locationAddress,
    this.locationGpsLat,
    this.locationGpsLong,
    this.team,
  });

  Map<String, dynamic> toMap() {
    return {
      'pick_doc_id': this.pickDocId,
      'pick_order': this.pickOrder,
      'location_id': this.locationId,
      'pick_total_waste': this.totalVolume,
      'pick_details': this.pickDetails,
      'task_allocate_time': this.taskAllocateTime,
      'pick_up_date': this.pickUpDate,
      'pick_fail_code': this.failCode,
      'pick_fail_reason': this.failReason,
      'location_postal': this.locationPostal,
      'condition': this.condition,
      'track': this.track,
      'location_address': this.locationAddress,
      'location_gps_lat': this.locationGpsLat,
      'location_gps_long': this.locationGpsLong,
      'team': this.team,
    };
  }

  CardDataModel.fromSql(Map<String, dynamic> json) {
    pickDocId = json['pick_doc_id'];
    pickOrder = json['pick_order'];
    userName = json['allocated_user_id'];
    locationName = json['location_name'];
    taskAllocateTime = dateFormat(
        json['task_allocate_time'] ?? Timestamp.fromDate(DateTime.now()));
    pickUpDate = json['pick_up_date'];
    locationId = json['location_id'];
    pickDetails = json['pick_details'];
    totalVolume = (json['pick_total_waste'] != null)
        ? double.parse(json['pick_total_waste'].toString())
        : 0;
    failCode = json['pick_fail_code'];
    failReason = json['pick_fail_reason'];
    track = json['track'];
    condition = json['condition'];
    locationPostal = json['location_postal'];
    locationAddress = json['location_address'];
    locationGpsLat = json['location_gps_lat'];
    locationGpsLong = json['location_gps_long'];
    locationTel = json['location_tel'];
    team = json['team'];
  }
}

String dateFormat(Timestamp timestamp) {
  var date =
      DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch)
          .toString();
  var stringToDate = DateFormat('yy-MM-dd HH:mm').parse(date);
  var format = DateFormat('yy/MM/dd HH:mm');
  return format.format(stringToDate);
}
