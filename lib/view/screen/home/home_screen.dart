import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/controller/home_controller.dart';
import 'package:interactive/model/course_model.dart';
import 'package:interactive/view/screen/home/inner_widget/course_list_section.dart';
import 'inner_widget/app_bar_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
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
            ///App Bar Section
            AppBarSection(),

            /// My Course Section
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My Courses",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  //Get All Data From Firebase Using StreamBuilder
                  StreamBuilder<QuerySnapshot>(
                    stream: firebaseFirestore.collection('courses').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (snapshot.hasError) {
                        return const Center(child: Text('Something went wrong'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            CourseModel courseModel = CourseModel.fromJson(data);
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),

                              /// Course Container Section
                              child: CourseListSection(courseModel: courseModel,),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
