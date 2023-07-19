import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/get_data_provider.dart';
import '../../../utilitys/colors.dart';
import '../../../utilitys/constants.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GetDataProvider>(context);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(NORMALGAP),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text.rich(
                  TextSpan(
                    text: "오늘 수거량 입력할 장소는 ",
                    style: kHeaderTextStyle.copyWith(
                        fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: '${data.taskList.length}${"곳"}',
                        style: kHeaderTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            color: KColors.lightPrimary),
                      ),
                      TextSpan(text: "이 있어요"),
                    ],
                  ),
                ),//일정 text
                Text.rich(
                  TextSpan(
                    text: '',
                    // home.doneVolumesLength().toString(),
                    style: kHeaderTextStyle.copyWith(
                        color: KColors.lightPrimary),
                    children: [
                      TextSpan(
                        text: '',
                        // '/${home.volumesList.length}',
                        style: kHeaderTextStyle,
                      )
                    ],
                  ),
                ), //개수표시
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
