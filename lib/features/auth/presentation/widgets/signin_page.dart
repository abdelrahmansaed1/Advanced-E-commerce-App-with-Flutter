import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/core/widgets/app_text_form_field.dart';
import 'package:e_commerce_project/features/auth/presentation/widgets/signup_page.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  final emailController = TextEditingController();
  final passController = TextEditingController();

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

  void submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Sign in success")));
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
              Text(
                'Welcome Back!',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 10),
              Text(
                'Sign in to continue',
                style: Theme.of(context).textTheme.titleMedium,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // remember me
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      Text('Remember me'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                child: AppElevatedButton(text: 'Sign in', onPressed: submit),
              ),
              // Don't have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
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
