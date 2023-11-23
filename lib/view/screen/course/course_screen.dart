import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/controller/course_controller.dart';
import 'package:interactive/core/route/app_route.dart';
import 'package:interactive/model/course_model.dart';
import 'package:interactive/utils/app_color.dart';
import 'package:interactive/utils/app_string.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  CourseModel courseModel = CourseModel();
  @override
  void initState() {
    courseModel = Get.arguments;
    final controller = Get.put(CourseController());
    controller.course(id: courseModel.id??"", title: courseModel.courseName??"");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.course),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageUrl: courseModel.image??"",fit: BoxFit.contain,),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(courseModel.courseName??"",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
              child: Column(
                children: List.generate(courseModel.video?.length??0, (index) =>
                    GestureDetector(
                      onTap: (){
                        ///Navigate Video Player Screen
                        Get.toNamed(AppRoute.coursePlayerScreen,arguments: [courseModel.video?[index]??0,courseModel.id]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.green100)
                          ),
                          child: Row(
                            children: [
                              Text('$index: ',style: const TextStyle(fontWeight: FontWeight.bold),),
                              Flexible(child: Text(courseModel.video?[index].title??"",maxLines: 2,)),
                            ],
                          ),
                        ),
                      ),
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
