import 'package:get/get.dart';
import 'package:helthy/views/dashboard/dashboard_binding.dart';
import 'package:helthy/views/dashboard/dashboard_view.dart';
import 'package:helthy/views/home/home_view.dart';
import 'package:helthy/views/login_view.dart';
import 'package:helthy/views/profile/change_password_binding.dart';
import 'package:helthy/views/profile/change_password_view.dart';
import 'package:helthy/views/request/request_training_view.dart';
import 'package:helthy/views/request/request_view.dart';
import 'package:helthy/views/splash_view.dart';

import '../bindings/login_binding.dart';
import '../bindings/splash_binding.dart';
import '../views/home/home_binding.dart';
import '../views/request/request_binding.dart';

class AppPages {
  static const initial = '/splash';

  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/request',
      page: () => const RequestView(),
      binding: RequestBinding(),
    ),
    GetPage(
      name: '/request-training',
      page: () => const RequestTrainingView(),
      binding: RequestBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: '/change-password',
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
  ];
}
