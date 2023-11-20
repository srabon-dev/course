import 'dart:async';
import 'package:get/get.dart';
import 'package:interactive/core/route/app_route.dart';
import 'package:interactive/service/auth_service.dart';

class SplashController extends GetxController{
  AuthServices authServices;
  SplashController({required this.authServices});

  Future<void> navigationRoute() async{
    if(authServices.currentUser!= null){
      Timer(const Duration(seconds: 2),(){
        Get.offAndToNamed(AppRoute.homeScreen);
      });
    }else{
      Timer(const Duration(seconds: 2),(){
        Get.offAndToNamed(AppRoute.loginScreen);
      });
    }
  }

  @override
  void onReady() {
    navigationRoute();
    super.onReady();
  }
}