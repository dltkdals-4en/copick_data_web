import 'package:copick_data_web/models/pick_task_model.dart';
import 'package:flutter/material.dart';

import 'home_card_widget.dart';
import 'home_grid_card_widget.dart';

class CardListWidget extends StatelessWidget {
  const CardListWidget(this.list, {Key? key}) : super(key: key);

  final List<PickTaskModel> list;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (size.width < 1400) {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (list.length == 0) {
            return Container(
              child: Center(
                child: Text('수거된 곳이 없어요.'),
              ),
            );
          } else {
            return HomeCardWidget(index);
          }
        },
      );
    } else if (size.width < 1800) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: size.width / 4,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          return HomeGridCardWidget(index);
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
          return HomeGridCardWidget(index);
        },
        itemCount: list.length,
      );
    }
  }
}
