import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'constants.dart';

const AppBarTheme kAppbarTheme = AppBarTheme(
  backgroundColor: KColors.white,
  centerTitle: true,
  titleTextStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: KColors.black,
  ),
  systemOverlayStyle: SystemUiOverlayStyle(
    systemNavigationBarColor: KColors.black,
  ),
);
CardTheme kCardTheme = CardTheme(
  color: KColors.white,
  elevation: 4,
  margin: const EdgeInsets.fromLTRB(NORMALGAP, 0, NORMALGAP, NORMALGAP),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(NORMALGAP),
  ),
);
