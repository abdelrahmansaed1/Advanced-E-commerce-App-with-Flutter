// lib/core/widgets/color_selector.dart

import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final List<Color> colors;
  final Color? initialSelectedColor;
  final Function(Color) onColorSelected;

  const ColorSelector({
    super.key,
    required this.colors,
    this.initialSelectedColor,
    required this.onColorSelected,
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialSelectedColor ?? widget.colors.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Color",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Row(
          children: widget.colors.map((color) {
            final bool isSelected = selectedColor == color;

            return GestureDetector(
              onTap: () {
                setState(() => selectedColor = color);
                widget.onColorSelected(color);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: isSelected
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          color: AppTheme.backgroundColor,
                          size: 24,
                          shadows: [
                            Shadow(color: Colors.black26, blurRadius: 4),
                          ],
                        ),
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
