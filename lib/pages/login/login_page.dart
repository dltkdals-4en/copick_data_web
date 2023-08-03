import 'package:copick_data_web/pages/login/widgets/login_enquiry_dialog.dart';
import 'package:copick_data_web/pages/login/widgets/login_textform_widget.dart';
import 'package:copick_data_web/providers/login_provider.dart';
import 'package:copick_data_web/routes/routes.dart';
import 'package:copick_data_web/utilitys/colors.dart';
import 'package:copick_data_web/utilitys/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var login = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: KColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 230,
              child: Image.asset('assets/images/copick_GRBL.png'),
            ),
            kBigH,
            Container(
              width: 460,
              decoration: BoxDecoration(
                border: Border.all(color: KColors.grey, width: 1),
                borderRadius: BorderRadius.circular(SMALLGAP),
                color: KColors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(BIGGAP),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoginTextformWidget(
                      label: '아이디',
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(SMALLGAP),
                        topRight: Radius.circular(SMALLGAP),
                      ),
                      onChanged: (value) => login.saveId(value),
                      validator: (value) {},
                      prefixIcon: Icons.person_outline,
                    ),
                    LoginTextformWidget(
                      label: '비밀번호',
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(SMALLGAP),
                        bottomRight: Radius.circular(SMALLGAP),
                      ),
                      prefixIcon: Icons.lock_outline,
                      onChanged: (value) => login.savePw(value),
                      validator: (value) {},
                      pwObscure: true,
                    ),
                    kSmH,
                    Row(
                      children: [
                        Checkbox(
                          value: login.autoLogin,
                          onChanged: (value) {
                            login.changAutoLogin(value);
                          },
                          activeColor: KColors.lightPrimary,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("로그인 상태 유지"),
                      ],
                    ),
                    kBigH,
                    ElevatedButton(
                      onPressed: () async {
                        await login.tryLogin().then((value) {
                          if (login.loginSuccess) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.admin, (route) => false);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return LoginEnquiryDialog();
                              },
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        backgroundColor: KColors.lightPrimary,
                        fixedSize: Size(size.width, 50),
                        textStyle: kBtnTextStyle.copyWith(fontSize: 18),
                      ),
                      child: Text('로그인'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
