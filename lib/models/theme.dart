import 'package:flutter/material.dart';

class MkTheme {
  final Color accent;
  final Color accentDarken;
  final Color accentLighten;

  final Color divider;
  final Color panel;

  final Color bg;
  final Color fg;
  final Color fgTransparent;

  final Color link;
  final Color hashtag;
  final Color mention;
  final Color mentionMe;
  final Color renote;

  final Color success;
  final Color error;
  final Color warn;

  final Color modalBg;
  MkTheme({
    required this.accent,
    required this.accentDarken,
    required this.accentLighten,
    required this.divider,
    required this.panel,
    required this.bg,
    required this.fg,
    required this.fgTransparent,
    required this.link,
    required this.hashtag,
    required this.mention,
    required this.mentionMe,
    required this.renote,
    required this.success,
    required this.error,
    required this.warn,
    required this.modalBg,
  });

  ColorScheme toColorScheme() {
    return ColorScheme.fromSeed(seedColor: accent).copyWith(
      background: bg,
      primary: accent,
      secondary: accentLighten,
      tertiary: accentDarken,
      error: error,
      surface: panel,
      surfaceTint: panel,
      onBackground: fg,
      onPrimary: fg,
      onSecondary: fg,
      onTertiary: fg,
      onSurface: fg,
      onError: fg,
      shadow: modalBg,
    );
  }
}
