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
    var data = Provider.of<GetDataProvider>(context);
    var admin = Provider.of<AdminProvider>(context);
    admin.sortLocList(data.locList);
    var list = admin.locList;
    return Container(
      color: KColors.white,
      child: Padding(
        padding: const EdgeInsets.all(NORMALGAP),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                '수거 카페 관리',
                style: kContentTextStyle.copyWith(),
              ),
            ),
            kNorH,
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Text('${list[index].locationName}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
