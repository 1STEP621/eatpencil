import 'package:flutter/material.dart';
import 'package:eatpencil/models/theme.dart';

final themes = {
  "Mi Astro Dark": MkTheme(
    accent: rgb(129, 192, 139),
    accentDarken: rgb(95, 175, 108),
    accentLighten: rgb(163, 209, 170),
    divider: rgba(255, 255, 255, 0.1),
    panel: rgb(42, 39, 43),
    bg: rgb(35, 33, 37),
    fg: rgb(239, 218, 185),
    fgTransparent: rgba(239, 218, 185, 0.5),
    link: rgb(120, 176, 160),
    hashtag: rgb(255, 145, 86),
    mention: rgb(255, 209, 82),
    mentionMe: rgb(251, 93, 56),
    renote: rgb(101, 156, 200),
    success: rgb(134, 179, 0),
    error: rgb(236, 65, 55),
    warn: rgb(236, 182, 55),
    modalBg: rgba(0, 0, 0, 0.5),
  ),
};

Color rgb(int r, int g, int b) {
  return Color.fromRGBO(r, g, b, 1.0);
}

Color rgba(int r, int g, int b, double a) {
  return Color.fromRGBO(r, g, b, a);
}
