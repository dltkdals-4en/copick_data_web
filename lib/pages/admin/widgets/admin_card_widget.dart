import 'package:copick_data_web/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilitys/colors.dart';
import '../../../utilitys/constants.dart';

class AdminCardWidget extends StatelessWidget {
  const AdminCardWidget(this.index,{Key? key}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    var admin = Provider.of<AdminProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: (size.width - 120) / 3 - 40,
          child: Text(
            admin.manageTitleList[index],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              admin.manageTitleList[index],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: KColors.lightPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SMALLGAP),
              ),
              textStyle: kBtnTextStyle.copyWith(fontSize: 18),
              minimumSize: Size(60, 30),
            ),
          ),
        ),
      ],
    );
  }
}
