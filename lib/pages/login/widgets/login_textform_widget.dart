import 'package:copick_data_web/providers/login_provider.dart';
import 'package:copick_data_web/utilitys/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilitys/colors.dart';

class LoginTextformWidget extends StatelessWidget {
  const LoginTextformWidget(
      {this.label,
      this.borderColor,
      this.prefixIcon,
      this.pwObscure,
      this.keyboardType,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.borderRadius,
      this.iconColor,
        this.onSubmitted,
      Key? key})
      : super(key: key);

  final String? label;
  final Color? borderColor;
  final IconData? prefixIcon;
  final bool? pwObscure;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final ValueChanged? onChanged;
  final FormFieldSetter? onSaved;
  final BorderRadius? borderRadius;
  final Color? iconColor;
  final ValueChanged? onSubmitted;


  @override
  Widget build(BuildContext context) {
    var login = Provider.of<LoginProvider>(context);
    return TextFormField(
      textInputAction: TextInputAction.go,
      onFieldSubmitted: onSubmitted,
      cursorColor: KColors.lightPrimary,
      keyboardType: (keyboardType != null) ? keyboardType : null,
      obscuringCharacter: '*',
      obscureText: (pwObscure == true) ? login.pwObscure : false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: KColors.lightGrey,
            width: 1,
          ),
          borderRadius: (borderRadius != null)
              ? borderRadius!
              : BorderRadius.circular(SMALLGAP),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: (borderColor != null) ? borderColor! : KColors.lightPrimary,
            width: 2,
          ),
          borderRadius: (borderRadius != null)
              ? borderRadius!
              : BorderRadius.circular(SMALLGAP),
        ),
        // hoverColor: KColors.primary,
        focusColor: KColors.lightPrimary,
        filled: true,
        fillColor: KColors.white,
        hintText: label,
        floatingLabelStyle: TextStyle(color: KColors.lightPrimary),
        prefixIcon: (prefixIcon != null)
            ? Icon(
                prefixIcon,
                color:
                    (iconColor != null) ? iconColor! : KColors.grey,
              )
            : null,
        // prefixIconColor: (borderColor != null)?borderColor! : KColors.lightPrimary,
        suffixIcon: (pwObscure == true)
            ? IconButton(
                onPressed: () {
                  login.changePwObscure();
                },
                icon: const Icon(
                  Icons.remove_red_eye_rounded,
                  color: KColors.lightPrimary,
                ),
              )
            : null,
      ),
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }
}
