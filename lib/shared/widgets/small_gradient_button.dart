import 'package:flutter/material.dart';
import 'package:team_monitor/helpers/color_extension.dart';
import 'package:team_monitor/helpers/size__config.dart';

class SmallGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const SmallGradientButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.screenWidth * 0.3,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: TeamMonitorColor.primaryG,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
