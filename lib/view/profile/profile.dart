import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trackhostel/app/controller/user_controller.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/res/constant/constants.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({Key? key}) : super(key: key);

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 22, color: kWhiteColor, letterSpacing: 1.5),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: kWhiteColor),
            onPressed: () {
              // Navigate to settings page
            },
          ),
        ],
      ),
      body: Obx(
            () => Skeletonizer(
          enabled: userController.isLoading.value,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Image.asset(logo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                Text(
                  userController.user.value.name ?? 'Name not available',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildInfoRow(Icons.email, 'Email', userController.user.value.email ?? 'Not available'),
                          const SizedBox(height: 20),
                          _buildInfoRow(Icons.password, 'Password', userController.user.value.password ?? 'Not available'),
                          const SizedBox(height: 20),
                          _buildInfoRow(Icons.location_on, 'Location', userController.user.value.address ?? 'Not available'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(60),
                        topLeft: Radius.circular(60),
                      ),
                      color: Colors.green,
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Implement logout logic here
                        userController.logout();
                      },
                      child: const Text(
                        'LOGOUT',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Info row widget for displaying user info
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[700]),
        const SizedBox(width: 20),
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
