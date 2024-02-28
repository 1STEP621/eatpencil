import 'package:eatpencil/components/general/space.dart';
import 'package:flutter/material.dart';
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
  }) : super(children: children.intersperse(Space(width: gap)).toList());
}
