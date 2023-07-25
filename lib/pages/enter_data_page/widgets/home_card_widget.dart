import 'package:copick_data_web/providers/enter_volumes_provider.dart';
import 'package:copick_data_web/providers/get_data_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utilitys/colors.dart';
import '../../../utilitys/constants.dart';
import 'data_insert_btn.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var enter = Provider.of<EnterVolumesProvider>(context);
    var data = Provider.of<GetDataProvider>(context);
    var cardWidth = (size.width < 1600)?size.width - (NORMALGAP * 2):(size.width - (NORMALGAP * 2))/4;
    var card = enter.taskListTeam[index];
    var date = DateFormat('a h시 mm분').format(DateFormat('yy/MM/dd hh:mm').parse(card.pickUpDate!));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: Column(
          children: [
            Container(
              height: CARDHEIGHT,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: cardWidth / 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   card.team!,
                        //   style: kLabelTextStyle.copyWith(),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        enter.setLocName(card.locationName!,
                            sub: KColors.darkGrey),
                        Text(
                          '수거 완료 시간 : $date',
                          style: kLabelTextStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '수거량: ${enter.volumesText(card.totalVolume)}',
                          style: kLabelTextStyle,
                        )
                      ],
                    ),
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
                      : (card.totalVolume == null || card.totalVolume == 0)
                          ? DataInsertBtn(index)
                          : ElevatedButton(
                              onPressed: () {
                                enter.changeOpenIndex(index);
                                enter
                                    .changeVolumes(card.totalVolume.toString());
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(cardWidth / 3, 80),
                                  backgroundColor: KColors.orange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(SMALLGAP))),
                              child: Text(
                                '수거량 변경',
                                style: kBtnTextStyle.copyWith(

                                  color: KColors.white,
                                ),
                              ),
                            ),
                  // StepBtnWidget(card),
                ],
              ),
            ),
            (enter.openIndex != index)
                ? SizedBox()
                : Column(
                    children: [
                      kBigH,
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'))
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
                            style: kBtnTextStyle.copyWith(color: KColors.black),
                          ),
                        ],
                      ),
                      kNorH,
                      ElevatedButton(
                        onPressed: () async {
                          if ( enter.openIndex == index) {
                            await data.updateVolumes(card, enter.volumes);
                            enter.saveVolumes(index);
                            enter.init();
                          } else if (index != enter.openIndex &&
                              enter.taskListTeam[index].totalVolume != 0) {
                            //수거량 변경하기
                          } else{
                            if (enter.selectedTeam != "선택 안됨") {
                              print('btn change');
                              enter.changeOpenIndex(index);
                            } else {
                              print(size.width);
                              print(size.height);
                              // showDialog(
                              //  context: context,
                              //  builder: (context) => AlertDialog(
                              //    contentPadding: EdgeInsets.all(NORMALGAP),
                              //    content: Text(
                              //      '수거 팀을 선택해주세요',
                              //      style: kContentTextStyle.copyWith(),
                              //    ),
                              //
                              //  ),
                              //
                              // );
                            }
                          }


                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(cardWidth, 70),
                          backgroundColor: KColors.lightPrimary,
                        ),
                        child: Text(
                          '수거량 저장하기',
                          style: kBtnTextStyle.copyWith(),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void makeFToast(BuildContext context, String s) {}
}
