import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trackhostel/app/controller/login_controller.dart';
import 'package:trackhostel/res/components/custom_button.dart';
import 'package:trackhostel/res/components/input_form_field.dart';
import 'package:trackhostel/res/components/logo_container.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/res/constant/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LogoContainer(),
              InputFormField(
                title: 'Email',
                controller: loginController.emailController.value,
              ),
              InputFormField(
                title: 'Password',
                controller: loginController.passwordController.value,
              ),
              CustomButton(
                title: 'SIGN IN',
                onPress: () {},
              ),
              sizeBox,
              InkWell(
                onTap: () {},
                child: Text(
                  "Don't have and account? Sign Up",
                  style: TextStyle(
                      color: kBlackColor,
                      fontSize: 18.r,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5.r),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
