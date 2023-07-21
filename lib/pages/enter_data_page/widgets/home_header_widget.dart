import 'package:copick_data_web/providers/enter_volumes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/get_data_provider.dart';
import '../../../utilitys/colors.dart';
import '../../../utilitys/constants.dart';

class EnterDataHeaderWidget extends StatelessWidget {
  const EnterDataHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GetDataProvider>(context);
    var size = MediaQuery.of(context).size;
    var enter = Provider.of<EnterVolumesProvider>(context);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(NORMALGAP),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: size.width / 2,
                  child: (enter.selectedTeam == "선택 안됨")
                      ? Text(
                          '수거 팀을 선택해주세요.',
                          style: kHeaderTextStyle.copyWith(
                              fontWeight: FontWeight.w500),
                        )
                      : Text.rich(
                          TextSpan(
                            text: "오늘 ",
                            style: kHeaderTextStyle.copyWith(
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: '${enter.selectedTeam}',
                                style: kHeaderTextStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: KColors.black),
                              ),
                              TextSpan(text: '의 수거량 입력할 장소는 '),
                              TextSpan(
                                text: '${enter.taskListTeam.length}${"곳"}',
                                style: kHeaderTextStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: KColors.lightPrimary),
                              ),
                              TextSpan(text: "이 있어요"),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                ), //일정 text
                Text.rich(
                  TextSpan(
                    text: '',
                    // home.doneVolumesLength().toString(),
                    style:
                        kHeaderTextStyle.copyWith(color: KColors.lightPrimary),
                    children: [
                      TextSpan(
                        text: '',
                        // '/${home.volumesList.length}',
                        style: kHeaderTextStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: ((size.width - NORMALGAP * 4) / 3),
                  height: 60,
                  child: DropdownButton(
                    style: kBtnTextStyle.copyWith(color: KColors.black),
                    isExpanded: true,
                    value: enter.selectedTeam,
                    items: enter.teamList.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      enter.changeTeam(value);

                      // dataProvider.changeTeamTask(value, tabIndex);
                    },
                  ),
                ),
              ],
            ),
            // (home.doneVolumesLength() == home.volumesList.length)
            //     ? Column(
            //   children: [
            //     kSmH,
            //     ElevatedButton(
            //         onPressed: () async {
            //           await FbHelper()
            //               .endVolumes(home.seletedTeam)
            //               .then((value) => Navigator.pop(context));
            //         },
            //         style: ElevatedButton.styleFrom(
            //             fixedSize: Size(size.width / 3, 50),
            //             backgroundColor: KColors.lightPrimary,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius:
            //                 BorderRadius.circular(SMALLGAP))),
            //         child: Text('수거량 입력 완료')),
            //   ],
            // )
            //     : SizedBox()
            // kSmH,
          ],
        ),
      ),
    );
  }
}
