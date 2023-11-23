import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/controller/video_player_controller.dart';
import 'package:interactive/model/course_model.dart';
import 'package:interactive/utils/app_string.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  Video courseModel = Video();

  @override
  void initState() {
    super.initState();
    courseModel = Get.arguments[0];
    final String? courseId = Get.arguments[1];
    final controller = Get.put(VideoPlayerScreenController());
    controller.initializeVideoPlayer(url: courseModel.url??"", id: courseModel.id??"", courseId: courseId??"");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.videoPlayer),
      ),
      body: GetBuilder<VideoPlayerScreenController>(
        builder: (controller) {
          return Center(
            child: Chewie(
              controller: controller.chewieController,
            ),
          );
        }
      ),
      floatingActionButton: GetBuilder<VideoPlayerScreenController>(
        builder: (controller) {
          return FloatingActionButton(
            onPressed: () {
              controller.chewieController.enterFullScreen();
            },
            child: const Icon(Icons.fullscreen),
          );
        }
      ),
    );
  }
}


