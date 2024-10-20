import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trackhostel/res/constant/colors.dart';
import 'package:trackhostel/res/constant/constants.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    super.key, required this.title, required this.controller,
  });
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: kDefaultPadding*2.r,right:kDefaultPadding*2.r,bottom: kDefaultPadding*2.r ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: TextStyle(fontSize: 18.r,fontWeight: FontWeight.w700,letterSpacing: 1.5.r),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: kWhiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),  // Shadow effect
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        fillColor: kWhiteColor,
                        focusColor: kPrimaryColor,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}