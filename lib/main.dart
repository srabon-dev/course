import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/utils/app_color.dart';
import 'core/route/app_route.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      color: AppColors.green100,
      defaultTransition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: AppRoute.splashScreen,
      navigatorKey: Get.key,
      theme: ThemeData(
        primaryColor: AppColors.green100,
        primarySwatch: Colors.green,
      ),
      getPages: AppRoute.routes
    );
  }
}
