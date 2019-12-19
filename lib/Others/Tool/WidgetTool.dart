import 'package:flutter/material.dart';

class WidgetTool {
  // 分割线
  static Widget createListViewLine(double height, Color color) {
    return Container(
      color: color,
      height: height,
    );
  }
}