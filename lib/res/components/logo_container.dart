import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/res/constant/constants.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.r,bottom: 50.r),
      child: Row(
        children: [
          const Spacer(),
          CircleAvatar(
            radius: 100.r,
            backgroundColor: kPrimaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding*1.5.r),
                  child: Text('Hostel Track',style: TextStyle(color: kWhiteColor,fontSize: 20.r,letterSpacing: 1.5.r),),
                ),
                Image.asset(logo,height: 100.r,),
                Text('Mobile',style: TextStyle(color: kWhiteColor,fontSize: 20.r,letterSpacing: 2.r),),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
