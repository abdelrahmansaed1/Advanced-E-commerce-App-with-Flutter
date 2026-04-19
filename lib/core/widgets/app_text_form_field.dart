import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?) validator;
  const AppTextFormField({
    super.key,
    required this.label,
    this.isPassword = false,
    required this.controller,
    required this.validator,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? obscure : false,
      validator: widget.validator,
      keyboardType: TextInputType.emailAddress,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: widget.label.toUpperCase(),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
              )
            : (widget.controller.text.isNotEmpty
                  ? const Icon(Icons.check, size: 20)
                  : null),
      ),
    );
  }
}
