import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/utils/routes/routes.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login function
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;

      // Show success toast
      Get.snackbar(
        'Login Success',
        'You have successfully logged in!',
        colorText: kWhiteColor,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      );
      Get.toNamed(RoutesPath.bottomBar);

    } catch (e) {
      isLoading.value = false;

      // Show error toast
      Get.snackbar(
        'Login Failed',
        'Check your email and password',
        colorText: kWhiteColor,
        backgroundColor: kRedColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      );
    }
  }
}
