import 'package:copick_data_web/pages/admin/widgets/admin_card_widget.dart';
import 'package:copick_data_web/providers/admin_provider.dart';
import 'package:copick_data_web/utilitys/colors.dart';
import 'package:copick_data_web/utilitys/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var admin = Provider.of<AdminProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(BIGGAP),
        child: Container(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 1,
              maxCrossAxisExtent: size.width / 3,
              mainAxisSpacing: NORMALGAP,
              crossAxisSpacing: NORMALGAP,
            ),
            itemCount: admin.manageTitleList.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(NORMALGAP),
                  color: KColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(NORMALGAP),
                  child: AdminCardWidget(index)
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
