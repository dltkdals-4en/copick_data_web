import 'package:copick_data_web/providers/fb_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController? idController;
  TextEditingController? pwController;
  bool pwObscure = true;
  String id = '';
  String pw = '';
  bool autoLogin = false;
  bool loginSuccess = false;

  void changePwObscure() {
    (pwObscure) ? pwObscure = false : pwObscure = true;
    notifyListeners();
  }

  void changAutoLogin(bool? value) {
    autoLogin = value!;
    notifyListeners();
  }

  Future<void> tryLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (autoLogin) {
      await prefs.setStringList('admin', [id, pw]);
    }
    loginSuccess = await FbHelper().tryLogin(id, pw);
    notifyListeners();
  }

  saveId(String value) {
    id = value;
    notifyListeners();
  }

  savePw(String value) {
    pw = value;
    notifyListeners();
  }
}
