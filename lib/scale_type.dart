import 'package:flutter/material.dart';

int getScaleType(BoxFit type) {
  switch (type) {
    case BoxFit.fill:
      return 1;
    case BoxFit.contain:
      return 5;
    case BoxFit.cover:
      return 10;
    case BoxFit.fitWidth:
      return 2;
    case BoxFit.fitHeight:
      return 3;
    case BoxFit.none:
      return 8;
    case BoxFit.scaleDown:
      return 7;
  }
}
