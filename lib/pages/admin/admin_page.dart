import 'package:copick_data_web/pages/admin/widgets/admin_card_widget.dart';
import 'package:copick_data_web/pages/admin/widgets/amdin_home_page.dart';
import 'package:copick_data_web/pages/location_manage/location_manage_page.dart';
import 'package:copick_data_web/pages/record_manage/record_manage_page.dart';
import 'package:copick_data_web/pages/schedule_manage/schedule_manage_page.dart';
import 'package:copick_data_web/providers/admin_provider.dart';
import 'package:copick_data_web/providers/get_data_provider.dart';
import 'package:copick_data_web/routes/routes.dart';
import 'package:copick_data_web/utilitys/colors.dart';
import 'package:copick_data_web/utilitys/constants.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var admin = Provider.of<AdminProvider>(context);
    var data = Provider.of<GetDataProvider>(context);
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            title: kBigH,
            items: <SideMenuItem>[
              SideMenuItem(
                title: '홈',
                onTap: (index, _) {
                  admin.changePage(index);
                },
                icon: Icon(Icons.home),
                // badgeContent: Text(
                //   '3',
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
              SideMenuItem(
                title: '카페 관리',
                onTap: (index, _) async {
                  admin.changePage(index);
                },
                icon: Icon(Icons.settings),
              ),
              SideMenuItem(
                title: '수거 경로 관리',
                onTap: (index, sideMenuController) {
                  admin.changePage(index);
                },
                icon: Icon(Icons.exit_to_app),
              ),
              SideMenuItem(
                title: '수거 기록 관리',
                onTap: (index, sideMenuController) {
                  admin.changePage(index);
                },
                icon: Icon(Icons.exit_to_app),
              ),
            ],
            controller: admin.sideMenuController,
            style: SideMenuStyle(
                displayMode: SideMenuDisplayMode.auto,
                decoration: BoxDecoration(),
                openSideMenuWidth: 200,
                compactSideMenuWidth: 40,
                hoverColor: KColors.lightPrimary.withOpacity(0.5),
                selectedColor: KColors.lightPrimary,
                selectedIconColor: Colors.white,
                unselectedIconColor: Colors.black54,
                backgroundColor: KColors.whiteGrey,
                selectedTitleTextStyle: TextStyle(color: Colors.white),
                unselectedTitleTextStyle: TextStyle(color: Colors.black54),
                iconSize: 20,
                itemBorderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                showTooltip: true,
                itemHeight: 50.0,
                itemInnerSpacing: 8.0,
                itemOuterPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                toggleColor: Colors.black54),
          ),
          Expanded(
              child: PageView(
            controller: admin.pageController,
            children: [
              AdminHomePage(),
              LocationManagePage(),
              ScheduleManagePage(),
              RecordManagePage(),
            ],
          )),
        ],
      ),
    );
  }
}
