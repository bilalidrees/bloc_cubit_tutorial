import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  BuildContext? _context;
  static AppColors? _instance;

  AppColors(_context) {
    this._context = _context;
  }

  factory AppColors.of(BuildContext context) {
    if (_instance == null) _instance = AppColors(context);
    return _instance!;
  }

  Color _mainColor = Color(0xFF43c3ef);
  Color _secondColor = Color(0xFF70defc);
  Color _accentColor = Color(0xFF8C98A8);
  static Color black = const Color(0x42000000);
  static Color white = const Color(0xFFFFFFFF);
  static Color appScreenColor = const Color(0xFFf4f7fc);
  static Color dropDownItems = const Color(0xFFd8d8d8);
  static Color buttonDisableColor = const Color(0xFF70defc).withOpacity(0.5);
  static Color timberWolf = const Color(0xFFd8d8d8);

  Color mainColor(double opacity) {
    return this._mainColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }
}
