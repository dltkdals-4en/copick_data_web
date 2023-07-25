import 'package:copick_data_web/providers/enter_volumes_provider.dart';
import 'package:copick_data_web/providers/get_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utilitys/colors.dart';
import '../../../utilitys/constants.dart';
import 'data_insert_btn.dart';

class HomeGridCardWidget extends StatelessWidget {
  const HomeGridCardWidget(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var enter = Provider.of<EnterVolumesProvider>(context);
    var data = Provider.of<GetDataProvider>(context);
    var cardWidth = (size.width < 1600)
        ? size.width - (NORMALGAP * 2)
        : (size.width - (NORMALGAP * 2)) / 4;
    var card = enter.taskListTeam[index];

    var date = DateFormat('a h시 mm분').format(DateFormat('yy/MM/dd hh:mm').parse(card.pickUpDate!));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   card.team!,
                    //   style: kLabelTextStyle.copyWith(),
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    enter.setLocName(card.locationName!, sub: KColors.darkGrey),
                    Text(
                      '수거 시간 : $date',
                      style: kLabelTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                (enter.openIndex == index)
                    ? IconButton(
                        onPressed: () {
                          enter.changeOpenIndex(-1);
                        },
                        icon: Icon(
                          Icons.clear,
                          size: 50,
                          color: KColors.black,
                        ),
                        padding: EdgeInsets.zero,
                      )
                    : SizedBox()
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '수거량:',
                      style: kLabelTextStyle,
                    ),
                    kNorW,
                    (enter.openIndex != index)
                        ? Text(
                            '${enter.volumesText(card.totalVolume)}',
                            style: kLabelTextStyle,
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: size.width / 10 - 20,
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^[0-9]+.?[0-9]*'))
                                  ],
                                  decoration: InputDecoration(
                                    hintText: enter.volumes,
                                    fillColor: KColors.whiteGrey,
                                    filled: true,
                                  ),
                                  style: kContentTextStyle,
                                  textAlign: TextAlign.end,
                                  onChanged: (value) {
                                    enter.changeVolumes(value);
                                    // home.sortVolumesList();
                                  },
                                ),
                              ),
                              kSmW,
                              Text(
                                'Kg',
                                style: kBtnTextStyle.copyWith(
                                    color: KColors.black),
                              ),
                            ],
                          ),
                  ],
                ),
                kNorH,
                // (card.totalVolume == null || card.totalVolume == 0)
                //     ?
                DataInsertBtn(index)
                    // : ElevatedButton(
                    //     onPressed: () {
                    //       enter.changeOpenIndex(index);
                    //       enter.changeVolumes(card.totalVolume.toString());
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       fixedSize: Size(cardWidth, 80),
                    //       backgroundColor: KColors.lightPrimary,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(SMALLGAP),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       '수거량 변경하기',
                    //       style: kBtnTextStyle.copyWith(),
                    //     ),
                    //   ),
              ],
            )

            // (enter.openIndex != index)
            //     ? SizedBox()
            //     : Column(
            //         children: [
            //           kBigH,
            //           Row(
            //             children: [
            //               Expanded(
            //                 child: TextField(
            //                   keyboardType: TextInputType.numberWithOptions(
            //                       decimal: true),
            //                   inputFormatters: <TextInputFormatter>[
            //                     FilteringTextInputFormatter.allow(
            //                         RegExp(r'^[0-9]+.?[0-9]*'))
            //                   ],
            //                   decoration: InputDecoration(
            //                     hintText: enter.volumes,
            //                     fillColor: KColors.whiteGrey,
            //                     filled: true,
            //                   ),
            //                   style: kContentTextStyle,
            //                   textAlign: TextAlign.end,
            //                   onChanged: (value) {
            //                     enter.changeVolumes(value);
            //                     // home.sortVolumesList();
            //                   },
            //                 ),
            //               ),
            //               kSmW,
            //               Text(
            //                 'Kg',
            //                 style: kBtnTextStyle.copyWith(color: KColors.black),
            //               ),
            //             ],
            //           ),
            //           kNorH,
            //           ElevatedButton(
            //             onPressed: () async {
            //               if (enter.volumes == '' ||
            //                   enter.volumes == null ||
            //                   enter.volumes == '0') {
            //                 makeFToast(context, '수거량을 입력해주세요.');
            //               } else {
            //                 // print(enter.volumes);
            //                 // await data.updateVolumes(
            //                 //     card, enter.volumes);
            //                 // home.saveVolumes(card, enter.volumes);
            //                 // enter.init();
            //               }
            //             },
            //             style: ElevatedButton.styleFrom(
            //               fixedSize: Size(cardWidth, 70),
            //               backgroundColor: KColors.lightPrimary,
            //             ),
            //             child: Text(
            //               '수거량 저장하기',
            //               style: kBtnTextStyle.copyWith(),
            //             ),
            //           ),
            //         ],
            //       ),
          ],
        ),
      ),
    );
  }
}
