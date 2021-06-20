import 'package:flutter/material.dart';

class KDecoration {
  static BoxDecoration boxDecoration({Color? color,
    Border? border, double radius = 8, String direction = 'all'}) {
    BorderRadius borderRadius = BorderRadius.circular(radius);
    switch (direction.toLowerCase()) {
      case 'top':
        borderRadius = BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius));
        break;
      case 'bottom':
        borderRadius = BorderRadius.only(
            bottomLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius));
        break;
      case 'left':
        borderRadius = BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomLeft: Radius.circular(radius));
        break;
      case 'leftBottom':
        borderRadius = BorderRadius.only(bottomLeft: Radius.circular(radius));
        break;
      case 'right':
        borderRadius = BorderRadius.only(
            bottomRight: Radius.circular(radius),
            topRight: Radius.circular(radius));
        break;
      case 'rightbot':
        borderRadius = BorderRadius.only(bottomRight: Radius.circular(radius));
        break;
      case 'all':
        borderRadius = BorderRadius.circular(radius);
        break;
    }

    if (border == null) border = Border.all(style: BorderStyle.none, width: 0);

    return BoxDecoration(
        color: color, borderRadius: borderRadius, border: border);
  }
}
