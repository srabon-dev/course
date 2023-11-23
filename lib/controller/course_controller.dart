import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CourseController extends GetxController{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> course({required String id, required String title}) async{
    firestore.collection('purchase-course').doc(firebaseAuth.currentUser?.uid??"").collection(id).add({
      'id' : id,
      'watch' : [

      ]
    });
  }
}