import 'package:copick_data_web/utilitys/colors.dart';
import 'package:copick_data_web/utilitys/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/admin_provider.dart';

class LocationCardWidget extends StatelessWidget {
  const LocationCardWidget(this.index, {Key? key}) : super(key: key);

  final index;

  @override
  Widget build(BuildContext context) {
    var admin = Provider.of<AdminProvider>(context);
    var card = admin.locList[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: BoxConstraints(
                minWidth: 80,
              ),
              child: admin.setLocName(card.locationName!),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '수정',
                    style: kContentTextStyle.copyWith(
                        fontSize: 16, color: KColors.lightPrimary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(SMALLGAP),
                      side: BorderSide(color: KColors.lightPrimary, width: 1),
                    ),
                  ),
                ),
                kSmW,
                ElevatedButton(
                  onPressed: () {},
                  child: Text('삭제'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KColors.lightPrimary,
                    textStyle: kContentTextStyle.copyWith(
                        fontSize: 16, color: KColors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(SMALLGAP),
                      side: BorderSide(color: KColors.lightPrimary, width: 1),
                    ),
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
