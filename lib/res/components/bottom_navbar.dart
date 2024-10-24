import 'package:flutter/material.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/view/check_out/check_out.dart';
import 'package:trackhostel/view/home/home.dart';
import 'package:trackhostel/view/profile/profile.dart';


class UserBottomBar extends StatefulWidget {
  const UserBottomBar({super.key});

  @override
  State<UserBottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<UserBottomBar> {
  int indexColor = 0;
  List<Widget> screens = [
    const HomePage(),
    const CheckOutPage(),
    UserProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[indexColor],
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        color: kBackGroundColor,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.green.withOpacity(0.8),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBottomNavigationItem(Icons.home, 0),
                      _buildBottomNavigationItem(Icons.control_camera_outlined, 1),
                      _buildBottomNavigationItem(Icons.person_sharp, 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          indexColor = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 25,
            color: indexColor == index ? Colors.greenAccent : kWhiteColor,
          ),
          if (indexColor == index)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: 3,
                width: 25,
                color: Colors.greenAccent,
              ),
            ),
        ],
      ),
    );
  }
}
