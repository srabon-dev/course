import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Get Current User Info
  Future<DocumentSnapshot> getUserInfo() async{
    return firebaseFirestore.collection('user').doc(firebaseAuth.currentUser?.uid??"").get();
  }
}