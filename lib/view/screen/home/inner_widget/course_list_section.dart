import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/core/route/app_route.dart';
import 'package:interactive/model/course_model.dart';
import 'package:interactive/utils/app_color.dart';

class CourseListSection extends StatelessWidget {
  const CourseListSection({super.key, required this.courseModel});
  final CourseModel courseModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 + 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black20),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageUrl: courseModel.image??"",fit: BoxFit.contain,),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(courseModel.courseName??"",
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Price: free",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      ///Navigate Course Screen
                      Get.toNamed(AppRoute.courseScreen,arguments: courseModel);
                    },
                    child: const Text(
                      "Continue Course",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
