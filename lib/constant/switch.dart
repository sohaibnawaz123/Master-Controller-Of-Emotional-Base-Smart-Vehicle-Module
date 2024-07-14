import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class SwitchButton extends StatelessWidget {
  final Color activecolor;
  final Widget activeIcon;
  final Color inactivecolor;
  final Widget inactiveIcon;
  final ValueNotifier<bool>? controller;
  final Function(dynamic) onChange;
  const SwitchButton({
    super.key,
    required this.activecolor,
    required this.inactivecolor,
    required this.controller,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      activeColor: activecolor,
      inactiveColor: inactivecolor,
      activeChild: activeIcon,
      inactiveChild: inactiveIcon,
      width: 65,
      borderRadius: BorderRadius.circular(10),
      controller: controller,
      onChanged:onChange ,
    );
  }
}
