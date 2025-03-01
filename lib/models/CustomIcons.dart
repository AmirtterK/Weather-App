import 'package:flutter/widgets.dart';

class CustomIcon {
  CustomIcon._();

  static const _kFontFam = 'Icons';
  static const String? _kFontPkg = null;

  static const IconData humidity =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData sun =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData moon =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData pressure =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
