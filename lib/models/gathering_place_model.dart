
class GatheringPlaceModel {
  String? placeName;
  String? locationCode;
  String? placeDocId;
  double? gpsLat;
  double? gpsLong;
  int? type;

  GatheringPlaceModel({
    this.placeName,
    this.locationCode,
    this.placeDocId,
    this.gpsLat,
    this.gpsLong,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'place_name': this.placeName,
      'location_code': this.locationCode,
      'place_doc_id': this.placeDocId,
      'gps_lat': this.gpsLat,
      'gps_long': this.gpsLong,
      'type': this.type,
    };
  }

  GatheringPlaceModel.fromJson(Map<String, dynamic> json, String docId)
      : placeName = json['place_name'],
        locationCode = json['location_code'],
        placeDocId = docId,
        gpsLat = json['gps_lat'],
        gpsLong = json['gps_long'],
        type = json['type'];
}
