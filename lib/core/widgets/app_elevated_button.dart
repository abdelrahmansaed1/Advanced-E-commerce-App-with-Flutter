import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const AppElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppTheme.primaryColor, Colors.black]),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style,

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(text.toUpperCase()),
        ),
      ),
    );
  }
}
