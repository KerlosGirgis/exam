import 'package:flutter/material.dart';

import '../color_manager.dart';

AppBar buildAppBar(BuildContext context, {required String title}) {
  return AppBar(
    backgroundColor: ColorManager.whiteColor,
    elevation: 0,
    centerTitle: false,
    titleSpacing: 0,
    title: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(title),
    ),
  );
}
