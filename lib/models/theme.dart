import 'package:flutter/material.dart';

class MkTheme {
  final Color accent;
  final Color accentDarken;
  final Color accentLighten;
  final Color accentedBg;
  final Color focus;
  final Color bg;
  final Color acrylicBg;
  final Color fg;
  final Color fgTransparentWeak;
  final Color fgTransparent;
  final Color fgHighlighted;
  final Color fgOnAccent;
  final Color fgOnWhite;
  final Color divider;
  final Color indicator;
  final Color panel;
  final Color panelHighlight;
  final Color panelHeaderBg;
  final Color panelHeaderFg;
  final Color panelHeaderDivider;
  final Color acrylicPanel;
  final Color windowHeader;
  final Color popup;
  final Color shadow;
  final Color header;
  final Color navBg;
  final Color navFg;
  final Color navHoverFg;
  final Color navActive;
  final Color navIndicator;
  final Color link;
  final Color hashtag;
  final Color mention;
  final Color mentionMe;
  final Color renote;
  final Color modalBg;
  final Color scrollbarHandle;
  final Color scrollbarHandleHover;
  final Color dateLabelFg;
  final Color infoBg;
  final Color infoFg;
  final Color infoWarnBg;
  final Color infoWarnFg;
  final Color switchBg;
  final Color cwBg;
  final Color cwFg;
  final Color cwHoverBg;
  final Color buttonBg;
  final Color buttonHoverBg;
  final Color buttonGradateA;
  final Color buttonGradateB;
  final Color switchOffBg;
  final Color switchOffFg;
  final Color switchOnBg;
  final Color switchOnFg;
  final Color inputBorder;
  final Color inputBorderHover;
  final Color listItemHoverBg;
  final Color driveFolderBg;
  final Color wallpaperOverlay;
  final Color badge;
  final Color messageBg;
  final Color success;
  final Color error;
  final Color warn;
  final Color codeString;
  final Color codeNumber;
  final Color codeBoolean;
  final Color deckBg;
  final Color htmlThemeColor;
  final Color x2;
  final Color x3;
  final Color x4;
  final Color x5;
  final Color x6;
  final Color x7;
  final Color x8;
  final Color x9;
  final Color x10;
  final Color x11;
  final Color x12;
  final Color x13;
  final Color x14;
  final Color x15;
  final Color x16;
  final Color x17;

  MkTheme({
    required this.accent,
    required this.accentDarken,
    required this.accentLighten,
    required this.accentedBg,
    required this.focus,
    required this.bg,
    required this.acrylicBg,
    required this.fg,
    required this.fgTransparentWeak,
    required this.fgTransparent,
    required this.fgHighlighted,
    required this.fgOnAccent,
    required this.fgOnWhite,
    required this.divider,
    required this.indicator,
    required this.panel,
    required this.panelHighlight,
    required this.panelHeaderBg,
    required this.panelHeaderFg,
    required this.panelHeaderDivider,
    required this.acrylicPanel,
    required this.windowHeader,
    required this.popup,
    required this.shadow,
    required this.header,
    required this.navBg,
    required this.navFg,
    required this.navHoverFg,
    required this.navActive,
    required this.navIndicator,
    required this.link,
    required this.hashtag,
    required this.mention,
    required this.mentionMe,
    required this.renote,
    required this.modalBg,
    required this.scrollbarHandle,
    required this.scrollbarHandleHover,
    required this.dateLabelFg,
    required this.infoBg,
    required this.infoFg,
    required this.infoWarnBg,
    required this.infoWarnFg,
    required this.switchBg,
    required this.cwBg,
    required this.cwFg,
    required this.cwHoverBg,
    required this.buttonBg,
    required this.buttonHoverBg,
    required this.buttonGradateA,
    required this.buttonGradateB,
    required this.switchOffBg,
    required this.switchOffFg,
    required this.switchOnBg,
    required this.switchOnFg,
    required this.inputBorder,
    required this.inputBorderHover,
    required this.listItemHoverBg,
    required this.driveFolderBg,
    required this.wallpaperOverlay,
    required this.badge,
    required this.messageBg,
    required this.success,
    required this.error,
    required this.warn,
    required this.codeString,
    required this.codeNumber,
    required this.codeBoolean,
    required this.deckBg,
    required this.htmlThemeColor,
    required this.x2,
    required this.x3,
    required this.x4,
    required this.x5,
    required this.x6,
    required this.x7,
    required this.x8,
    required this.x9,
    required this.x10,
    required this.x11,
    required this.x12,
    required this.x13,
    required this.x14,
    required this.x15,
    required this.x16,
    required this.x17,
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
