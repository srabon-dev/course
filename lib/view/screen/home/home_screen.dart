import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/controller/home_controller.dart';
import 'inner_widget/app_bar_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Get.put(HomeController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarSection(),
            Container(

            )
          ],
        ),
      ),
    );
  }
}
