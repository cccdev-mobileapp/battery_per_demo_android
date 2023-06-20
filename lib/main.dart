import 'dart:async';

import 'package:battery_per_on_android/config/routes/app_routes.dart';
import 'package:battery_per_on_android/config/routes/app_screens.dart';
import 'package:battery_per_on_android/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
        (_) async {
      runApp(
        GetMaterialApp(
          title: 'Battery Percentage Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          initialRoute: AppRoutes.homeScreen,
          getPages: AppScreens.list,
        ),
      );
    },
  );
}
