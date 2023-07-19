import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class WasteLocationModel {
  String? locationId;
  String? locationName;
  String? locationPostal;
  String? locationAddress;
  double? locationGPSLat;
  double? locationGPSLong;
  String? locDocId;
  String? locationTel;
  String? lastCallDate;

  WasteLocationModel({
    this.locationId,
    this.locationName,
    this.locationPostal,
    this.locationAddress,
    this.locationGPSLat,
    this.locationGPSLong,
    this.locationTel,
    this.lastCallDate,
    this.locDocId,
  });

  Map<String, dynamic> toMap() {
    return {
      'location_id': this.locationId,
      'location_name': this.locationName,
      'location_postal': this.locationPostal??"",
      'location_address': this.locationAddress??"",
      'location_gps_lat': this.locationGPSLat,
      'location_gps_long': this.locationGPSLong,
      'location_tel': this.locationTel??"",
      'last_call_date': this.lastCallDate,
      'location_doc_id': this.locDocId,
    };
  }

  WasteLocationModel.fromJson(Map<String, dynamic> json, String docId)
      : locationId = json['location_id'].toString(),
        locationName = json['location_name'],
        locationPostal = json['location_postal'],
        locationAddress = json['location_address'],
        locationGPSLat = json['location_gps_lat'],
        locationGPSLong = json['location_gps_long'],
        locationTel = json['location_tel'],
        lastCallDate = dateFormat(json['last_call_date']),
        locDocId = docId;

// WasteLocationModel.fromSql(Map<String, dynamic> json)
//     : locationId = json['id'],
//       locationName = json['name'],
//       locationPostal = json['postal'],
//       locationAddress = json['address'],
//       locationGPSLat = json['lat'],
//       locationGPSLong = json['long'],
//       locationTel = json['tel'],
//       lastCallDate = json['pick_up_date'],
//       locDocId = json['doc_id'];
}

String dateFormat(Timestamp timestamp) {
  var date =
      DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch)
          .toString();
  var stringToDate = DateFormat('yy-MM-dd HH:mm').parse(date);
  var format = DateFormat('yy/MM/dd HH:mm');
  return format.format(stringToDate);
}
