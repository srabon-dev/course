import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive/controller/auth_controller.dart';
import 'package:interactive/service/auth_service.dart';
import 'package:interactive/utils/app_color.dart';
import 'package:interactive/view/widget/button/custom_button.dart';
import 'package:interactive/view/widget/text_field/custom_text_field.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
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
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GetBuilder<AuthController>(
                builder: (controller) {
                  return Form(
                    key: formKey,
                    child: Column(
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
                          controller: controller.resetEmailController,
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
                          height: 24,
                        ),
                        controller.isResetLoading?Center(child: CircularProgressIndicator(),) : CustomButton(onTap: () {
                          if(formKey.currentState!.validate()){
                            controller.forgetPassword();
                          }
                        }, title: "Continue",),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
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
