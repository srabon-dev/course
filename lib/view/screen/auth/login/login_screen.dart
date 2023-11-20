import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/controller/auth_controller.dart';
import 'package:interactive/core/route/app_route.dart';
import 'package:interactive/service/auth_service.dart';
import 'package:interactive/utils/app_color.dart';
import 'package:interactive/view/widget/button/custom_button.dart';
import 'package:interactive/view/widget/text_field/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: formKey,
                child: GetBuilder<AuthController>(
                  builder: (controller) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                            "Email",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hintText: "Email",
                            controller: controller.loginEmailController,
                            prefixIcon: const Icon(Icons.email),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field can not be empty";
                              } else if (!value.contains(RegExp('\@'))) {
                                return "Please enter a valid email";
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
                            "Password",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hintText: "Password",
                          controller: controller.loginPasswordController,
                          prefixIcon: const Icon(Icons.lock),
                          isPassword: true,
                          isPrefixIcon: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your password";
                            } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(value)) {
                              return "Please use uppercase,lowercase,spacial character and number";
                            } else if (value.length < 8) {
                              return "Please use 8 character long password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoute.forgetScreen);
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forget Password?",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        controller.isLoginLoading?const Center(child: CircularProgressIndicator(),) : CustomButton(onTap: () {
                          if(formKey.currentState!.validate()){
                            controller.signInWithEmailAndPassword();
                          }
                        }, title: "Login",),
                        const SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoute.registerScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t have an account?",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                " Create now",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
