import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trackhostel/app/controller/signup_controller.dart';
import 'package:trackhostel/res/components/custom_button.dart';
import 'package:trackhostel/res/components/input_form_field.dart';
import 'package:trackhostel/res/components/logo_container.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/res/constant/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LogoContainer(),
              Obx(
                () => Skeletonizer(
                  enabled: signupController.isLoading.value,
                  enableSwitchAnimation: true,
                  child: Form(
                    key: signupController.formKey,
                    child: Column(
                      children: [
                        InputFormField(
                          title: 'Name',
                          controller: signupController.nameController.value,
                        ),
                        InputFormField(
                          title: 'Address',
                          controller: signupController.addressController.value,
                        ),
                        InputFormField(
                          title: 'Email',
                          controller: signupController.emailController.value,
                        ),
                        InputFormField(
                          title: 'Password',
                          controller: signupController.passwordController.value,
                        ),
                        sizeBox,
                        CustomButton(
                          title: 'SIGN Up',
                          onPress: () {
                            String email = signupController.emailController.value.text;
                            String password = signupController.passwordController.value.text;
                            signupController.signUp(email, password);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
