import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trackhostel/app/controller/login_controller.dart';
import 'package:trackhostel/res/components/custom_button.dart';
import 'package:trackhostel/res/components/input_form_field.dart';
import 'package:trackhostel/res/components/logo_container.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/res/constant/constants.dart';
import 'package:trackhostel/view/signup/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LogoContainer(),
              Obx(()=> Skeletonizer(
                enabled: loginController.isLoading.value,
                enableSwitchAnimation: true,
                child: Column(
                  children: [
                    InputFormField(
                      title: 'Email',
                      controller: emailController,
                    ),
                    InputFormField(
                      title: 'Password',
                      controller: passwordController,
                    ),
                    sizeBox,
                    CustomButton(
                      title: 'SIGN IN',
                      onPress: () {
                        loginController.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                    ),
                    sizeBox,
                    InkWell(
                      onTap: () {
                        Get.to(()=> const SignUpPage(),transition: Transition.rightToLeft);
                      },
                      child: Text(
                        "Don't have and account? Sign Up",
                        style: TextStyle(
                            color: kBlackColor,
                            fontSize: 18.r,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5.r),
                      ),
                    ),
                  ],
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
