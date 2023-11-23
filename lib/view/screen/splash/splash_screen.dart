import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/controller/splash_controller.dart';
import 'package:interactive/service/auth_service.dart';
import 'package:interactive/utils/app_color.dart';
import 'package:interactive/utils/app_string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Get.put(AuthServices.instance);
    Get.put(SplashController(authServices: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return const Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book,
                    color: AppColors.green100,
                    size: 100,
                  ),
                  Text(AppString.appName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColors.green100,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
