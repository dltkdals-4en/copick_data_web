import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

import '../models/pick_record_model.dart';



class HttpHelper {
  Future<String> checkCafeVersion() async {
    var url = Uri.parse(
        'https://foureniotdata.cafe24.com/anseong/api/chkCafeInfoVer.php?version=1.0.1');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    print(json.decode(response.body));
    var i = json.decode(response.body);
    var j = i['result'];
    print(j['latest_version']);
    return j['latest_version'];
  }

  Future<List<dynamic>> getCafeInfo() async {
    List<dynamic> j = [];
    var url = Uri.parse(
        'https://foureniotdata.cafe24.com/anseong/api/viewCafeInfoMini.php');
    await http.get(url).then((value) {
      var i = json.decode(value.body);


      j = i['result'];
      print(j.length);
      print(j[0]);
    });
    return j;
  }

  Future<void> getRecordInfo() async {
    var url = Uri.parse(
        'https://foureniotdata.cafe24.com/anseong/api/viewCafeInfoWaste.php');
    await http.get(url).then((value) {
      var i = json.decode(value.body);
      var j = i['result'];
      print(i);
      print(j[125]);
      print(j.length);
    });
  }

  Future<void> updateCafeState(String locationId, String state) async {
    var sn = locationId.substring(1, locationId.length);
    var status = 22;
    if (state == '1') {
      status = 21;
    } else if (state == '3') {
      status = 22;
    }
    print('$sn // $status');
    var url = Uri.parse(
        'https://foureniotdata.cafe24.com/anseong/updateStatus.php?sn=$sn&status=$status');
    await http.get(url).then((value) => print('http get'));
  }

  Future<void> addWasteInfo(PickRecordModel card, String volumes) async {
    var sn = card.locationId!.substring(1, card.locationId!.length);
    int cafeCode = int.parse(sn);
    int pickGroup = card.team!;
    double pickWaste = double.parse(volumes);
    int? pickType;
    (card.team! < 40) ? pickType = 0 : pickType = 1;
    String now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    var response = await http.post(
      Uri.parse(
          'https://foureniotdata.cafe24.com/anseong/api/addWasteInfo.php'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'cafeCode': cafeCode,
        'pickGroup': pickGroup,
        'pickWaste': pickWaste,
        'pickType': pickType,
        'dateRegister': now,
      }),
    );
    print(response.body);
  }
}
