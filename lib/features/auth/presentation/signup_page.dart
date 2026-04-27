import 'package:e_commerce_project/core/services/app_preferences.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return "Enter your name";
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Enter email";
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Invalid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return "Min 6 characters";
    }
    return null;
  }

  String? validateConfirm(String? value) {
    if (value != passController.text) {
      return "Passwords do not match";
    }
    return null;
  }

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
                validator: validateName,
              ),
              SizedBox(height: 20),
              AppTextFormField(
                label: 'email',
                controller: emailController,
                validator: validateEmail,
              ),
              SizedBox(height: 20),

              AppTextFormField(
                label: 'password',
                controller: passController,
                isPassword: true,
                validator: validatePassword,
              ),
              SizedBox(height: 20),
              AppTextFormField(
                label: 'confirm password',
                controller: confirmController,
                isPassword: true,
                validator: validateConfirm,
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
