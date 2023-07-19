import 'package:copick_data_web/models/pick_task_model.dart';
import 'package:flutter/material.dart';

import '../../../utilitys/constants.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget(this.list, {Key? key}) : super(key: key);

  final PickTaskModel list;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardWidth = size.width - (NORMALGAP * 2);
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
                        //   card.locationId!,
                        //   style: kLabelTextStyle.copyWith(),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        home.setLocName(card.locationName!,sub: KColors.darkGrey),
                        // Text(
                        //   '수거 완료 시간 : $date',
                        //   style: kLabelTextStyle,
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
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
                      ? EnterVolumesInsertBtn(index)
                      : ElevatedButton(
                    onPressed: () {
                      enter.changeOpenIndex(index);
                      enter.changeVolumes(card.totalVolume.toString());
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(cardWidth / 3, 80),
                        backgroundColor: KColors.lightPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(SMALLGAP))),
                    child: Text(
                      '수거량 변경',
                      style: kBtnTextStyle.copyWith(
                        fontSize: 22,
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
                        decoration: InputDecoration(
                          hintText: enter.volumes,
                          fillColor: KColors.whiteGrey,
                          filled: true,
                        ),
                        style: kContentTextStyle,
                        textAlign: TextAlign.end,
                        onChanged: (value) {
                          enter.changeVolumes(value);
                          home.sortVolumesList();
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
                    if (enter.volumes == '' ||
                        enter.volumes == null ||
                        enter.volumes == '0') {
                      makeFToast(context, '수거량을 입력해주세요.');
                    } else {
                      print(enter.volumes);
                      await data.updateVolumes(
                          card, enter.volumes);
                      home.saveVolumes(card, enter.volumes);
                      enter.init();

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
}
