import 'package:copick_data_web/pages/location_manage/widgets/location_card_widget.dart';
import 'package:copick_data_web/providers/admin_provider.dart';
import 'package:copick_data_web/providers/get_data_provider.dart';
import 'package:copick_data_web/utilitys/colors.dart';
import 'package:copick_data_web/utilitys/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationManagePage extends StatelessWidget {
  const LocationManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var admin = Provider.of<AdminProvider>(context);
    admin.sortLocList();

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
          Expanded(
            child: ListView.builder(
              itemCount: admin.locList.length,
              itemBuilder: (context, index) {

                return (admin.locList.length > 0)
                    ? LocationCardWidget(index)
                    : SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
