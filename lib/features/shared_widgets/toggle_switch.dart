import 'package:dermo/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class ToggleSwitch extends StatefulWidget {
  const ToggleSwitch({super.key});

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: light,
      activeColor: ThemeColors.primary,
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}
