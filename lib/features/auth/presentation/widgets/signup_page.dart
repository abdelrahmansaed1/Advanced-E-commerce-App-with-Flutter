import 'package:e_commerce_project/app_page.dart';
import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/core/widgets/app_text_form_field.dart';
import 'package:e_commerce_project/features/auth/presentation/widgets/signin_page.dart';
import 'package:flutter/material.dart';

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

  void submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => AppPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SigninPage()),
                      );
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
