import 'package:e_commerce_project/core/services/app_preferences.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/utils/validators.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final confirmController = TextEditingController();

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final prefs = Provider.of<AppPreferences>(context, listen: false);
      await prefs.setAuthenticated(true);
      await prefs.setUserName(nameController.text);
      await prefs.setUserEmail(emailController.text);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.screens);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sign Up", style: Theme.of(context).textTheme.displayLarge),
              SizedBox(height: 20),
              AppTextFormField(
                label: 'name',
                controller: nameController,
                validator: (str) =>
                    Validators.validateName(str, 'This field is required'),
              ),
              SizedBox(height: 20),
              AppTextFormField(
                label: 'email',
                controller: emailController,
                validator: (str) => Validators.validateEmail(
                  str,
                  'This field is required',
                  'Invalid email',
                ),
              ),
              SizedBox(height: 20),

              AppTextFormField(
                label: 'password',
                controller: passController,
                isPassword: true,
                validator: (str) => Validators.validatePassword(
                  str,
                  'This field is required',
                  'Min 6 characters',
                ),
              ),
              SizedBox(height: 20),
              AppTextFormField(
                label: 'confirm password',
                controller: confirmController,
                isPassword: true,
                validator: (str) => Validators.validateConfirmPassword(
                  str,
                  passController.text,
                  'This field is required',
                  'Passwords do not match',
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                child: AppElevatedButton(text: 'Sign Up', onPressed: submit),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.signin);
                    },
                    child: Text('Sign in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
