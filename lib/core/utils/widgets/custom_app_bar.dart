import 'package:exam/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, {required String title}) {
  return AppBar(
    backgroundColor: ColorManager.whiteColor,
    elevation: 0,
    centerTitle: false,
    titleSpacing: 0,
    title: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(title),
    title: Text(title, textAlign: TextAlign.start),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    ),
  );
}
