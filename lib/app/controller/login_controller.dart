import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

      //success
      route();

    } catch (e) {
      isLoading.value = false;

      // Show error toast
      print('error $e');
    }
  }


  void route() async {
    User? user = FirebaseAuth.instance.currentUser;

    var documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    if (documentSnapshot.exists) {
      String userType = documentSnapshot.get('role');
      if (userType == "user") {
        Get.snackbar(
          'Login Success',
          'You have successfully logged in!',
          colorText: kWhiteColor,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
        );
        Get.toNamed(RoutesPath.bottomBar);
      }
      else if (userType == "admin") {
        Get.snackbar(
          'Login Success',
          'You have successfully logged in!',
          colorText: kWhiteColor,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
        );
        Get.toNamed(RoutesPath.adminBottomBar);
      }
      else {
        Get.snackbar(
          'Try again',
          'Some error in logging in!',
          colorText: kWhiteColor,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
        );
      }
    }
    else {
      print('user data not found');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      if (kDebugMode) {
        print('Error resetting password: $error');
      }
      rethrow;
    }
  }
}
