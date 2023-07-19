import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'colors.dart';

enum CardType {
  EMPTY,
  TASK,
  MAP,
  DONE,
}

enum UseCase {
  EMPTY,
  SUCCESS,
  FAIL,
  FAILEMPTY,
}

const TextStyle kAppbarTitle =
    TextStyle(fontWeight: FontWeight.w700, fontSize: 32, color: KColors.black);
const TextStyle kHeaderTextStyle =
    TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: KColors.black);
const TextStyle kLabelTextStyle =
    TextStyle(fontWeight: FontWeight.w700, fontSize: 26, color: KColors.black);
const TextStyle kContentTextStyle =
    TextStyle(fontWeight: FontWeight.w900, fontSize: 28, color: KColors.black);
const TextStyle kBtnTextStyle =
TextStyle(fontWeight: FontWeight.w700, fontSize: 28, color: KColors.white);
const TextStyle kTagTextStyle =
TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: KColors.white);


const SizedBox kBigH = SizedBox(
  height: 30,
);
const SizedBox kBigW = SizedBox(
  width: 30,
);
const SizedBox kNorH = SizedBox(
  height: 20,
);
const SizedBox kNorW = SizedBox(
  width: 20,
);
const SizedBox kSmH = SizedBox(
  height: 10,
);
const SizedBox kSmW = SizedBox(
  width: 10,
);

const mainPadding = EdgeInsets.fromLTRB(20, 20, 20, 20);

const double CARDHEIGHT = 140;

const double BIGGAP = 40;
const double NORMALGAP = 20;
const double SMALLGAP = 10;

const double BUTTONHEIGHT = 100;
const double BIGRADIUS = 15;
const double SMALLRADIUS = 8;
