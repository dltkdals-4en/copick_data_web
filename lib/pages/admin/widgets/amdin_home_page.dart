import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../../utilitys/colors.dart';
import '../../../utilitys/constants.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: KColors.white,
          child: Padding(
            padding: const EdgeInsets.all(NORMALGAP),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '원하시는 작업을 선택해 주세요.',
                    style: kContentTextStyle,
                  ),
                  kBigH,
                  SizedBox(
                    width: 460,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.location);
                      },
                      child: Text(
                        '수거 카페 관리',
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
                  kNorH,
                  SizedBox(
                    width: 460,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        '수거 경로 관리',
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
                  kNorH,
                  SizedBox(
                    width: 460,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        '수거 기록 관리',
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
              ),
            ),
          )

        // GridView.builder(
        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     childAspectRatio: 1,
        //     maxCrossAxisExtent: size.width / 3,
        //     mainAxisSpacing: NORMALGAP,
        //     crossAxisSpacing: NORMALGAP,
        //   ),
        //   itemCount: admin.manageTitleList.length,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(NORMALGAP),
        //         color: KColors.white,
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(NORMALGAP),
        //         child: AdminCardWidget(index)
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
