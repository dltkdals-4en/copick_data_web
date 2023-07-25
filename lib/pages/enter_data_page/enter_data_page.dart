
import 'package:copick_data_web/pages/enter_data_page/widgets/card_list_widget.dart';
import 'package:copick_data_web/pages/enter_data_page/widgets/home_header_widget.dart';
import 'package:copick_data_web/providers/enter_volumes_provider.dart';
import 'package:copick_data_web/providers/get_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilitys/constants.dart';

class EnterDataPage extends StatelessWidget {
  const EnterDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GetDataProvider>(context);
    var size = MediaQuery.of(context).size;
    var enter = Provider.of<EnterVolumesProvider>(context);
    enter.taskTotal = data.getTaskTeamList();
    enter.getTaskListWithTeam();
    var list = enter.taskListTeam;
    print('open Index = ${enter.openIndex}');
    return Scaffold(
      appBar: AppBar(
        title: Text('수거량 입력하기'),
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

