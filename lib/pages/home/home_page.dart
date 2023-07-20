import 'package:copick_data_web/pages/home/widgets/card_list_widget.dart';
import 'package:copick_data_web/pages/home/widgets/home_card_widget.dart';
import 'package:copick_data_web/pages/home/widgets/home_grid_card_widget.dart';
import 'package:copick_data_web/pages/home/widgets/home_header_widget.dart';
import 'package:copick_data_web/providers/enter_volumes_provider.dart';
import 'package:copick_data_web/providers/get_data_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/fb_helper.dart';
import '../../utilitys/colors.dart';
import '../../utilitys/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GetDataProvider>(context);
    var size = MediaQuery.of(context).size;
    var enter = Provider.of<EnterVolumesProvider>(context);
    enter.taskTotal = data.getTaskTeamList();
    enter.getTaskListWithTeam();
    var list = enter.taskListTeam;
    return Scaffold(
      appBar: AppBar(
        title: Text('수거량 입력하기'),
      ),
      body: Column(
        children: [
          HomeHeaderWidget(),
          kBigH,
          Expanded(
            child: CardListWidget(list),
          )
        ],
      ),
    );
  }
}

