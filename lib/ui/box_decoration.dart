import 'package:flutter/material.dart';

class BoxDecorators {
  static BoxDecoration decoratorSelectedButton() {
    return BoxDecoration(
        color: Colors.black26, borderRadius: BorderRadius.circular(20));
  }

  static BoxDecoration decoratorUnselectedButton() {
    return BoxDecoration(
        color: Colors.transparent, borderRadius: BorderRadius.circular(20));
  }
}
