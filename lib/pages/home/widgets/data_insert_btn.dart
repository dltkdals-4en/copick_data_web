import 'package:copick_data_web/providers/get_data_provider.dart';
import 'package:copick_data_web/utilitys/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/enter_volumes_provider.dart';
import '../../../utilitys/constants.dart';

class DataInsertBtn extends StatelessWidget {
  const DataInsertBtn(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardWidth = size.width - (NORMALGAP * 2);
    var enter = Provider.of<EnterVolumesProvider>(context);
    var data = Provider.of<GetDataProvider>(context);
    var card = enter.taskListTeam[index];
    return Container(
      width: cardWidth / 3,
      height: 80,
      child: ElevatedButton(
        child: Text(enter.getBtnText(index)),
        onPressed: () async {
          if (index == enter.openIndex) {
            await data
                .updateVolumes(card, enter.volumes)
                .then((value) {
                  enter.saveVolumes(index);
              enter.init();
            });
          } else if (index != enter.openIndex &&
              enter.taskListTeam[index].totalVolume != 0) {
          } else {
            if (enter.selectedTeam == "선택 안됨") {
              print('no choice');
            } else {
              enter.changeOpenIndex(index);
            }
          }

          if (enter.selectedTeam != "선택 안됨") {
            enter.changeOpenIndex(index);
          } else {
            print(size.width);
            print(size.height);
            // showDialog(
            //   context: context,
            //   builder: (context) => AlertDialog(
            //     contentPadding: EdgeInsets.all(NORMALGAP),
            //     content: Text(
            //       '수거 팀을 선택해주세요',
            //       style: kContentTextStyle.copyWith(),
            //     ),
            //   ),
            // );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: KColors.lightPrimary,
          textStyle: kBtnTextStyle.copyWith(),
        ),
      ),
    );
  }
}
