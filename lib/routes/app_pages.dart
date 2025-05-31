import 'package:get/get.dart';
import '../views/splash/splash_view.dart';
import '../views/splash/splash_binding.dart';
import '../views/login/login_view.dart';
import '../views/login/login_binding.dart';
import '../views/home/home_view.dart';
import '../views/home/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
} 