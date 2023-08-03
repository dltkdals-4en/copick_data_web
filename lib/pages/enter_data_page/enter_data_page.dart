import 'package:copick_data_web/pages/enter_data_page/widgets/card_list_widget.dart';
import 'package:copick_data_web/pages/enter_data_page/widgets/enter_header_widget.dart';
import 'package:copick_data_web/pages/login/widgets/login_textform_widget.dart';
import 'package:copick_data_web/providers/enter_volumes_provider.dart';
import 'package:copick_data_web/providers/get_data_provider.dart';
import 'package:copick_data_web/providers/login_provider.dart';
import 'package:copick_data_web/utilitys/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routes.dart';
import '../../utilitys/constants.dart';

class EnterDataPage extends StatelessWidget {
  const EnterDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GetDataProvider>(context);
    var size = MediaQuery.of(context).size;
    var enter = Provider.of<EnterVolumesProvider>(context);
    var login = Provider.of<LoginProvider>(context);
    enter.taskTotal = data.getTaskTeamList();
    enter.getTaskListWithTeam();
    var list = enter.taskListTeam;

    return Scaffold(
      appBar: AppBar(
        title: Text('수거량 입력하기'),
        actions: [
          IconButton(
            onPressed: () async {
              // final SharedPreferences prefs =await SharedPreferences.getInstance();
              // var i = prefs.getStringList('admin');
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("관리자 비밀번호를 입력해주세요."),
                        kSmH,
                        SizedBox(
                          height: 40,
                          child: TextField(
                            textInputAction: TextInputAction.go,
                            obscureText: true,
                            onChanged: (value) => login.savePw(value),
                            onSubmitted: (value) async {
                              await login.tryLogin().then((value) {
                                if (login.loginSuccess) {
                                  Navigator.pushNamed(context, Routes.admin);
                                } else {}
                              });
                            },
                          ),
                          // LoginTextformWidget(
                          //   onChanged: (value) => login.savePw(value),
                          //   onSubmitted: (value) async {
                          //     await login.tryLogin().then((value) {
                          //       if (login.loginSuccess) {
                          //         Navigator.pushNamed(context, Routes.admin);
                          //       } else {}
                          //     });
                          //   },
                          // ),
                        ),
                        kSmH,
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              await login.tryLogin().then((value) {
                                if (login.loginSuccess) {
                                  Navigator.pushNamed(context, Routes.admin);
                                } else {}
                              });
                            },
                            child: Text('로그인'),
                            style: ElevatedButton.styleFrom(
                              textStyle: kBtnTextStyle.copyWith(fontSize: 18),
                              backgroundColor: KColors.lightPrimary,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(SMALLGAP),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.account_circle,
            ),
            color: KColors.grey,
            iconSize: 30,
          )
        ],
      ),
      body: Column(
        children: [
          EnterDataHeaderWidget(),
          kBigH,
          Expanded(
            child: CardListWidget(list),
          )
        ],
      ),
    );
  }
}
