import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:trackhostel/models/hostel_model.dart';
import 'package:trackhostel/models/status_model.dart';
import 'package:trackhostel/models/user_model.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/utils/routes/routes.dart';

class UserController extends GetxController {
  // Observables
  var user = UserModel().obs;
  var hostel = HostelModel().obs;
  var status = StatusModel().obs;
  var hostelList = <String>[].obs; // List to store hostel names
  var isLoading = false.obs;

  // Firebase instances
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Fetch the logged-in user's data
  Future<void> fetchLoggedInUser() async {
    try {
      isLoading(true);
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(currentUser.uid).get();
        user.value = UserModel.fromSnapshot(doc);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading(false);
    }
  }

// Fetch all hostel names from Firebase
  Future<void> fetchAllHostelNames() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('hostel').get();
      hostelList.clear(); // Clear previous data if any

      for (var doc in snapshot.docs) {
        hostelList.add(HostelModel.fromSnapshot(doc).hostelName ?? 'Unknown Hostel');
      }
    } catch (e) {
      print("Error fetching hostel names: $e");
    } finally {
      isLoading(false);
    }
  }


  // Logout method
  Future<void> logout() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
        user.value = UserModel();
        Get.snackbar(
          'Logout Success',
          'You have successfully logged out!',
          colorText: kWhiteColor,
          backgroundColor: kPrimaryColor,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
        );
        Get.offAndToNamed(RoutesPath.login);
      } else {
        if (kDebugMode) {
          print("No user is currently signed in");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error logging out: $e");
      }
      Get.snackbar('Error', 'An error occurred while logging out. Please try again.');
      rethrow;
    }
  }

  showHostelPicker(BuildContext context) {
    final hostelNames = hostelList;

    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text('Select Hostel'),
        actions: List<Widget>.generate(
          hostelNames.length,
              (index) => CupertinoActionSheetAction(
            child: Text(hostelNames[index]),
            onPressed: () {
              // Set selected hostel name instantly
              hostel.value.hostelName = hostelNames[index];

              // Dismiss the picker
              Navigator.of(context).pop();
            },
          ),
        ),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  // Function to store check-in time with user data
  Future<void> storeCheckIn(String hostel) async {
    try {
      isLoading(true);
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Get the current time and date
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('EEE, d MMM yyyy').format(now); // e.g., Fri, 21 June 2024

        // Check if the user has already checked in today
        QuerySnapshot existingCheckIn = await _firestore
            .collection('status')
            .where('uid', isEqualTo: user.value.uid)
            .where('hostel', isEqualTo: status.value.hostel)
            .get();

        if (existingCheckIn.docs.isNotEmpty) {
          // If a check-in record exists for today, show a message and return
          Get.snackbar(
            'Already Checked-In',
            'You have already checked in today!',
            snackPosition: SnackPosition.BOTTOM,
          );
          return; // Exit the function
        }

        // Proceed to store check-in if no record exists for today
        String formattedTime = DateFormat('hh:mm a').format(now); // e.g., 09:00 AM

        await _firestore.collection('status').doc().set({
          'name': currentUser.displayName ?? 'No Name',
          'email': currentUser.email ?? 'No Email',
          'checkIn': formattedTime,
          'checkOut': '',
          'checkInDate': formattedDate,
          'checkOutDate': '',
          'hostel': hostel ?? '',
          'uid': currentUser.uid,
        }, SetOptions(merge: true));

        Get.snackbar(
          'Check-In Success',
          'Check-In time has been recorded!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("Error storing check-in data: $e");
      Get.snackbar(
        'Check-In Failed',
        'An error occurred while recording check-in. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> storeCheckOut(String hostel) async {
    try {
      isLoading(true);
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Get the current time and date
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('EEE, d MMM yyyy').format(now); // e.g., Fri, 21 June 2024

        // Check if the user has already checked in today
        QuerySnapshot existingCheckIn = await _firestore
            .collection('status')
            .where('uid', isEqualTo: user.value.uid)
            .where('checkOut', isEqualTo: null)
            .get();

        if (existingCheckIn.docs.isNotEmpty) {
          // If a check-in record exists for today, show a message and return
          Get.snackbar(
            'Already Checked-Out',
            'You have already checked out today!',
            snackPosition: SnackPosition.BOTTOM,
          );
          return; // Exit the function
        }

        // Proceed to store check-in if no record exists for today
        String formattedTime = DateFormat('hh:mm a').format(now); // e.g., 09:00 AM

        await _firestore.collection('status').doc().set({
          'checkOutDate': formattedDate,
          'checkOut': formattedTime,
        }, SetOptions(merge: true));

        Get.snackbar(
          'Check-Out Success',
          'Check-Out time has been recorded!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("Error storing check-Out data: $e");
      Get.snackbar(
        'Check-Out Failed',
        'An error occurred while recording check-Out. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }


  Future<StatusModel?> fetchCheckData() async {
    try {
      // Query Firestore to get the status document for the current user by UID
      QuerySnapshot querySnapshot = await _firestore
          .collection('status')
          .where('uid', isEqualTo: currentUser?.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document from the query result
        DocumentSnapshot doc = querySnapshot.docs.first;

        // Check if the document contains the required fields
        if (doc.exists && doc.data() != null) {
          // Create a StatusModel instance from the Firestore document snapshot
          StatusModel status = StatusModel.fromSnapshot(doc);

          // Update the status observable
          this.status.value = status;

          return status;
        } else {
          print("Check-in data does not exist or is empty.");
          return null;
        }
      } else {
        print("No check-in data found for this user.");
        return null;
      }
    } catch (e) {
      print("Error fetching check-in data: $e");
      return null;
    }
  }


}