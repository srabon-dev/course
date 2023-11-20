import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:interactive/core/route/app_route.dart';
import 'package:interactive/service/auth_service.dart';

class AuthController extends GetxController{
  AuthServices authServices;
  AuthController({required this.authServices});

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //Login Section
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();
  bool isLoginLoading = false;

  //Reset Password Section
  TextEditingController resetEmailController = TextEditingController();
  bool isResetLoading = false;

  //Register Section
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController(text: "+88");
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isRegisterLoading = false;

  //Registration Function
  Future<void> createAccountWithEmailAndPassword() async {
    try {
      isRegisterLoading = true;
      update();
      await authServices.createAccountWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      ).then((value) async {
        if(value.user?.email != null){
          await firebaseFirestore.collection("users").doc(authServices.currentUser?.uid ?? "").set({
            'name': nameController.text,
            'email': emailController.text.trim(),
            'phone': phoneController.text.trim(),
            'uid': authServices.currentUser?.uid ?? "",
          }).then((value) {
            isRegisterLoading = false;
            update();
            Fluttertoast.showToast(msg: "Account Create Successful");
            Get.offAndToNamed(AppRoute.homeScreen);
          });
        }else{
          isRegisterLoading = false;
          update();
          Fluttertoast.showToast(msg: "Registration error");
        }
      });
    } on FirebaseAuthException catch (error) {
      isRegisterLoading = false;
      update();
      Fluttertoast.showToast(msg: error.message??"Registration error");
    }
  }

  //Login Function
  Future<void> signInWithEmailAndPassword () async{
    isLoginLoading = true;
    update();
    try{
      UserCredential response = await authServices.signInWithEmailAndPassword(
          email: loginEmailController.text.trim(),
          password: loginpasswordController.text.trim()
      );
      if(response.user?.email != null){
        isLoginLoading = false;
        update();
        Fluttertoast.showToast(msg: "Login Successful");
        Get.offAndToNamed(AppRoute.homeScreen);
      }
    } on FirebaseAuthException catch(error){
      isLoginLoading = false;
      update();
      Fluttertoast.showToast(msg: error.message??"Login error");
    }
  }

  //Reset Password Function
  Future<void> forgetPassword() async {
    try {
      isResetLoading = true;
      update();
      await authServices.resetPassword(email: resetEmailController.text.trim());
      isResetLoading = false;
      update();
      Fluttertoast.showToast(msg: "Check your email reset password link has been sent");
      Get.offAndToNamed(AppRoute.loginScreen);
    }catch(error){
      Fluttertoast.showToast(msg: '$error');
    }
  }

}