import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/theme/custom_border.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      AppImages.personal,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  AppImages.cameraSvg(height: 16, width: 16),
                  SizedBox(width: 16),

                  Text(
                    'Upload new photo',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'NAME',
                  border: CustomBorder(),
                ),
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: CustomBorder(),
                ),
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  border: CustomBorder(),
                ),
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'location',
                  border: CustomBorder(),
                ),
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppElevatedButton(text: 'SAVE changes', onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
