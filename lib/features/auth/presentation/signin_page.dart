import 'package:e_commerce_project/core/utils/validators.dart';
import 'package:e_commerce_project/features/auth/provider/auth_provider.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final succes = await authProvider.login(
        email: emailController.text,
        password: passController.text,
      );

      if (!mounted) return;
      if (succes) {
        Navigator.pushReplacementNamed(context, AppRoutes.screens);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.errorMessage ?? 'Login Failed')),
        );
      }
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
                child: Consumer<AuthProvider>(
                  builder: (context, auth, _) {
                    return auth.state == AuthState.loading
                        ? Center(child: CircularProgressIndicator())
                        : AppElevatedButton(text: 'Sign in', onPressed: submit);
                  },
                ),
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
                      Navigator.pushReplacementNamed(context, AppRoutes.signup);
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
