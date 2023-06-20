import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BatteryController extends GetxController {
  late final String _getBatteryPercentageMethod = "getBatteryPercentageMethod";
  final MethodChannel _commonMethodChannel = const MethodChannel(
    "com.example.battery_per_on_android/common_channel",
  );

  Future<int> getBatteryPercentageOnAndroid() async {
    try {
      Map<Object?, Object?> dataMap = await _commonMethodChannel
              .invokeMapMethod(_getBatteryPercentageMethod)
          as Map<Object?, Object?>;
      return dataMap["batteryPercentage"] as int;
    } catch (err) {
      rethrow;
    }
  }
}
