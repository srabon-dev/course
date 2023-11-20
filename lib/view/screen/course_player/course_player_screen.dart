/*
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:interactive/model/course_model.dart';

class CoursePlayerScreen extends StatefulWidget {
  const CoursePlayerScreen({super.key});

  @override
  State<CoursePlayerScreen> createState() => _CoursePlayerScreenState();
}

class _CoursePlayerScreenState extends State<CoursePlayerScreen> {
  Video courseModel = Video();

*/
/*  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController customVideoPlayerController;
  @override
  void initState() {
    courseModel = Get.arguments;
    final url = Uri.parse(courseModel.url??"");
    videoPlayerController = VideoPlayerController.networkUrl(url)..initialize().then((value) => setState(() {}));
    customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: videoPlayerController,
        customVideoPlayerSettings: const CustomVideoPlayerSettings(
          placeholderWidget: Center(child: CircularProgressIndicator(),),
          showSeekButtons: true,
          seekDuration: Duration(seconds: 10),
          deviceOrientationsAfterFullscreen: [
            DeviceOrientation.portraitUp
          ],
        ),
    );
    super.initState();
  }

  @override
  void dispose() {
    customVideoPlayerController.dispose();
    super.dispose();
  }*//*

//CustomVideoPlayer(customVideoPlayerController: customVideoPlayerController)
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool videoComplete = false;
  double playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    courseModel = Get.arguments;
    final url = Uri.parse(courseModel.url ?? "");
    videoPlayerController = VideoPlayerController.networkUrl(url);
    videoPlayerController.setPlaybackSpeed(playbackSpeed);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9, // Adjust the aspect ratio according to your video
      autoPlay: true,
      looping: false,
      showControls: true,
      allowPlaybackSpeedChanging: true,
      customControls: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Rewind by 10 seconds
                  videoPlayerController.seekTo(
                    videoPlayerController.value.position - Duration(seconds: 10),
                  );
                },
                child: Icon(Icons.replay_10), // 10-second rewind button
              ),
              GestureDetector(
                onTap: () {
                  // Fast forward by 10 seconds
                  videoPlayerController.seekTo(
                    videoPlayerController.value.position + Duration(seconds: 10),
                  );
                },
                child: Icon(Icons.forward_10), // 10-second fast forward button
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Toggle playback speed between 0.5x, 1.0x, and 1.5x
              setState(() {
                playbackSpeed = playbackSpeed == 0.5 ? 1.0 : 0.5;
                videoPlayerController.setPlaybackSpeed(playbackSpeed);
              });
            },
            child: Text('${playbackSpeed}x'),
          ),
        ],
      ),
    );
    videoPlayerController.addListener(() {
      if (videoPlayerController.value.position == videoPlayerController.value.duration) {
        print("object");
        setState(() {
          videoComplete = true;
        });
      }
    });

    videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(courseModel.title ?? ""),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          chewieController.enterFullScreen();
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        },
        child: const Icon(Icons.fullscreen),
      ),
      body: Center(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/model/course_model.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  double playbackSpeed = 1.0;
  Video courseModel = Video();

  @override
  void initState() {
    super.initState();
    courseModel = Get.arguments;
    final url = Uri.parse(courseModel.url ?? "");

    // Initialize the video player controller
    videoPlayerController = VideoPlayerController.networkUrl(url);

    // Set the initial playback speed
    videoPlayerController.setPlaybackSpeed(playbackSpeed);

    // Initialize the Chewie controller
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: false,
      showControls: false,
      allowPlaybackSpeedChanging: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Chewie(
            controller: chewieController,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () {
                    // Implement your action for skip to previous video
                  },
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(
                    videoPlayerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onPressed: () {
                    if (videoPlayerController.value.isPlaying) {
                      videoPlayerController.pause();
                    } else {
                      videoPlayerController.play();
                    }
                  },
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () {
                    // Implement your action for skip to next video
                  },
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    // Implement your action for video settings
                  },
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.transparent, Colors.black54],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(videoPlayerController.value.position),
                  style: const TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Slider(
                    value: videoPlayerController.value.position.inMilliseconds
                        .toDouble(),
                    onChanged: (value) {
                      videoPlayerController.seekTo(
                        Duration(milliseconds: value.toInt()),
                      );
                    },
                    min: 0,
                    max: videoPlayerController.value.duration.inMilliseconds
                        .toDouble(),
                  ),
                ),
                Text(
                  formatDuration(videoPlayerController.value.duration),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Toggle fullscreen
          chewieController.enterFullScreen();
        },
        child: const Icon(Icons.fullscreen),
      ),
    );
  }

  String formatDuration(Duration duration) {
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}


