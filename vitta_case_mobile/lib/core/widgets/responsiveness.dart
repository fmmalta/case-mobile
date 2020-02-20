import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void hideKeyboard() {
  SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
}

Future<void> exitApp() async {
  if (Platform.isAndroid) {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  } else {
    exit(0);
  }
}

double responsiveFont(BuildContext context, double value) {
  final double magic = MediaQuery.of(context).size.width / 400;
  return magic * value;
}

double responsiveHeight(BuildContext context, double value) {
  const double designHeight = 736;
  final double height = MediaQuery.of(context).size.height;
  final double magicNumber = value / designHeight;
  return magicNumber * height;
}

double responsiveWidth(BuildContext context, double value) {
  const double designWidth = 414;
  final double width = MediaQuery.of(context).size.width;
  final double magicNumber = value / designWidth;
  return magicNumber * width;
}

Size deviceSize(BuildContext context) => MediaQuery.of(context).size;
