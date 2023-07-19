import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {required this.onPressed,
      required this.title,
      this.image,
      this.txtColor,
      this.btnColor,
      this.btnBorder,
      required this.width,
      required this.height,
      Key? key})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final Color? txtColor;
  final Color? btnColor;
  final Color? btnBorder;
  final double width;
  final double height;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (image != null)
              ? Row(
                  children: [
                    Image.asset(
                      'assets/images/$image',
                      color: txtColor,
                      height: 32,
                      width: 20,
                    ),
                    kSmW,
                  ],
                )
              : const SizedBox(),
          Text(
            title,
            style: kBtnTextStyle.copyWith(
              color: (txtColor == null) ? KColors.black : txtColor,
              fontSize: 28,
            ),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: (btnColor == null) ? KColors.white : btnColor,
        elevation: 1,

        side: BorderSide(
          width: 1,
          color: (btnBorder == null) ? (btnColor==null)? KColors.whiteGrey :btnColor! : btnBorder!,
        ),
        minimumSize:  Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SMALLGAP),
        ),
      ),
    );
  }
}
