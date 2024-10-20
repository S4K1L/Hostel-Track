import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trackhostel/res/constant/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.title, required this.onPress,
  });
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.r),
      child: Container(
        width: MediaQuery.of(context).size.width/1.2.r,
        height: MediaQuery.of(context).size.height/15.r,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kPrimaryColor
        ),
        child: TextButton(
          onPressed: onPress,
          child: Text(title,style: TextStyle(color: kWhiteColor,fontSize: 18.r,letterSpacing: 1.5.r)),
        ),
      ),
    );
  }
}
