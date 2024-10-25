import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackhostel/app/controller/user_controller.dart';
import 'package:trackhostel/res/constant/colors.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.fetchHistory(); // Fetch history on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        title: const Text("HISTORY",style: TextStyle(fontSize: 26,color: kWhiteColor,fontWeight: FontWeight.w500,letterSpacing: 3),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Obx(
            () => userController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : userController.history.isEmpty
            ? const Center(
          child: Text(
            "No Check-In History Available",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: userController.history.length,
          itemBuilder: (context, index) {
            var record = userController.history[index];
            return CheckInOutCard(record: record);
          },
        ),
      ),
    );
  }
}

class CheckInOutCard extends StatelessWidget {
  final Map<String, dynamic> record;

  const CheckInOutCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Hostel
            Text(
              record['hostel'] ?? 'Unknown Hostel',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            // Display Check-In Date
            Row(
              children: [
                const Icon(Icons.login, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  "Check-In: ${record['checkInDate'] ?? 'N/A'}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Display Check-Out Date
            Row(
              children: [
                const Icon(Icons.logout, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  "Check-Out: ${record['checkOutDate'] ?? 'N/A'}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
