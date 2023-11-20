import 'package:get/get.dart';
import 'package:interactive/view/screen/auth/forget/forget_screen.dart';
import 'package:interactive/view/screen/auth/login/login_screen.dart';
import 'package:interactive/view/screen/auth/register/register_screen.dart';
import 'package:interactive/view/screen/home/home_screen.dart';
import 'package:interactive/view/screen/splash/splash_screen.dart';

class AppRoute{
  static const String splashScreen = "/splash_screen";
  static const String homeScreen = "/home_screen";
  static const String loginScreen = "/login_screen";
  static const String registerScreen = "/register_screen";
  static const String forgetScreen = "/forget_screen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: forgetScreen, page: () => const ForgetScreen()),
  ];
}


