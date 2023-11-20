import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/controller/auth_controller.dart';
import 'package:interactive/core/route/app_route.dart';
import 'package:interactive/service/auth_service.dart';
import 'package:interactive/utils/app_color.dart';
import 'package:interactive/view/widget/button/custom_button.dart';
import 'package:interactive/view/widget/text_field/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Get.put(AuthServices.instance);
    Get.put(AuthController(authServices: Get.find()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: formKey,
              child: GetBuilder<AuthController>(
                builder: (controller) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Icon(
                        Icons.menu_book,
                        color: AppColors.green100,
                        size: 100,
                      ),
                      Text(
                        "Ed Tech",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Name",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: "Name",
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(Icons.person),
                        controller: controller.nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field can not be empty";
                          }else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field can not be empty".tr;
                          } else if (!value.contains(RegExp('\@'))) {
                            return "Please enter a valid email".tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Phone Number",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: "Phone Number",
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone),
                        controller: controller.phoneController,
                        validator: (value) {
                          bool mobileValid = RegExp(r'^(?:\+?88|0088)?01[13-9]\d{8}$').hasMatch(value);
                          if (value == null || value.isEmpty) {
                            return "This field can not be empty";
                          } else if (!value.contains('+8801')) {
                            return "Please enter a valid Phone Number";
                          } else if(mobileValid == false){
                            return "Please enter a valid Phone Number";
                          }else if(value.length != 14){
                            return "Please enter a valid Phone Number";
                          } else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: "Password",
                        keyboardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock),
                        controller: controller.passwordController,
                        isPassword: true,
                        isPrefixIcon: true,
                        validator: (value){
                          if(value.isEmpty){
                            return "Please enter your password";
                          } else if(controller.passwordController.text != controller.confirmPasswordController.text){
                            return "Password doesn't match";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Confirm Password",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: "Confirm Password",
                        keyboardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock),
                        isPassword: true,
                        controller: controller.confirmPasswordController,
                        isPrefixIcon: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter your password";
                          } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(controller.passwordController.text)) {
                            return "Please use uppercase,lowercase,spacial character and number";
                          } else if (value.length < 8) {
                            return "Please use 8 character long password";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      controller.isRegisterLoading?const Center(child: CircularProgressIndicator(),) : CustomButton(onTap: () {
                        if(formKey.currentState!.validate()){
                          controller.createAccountWithEmailAndPassword();
                        }
                      }, title: "Create Account",),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoute.loginScreen);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                                " Login Now",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              ),
            ),
          );
        },
      ),
    );
  }
}
