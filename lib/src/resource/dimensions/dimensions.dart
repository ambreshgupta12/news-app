import 'package:flutter/cupertino.dart';

class Dimensions {
  static const double _constHeight = 896;
  static const double _constWidth = 414;

  static late double boxWidth;
  static late double boxHeight;
  static late double propHeight;
  static late double propWidth;

  Dimensions(BuildContext context) {
    boxHeight = MediaQuery.of(context).size.height / 100;
    boxWidth = MediaQuery.of(context).size.width / 100;
    propHeight = MediaQuery.of(context).size.height / _constHeight;
    propWidth = MediaQuery.of(context).size.width / _constWidth;
  }
}

class Dimens {
  Dimens._();

  //for all screens
  static const double horizontal_padding = 16.0;
  static const double vertical_padding = 16.0;
  static const double left_padding = 16.0;
  static const double px31 = 31.0;
  static const double right_padding = 16.0;
  static const double elevation = 1.0;
  static const double px22 = 22.0;

  static const double px34 = 34;
  static const double px124 = 124;
  static const double px92 = 92;
  static const double px136 = 136;
  static const double px52 = 52;
  static const double px36 = 36;
  static const double px140 = 140;
  static const double px155 = 155;
  static const double px170 = 170;

  static const double px15 = 15;
  static const double px210 = 210;
  static const double px327 = 327;
  static const double px328 = 328;
  static const double px441 = 441;
  static const double px445 = 445;
  static const double px0 = 0;
  static const double px58 = 58;
  static const double px386 = 386;
  static const double px70 = 70;
  static const double px80 = 80;
  static const double px54 = 54;
  static const double px100 = 100;
  static const double px200 = 200;
  static const double px250 = 250;
  static const double px300 = 300;
  static const double px90 = 90;
  static const double px77 = 77;
  static const double px375 = 375;
  static const double px60 = 60;
  static const double px96 = 96;
  static const double px72 = 72;
  static const double px1 = 1;
  static const double px4 = 4;
  static const double px400 = 400;
  static const double px360 = 360;
  static const double px55 = 55;
  static const double px44 = 44;
  static const double px46 = 46;
  static const double px28 = 28;
  static const double px161 = 161;
  static const double px62 = 62;
  static const double px78 = 78;
  static const double px12 = 12;
  static const double px17 = 17;
  static const double px20 = 20;
  static const double px10 = 10;
  static const double px16 = 16;
  static const double px30 = 30;
  static const double px24 = 24;
  static const double px8 = 8;
  static const double px64 = 64;
  static const double px2 = 2;
  static const double px225 = 225;
  static const double px21 = 21;
  static const double px25 = 25;
  static const double px40 = 40;
  static const double px14 = 14;
  static const double px11 = 11;
  static const double px5 = 5;
  static const double px6 = 6;
  static const double px3 = 3;
  static const double px26 = 26;
  static const double px29 = 29;
  static const double px13 = 13;
  static const double px18 = 18;
  static const double px19 = 19;
  static const double px23 = 23;
  static const double px32 = 32;
  static const double px37 = 37;
  static const double px38 = 38;
  static const double px48 = 48;
  static const double px74 = 74;
  static const double px68 = 68;
  static const double px9 = 9;
  static const double px88 = 88;
  static const double px163 = 163;
  static const double px212 = 212;
  static const double px66 = 66;
  static const double px33 = 33;

  static const double px106 = 106;
  static const double px120 = 120;
  static const double px821 = 821;
  static const double px122 = 122;
  static const double px180 = 180;
  static const double px184 = 184;
  static const double px168 = 168;
  static const double px150 = 150;
  static const double px7 = 7;
  static const double px27 = 27;
  static const double px97 = 97;
  static const double px94 = 94;
  static const double px35 = 35;
  static const double px56 = 56;
  static const double px50 = 50;
  static const double px125 = 125;
  static const double px110 = 110;
}
