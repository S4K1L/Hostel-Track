import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/utils/routes/routes.dart';
import 'package:trackhostel/view/login/login.dart';


class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _route();
            return const SizedBox.shrink();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }

  void _route() async {
    User? user = FirebaseAuth.instance.currentUser;
    var documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    if (documentSnapshot.exists) {
      Get.snackbar(
        'Login Success',
        'You have successfully logged in!',
        colorText: kWhiteColor,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
      );
      String userType = documentSnapshot.get('role');
      if (userType == "user") {
        Get.toNamed(RoutesPath.bottomBar);
      }
      else if (userType == "admin") {
        Get.toNamed(RoutesPath.adminBottomBar);
      }
      else {
        print('user data not found');
      }
    }
    else {
      print('user data not found');
    }
  }


}