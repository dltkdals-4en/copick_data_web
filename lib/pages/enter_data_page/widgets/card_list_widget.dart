import 'package:copick_data_web/models/pick_record_model.dart';
import 'package:copick_data_web/utilitys/constants.dart';
import 'package:flutter/material.dart';

import 'enter_card_widget.dart';
import 'enter_grid_card_widget.dart';

class CardListWidget extends StatelessWidget {
  const CardListWidget(this.list, {Key? key}) : super(key: key);

  final List<PickRecordModel> list;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (list.isEmpty) {
      return Image.asset('assets/images/noData@3x.png');
    } else {
      if (size.width < 1430) {
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return EnterCardWidget(index);
          },
        );
      } else if (size.width < 1800) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: size.width / 4,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            return EnterGridCardWidget(index);
          },
          itemCount: list.length,
        );
      } else {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: size.width / 4,
            childAspectRatio: 1.4,
          ),
          itemBuilder: (context, index) {
            return EnterGridCardWidget(index);
          },
          itemCount: list.length,
        );
      }
    }
  }
}
