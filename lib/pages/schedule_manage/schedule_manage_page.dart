import 'package:copick_data_web/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilitys/colors.dart';
import '../../utilitys/constants.dart';

class ScheduleManagePage extends StatelessWidget {
  const ScheduleManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var admin = Provider.of<AdminProvider>(context);
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: KColors.white,
      ),
      width: size.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(NORMALGAP),
            child: Container(
              child: Text(
                '수거 카페 관리',
                style: kContentTextStyle.copyWith(),
              ),
            ),
          ),
          kBigH,
          Padding(
            padding: const EdgeInsets.all(NORMALGAP),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '전체 카페 개수 : ${admin.locTotalList.length} 개',
                    style: kContentTextStyle.copyWith(fontSize: 20),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                    textInputAction: TextInputAction.go,
                    onFieldSubmitted: (value) {
                      admin.findLoc(value);
                    },
                    // onChanged: (value) {
                    //   admin.findLoc(value);
                    // },
                  ),
                ],
              ),
            ),
          ),
          kNorH,
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: admin.locList.length,
          //     itemBuilder: (context, index) {
          //
          //       return (admin.locList.length > 0)
          //           ? LocationCardWidget(index)
          //           : SizedBox();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
