
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


import '../../../utilitys/colors.dart';
import '../../../utilitys/constants.dart';



class LoginEnquiryDialog extends StatelessWidget {
  const LoginEnquiryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.all(NORMALGAP),
      title: Text('enquiry_dialog_title'.tr(), style: kHeaderTextStyle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('enquiry_dialog_text_1'.tr(),
                  style: kContentTextStyle.copyWith(color: KColors.blackGrey)),
              SizedBox(
                height: 5,
              ),
              Text('enquiry_dialog_text_2'.tr(),
                  style: kContentTextStyle.copyWith(color: KColors.blackGrey)),
              SizedBox(
                height: 5,
              ),
              Text('enquiry_dialog_text_3'.tr(),
                  style: kContentTextStyle.copyWith(color: KColors.blackGrey)),
            ],
          ),
          kNorH,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'enquiry_dialog_inquiry'.tr(),
                style:
                    kContentTextStyle.copyWith(fontWeight: FontWeight.w700),
              ),
              kSmH,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: (size.width) / 2 - 48 - 40 - 20,
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          child: Center(
                            child: Image.asset(
                              'assets/images/loginValidatePhone.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'enquiry_dialog_tel'.tr(),
                          style: kContentTextStyle,
                        ),
                      ],
                    ),
                  ),
                  kNorW,
                  Container(
                    color: KColors.darkGrey,
                    width: 1,
                    height: 22,
                  ),
                  kNorW,
                  Container(
                    width: (size.width) / 2 - 48 - 40 - 20,
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          child: Center(
                            child: Image.asset(
                              'assets/images/loginValidateEmail.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'enquiry_dialog_email'.tr(),
                          style: kContentTextStyle,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
