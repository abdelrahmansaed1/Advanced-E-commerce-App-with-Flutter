import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? color;
  const AppElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: color != null
          ? BoxDecoration(
              color: color,
              border: Border.all(color: AppTheme.primaryColor),
              borderRadius: BorderRadius.circular(5),
            )
          : BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor, Colors.black],
              ),
            ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style,

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: color != null
              ? Text(
                  text.toUpperCase(),
                  style: TextStyle(color: AppTheme.primaryColor),
                )
              : Text(text.toUpperCase()),
        ),
      ),
    );
  }
}
