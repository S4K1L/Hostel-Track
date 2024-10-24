import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trackhostel/app/controller/user_controller.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final UserController userController = Get.put(UserController());
  late WebViewController controller;
  String currentTime = '';
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    updateCurrentTimeAndDate();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/maps')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.google.com/maps'));
  }

  void updateCurrentTimeAndDate() {
    var now = DateTime.now();
    setState(() {
      currentTime = DateFormat('hh:mm a').format(now); // 09:00 AM
      currentDate = DateFormat('EEE, d MMM yyyy').format(now); // Fri, 21 June 2024
    });
  }

  @override
  Widget build(BuildContext context) {
    userController.fetchCheckData();
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: WebViewWidget(
                controller: controller,
              ),
            ),
            Stack(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded, size: 40),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 90,
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.center,
                                child: Obx(
                                      () => Text(
                                    // Bind the hostel name from the controller
                                    userController.hostel.value.hostelName ?? 'Hostel not selected',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 3, // Allow multiple lines
                                    overflow: TextOverflow.visible, // Show text in multiple lines
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        Text(
                          currentDate,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          currentTime,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.green,
                            ),
                            child: TextButton(
                              onPressed: () async {
                                userController.storeCheckOut(userController.hostel.value.hostelName!);
                              },
                              child: const Text(
                                'CHECK-OUT',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Icon(Icons.watch_later_outlined, size: 40),
                                Column(
                                  children: [
                                    Text(
                                      userController.status.value.checkIn ??
                                          "--:--",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      userController.status.value.checkInDate ??
                                          "--:--",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text("Check-in"),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.watch_later_outlined, size: 40),
                                Column(
                                  children: [
                                    Text(
                                      userController.status.value.checkOut ??
                                          "--:--",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      userController.status.value.checkOutDate ??
                                          "--:--",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text("Check-out"),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
