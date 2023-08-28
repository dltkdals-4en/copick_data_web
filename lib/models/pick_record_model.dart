import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PickRecordModel {
  String? recordDocId;
  int? pickOrder;
  String? locationId;
  String? locationName;
  int? condition;
  int? track;
  int? team;

  double? totalVolume;

  // String? pickDetails;
  // String? failReason;
  String? pickUpDate;

  PickRecordModel({
    this.recordDocId,
    this.pickOrder,
    this.locationId,
    this.locationName,
    this.condition,
    this.track,
    this.team,
    this.pickUpDate,
    // this.failReason,
    this.totalVolume,
    // this.pickDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'pick_doc_id': this.recordDocId,
      'pick_order': this.pickOrder,
      'track': this.track,
      'condition': this.condition,
      'location_id': this.locationId,
      'location_name' : this.locationName,
      'team': this.team,
      'pick_total_waste': this.totalVolume,
      // 'pick_details': this.pickDetails,
      // 'fail_reason': this.failReason,

      'pick_up_date': this.pickUpDate,
    };
  }

  PickRecordModel.fromJson(Map<String, dynamic> json, id) {
    recordDocId = id;
    pickOrder = json['pick_order'];
    track = json['track'];
    condition = json['condition'];
    locationId = json['location_id'];
    locationName= json['location_name'];
    team = json['team'];
    pickUpDate = (json['pick_up_date'] != null)?dateFormat(json['pick_up_date']):dateFormat(Timestamp.fromDate(DateTime.now()));
    // pickDetails = json['pick_details'].toString();
    totalVolume = (json['pick_total_waste'] != null)
        ? double.parse(json['pick_total_waste'].toString())
        : 0;

    // failReason = json['pick_fail_reason'];
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
