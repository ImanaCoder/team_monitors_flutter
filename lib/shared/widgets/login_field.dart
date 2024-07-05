import 'package:flutter/material.dart';
import 'package:team_monitor/helpers/color_extension.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keywordtype;
  final bool obscureText;

  const LoginField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keywordtype,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 360,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keywordtype,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: TeamMonitorColor.borderColor),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: TeamMonitorColor.primaryColor1),
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: hintText,
            hintStyle:
                TextStyle(color: TeamMonitorColor.blackColor.withOpacity(0.8))),
        style: TextStyle(
            color: TeamMonitorColor.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
    );
  }
}
