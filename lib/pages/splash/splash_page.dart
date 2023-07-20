import 'package:copick_data_web/pages/home/home_page.dart';
import 'package:copick_data_web/providers/enter_volumes_provider.dart';
import 'package:copick_data_web/providers/get_data_provider.dart';
import 'package:copick_data_web/utilitys/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GetDataProvider>(context);
    var enter = Provider.of<EnterVolumesProvider>(context);
    if (data.hasLocData == false) {
      data.getLocList();
      return LoadingScreen();
    } else if (data.hasTaskData == false) {
      data.getTaskList();
      return LoadingScreen();
    }  else {

      return HomePage();
    }
    return HomePage();
  }
}
