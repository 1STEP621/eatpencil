import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intersperse/intersperse.dart';

class RowWithGap extends Row {
  RowWithGap({
    super.key,
    List<Widget> children = const <Widget>[],
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
    required double gap,
  }) : super(children: children.intersperse(Gap(gap)).toList());
}
