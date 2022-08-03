import 'package:flutter/material.dart';

class ThemeSwitch extends StatelessWidget {
  final Widget? child;
  final bool isDark;
  final VoidCallback? onToggle;

  const ThemeSwitch({
    Key? key,
    this.isDark = false,
    this.child,
    this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = this.child;
    return Material(
      child: Stack(
        children: [
          if (child != null) child,
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: IconButton(
                  icon: Icon(
                    isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round,
                  ),
                  onPressed: () => onToggle?.call(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
