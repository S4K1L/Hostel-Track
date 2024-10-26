import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackhostel/app/controller/user_controller.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/view/admin/add_hostel/add_hostel.dart';

class HostelListPage extends StatefulWidget {
  const HostelListPage({super.key});

  @override
  _HostelListPageState createState() => _HostelListPageState();
}

class _HostelListPageState extends State<HostelListPage> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.fetchAllHostelNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Hostel List',style: TextStyle(color: kWhiteColor,letterSpacing: 2,fontWeight: FontWeight.w500),),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: Obx(() {
        // Use Obx to observe changes in hostelList and isLoading
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (userController.hostelList.isEmpty) {
          return Center(
            child: Text(
              'No hostels available. Please add one!',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: userController.hostelList.length,
            itemBuilder: (context, index) {
              final hostelName = userController.hostelList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[700],
                    child: const Icon(Icons.home, color: Colors.white),
                  ),
                  title: Text(
                    hostelName, // Use hostelName here directly
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
