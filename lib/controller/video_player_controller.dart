import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:interactive/utils/app_color.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenController extends GetxController{

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void initializeVideoPlayer({required String url, required String id, required String courseId}){
    final uri = Uri.parse(url);
    videoPlayerController = VideoPlayerController.networkUrl(uri);
    videoPlayerController.setPlaybackSpeed(1.0);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: false,
      showControls: true,
    );

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.position == videoPlayerController.value.duration) {

        firestore.collection('purchase-course').doc(firebaseAuth.currentUser?.uid??"").collection(id).add({
          'id' : id,
          'watch' : [id]
        });
        Fluttertoast.showToast(msg: "Success");
      }else{
        Fluttertoast.showToast(msg: "Video watch not complete",textColor: AppColors.red80);
      }
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}