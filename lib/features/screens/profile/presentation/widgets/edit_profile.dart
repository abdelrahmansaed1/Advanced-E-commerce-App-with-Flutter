import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/theme/custom_border.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: AppTextStyles.headlineSmall),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      AppImages.personal,
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  AppImages.cameraSvg(height: 16.h, width: 16.w),
                  SizedBox(width: 16.w),

                  Text('Upload new photo', style: AppTextStyles.bodyMedium),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'NAME',
                  border: CustomBorder(),
                ),
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: CustomBorder(),
                ),
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  border: CustomBorder(),
                ),
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'location',
                  border: CustomBorder(),
                ),
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: AppElevatedButton(text: 'SAVE changes', onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
