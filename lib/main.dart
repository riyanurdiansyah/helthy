import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:helthy/views/home/home_binding.dart';
import 'package:helthy/views/home/home_view.dart';
import 'package:helthy/views/request/request_binding.dart';
import 'package:helthy/views/request/request_view.dart';
import 'firebase_options.dart';
import 'views/splash_view.dart';
import 'views/login_view.dart';
import 'bindings/splash_binding.dart';
import 'bindings/login_binding.dart';
import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Wait a bit to ensure Firebase is fully initialized
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Initialize AuthController
    Get.put(AuthController());
    
    runApp(const MyApp());
  } catch (e) {
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to initialize Firebase',
                style: Theme.of(Get.context!).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                e.toString(),
                style: Theme.of(Get.context!).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Helthy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: SplashBinding(),
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashView(),
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
          name: '/login',
          page: () => const LoginView(),
          binding: LoginBinding(),
        ),
      ],
    );
  }
}