import 'package:battery_per_on_android/modules/battery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BatteryController _batteryController = Get.put(BatteryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Screen'),
      ),
      body: FutureBuilder(
        future: _batteryController.getBatteryPercentageOnAndroid(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your Remaining Battery Percentage Is: ${snapshot.data.toString()}%',
                ),
              ),
            );
          }
          return const Center(
            child: Text(
              'Something went wrong!',
            ),
          );
        },
      ),
    );
  }
}
