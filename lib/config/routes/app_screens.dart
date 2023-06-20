import 'package:battery_per_on_android/config/routes/app_routes.dart';
import 'package:battery_per_on_android/modules/home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppScreens {
  static var list = [
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
    ),
  ];
}
