import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget? icon;
  final List<Widget>? actions;
  const AppHeader({
    super.key,
    required this.title,
    this.subTitle,
    this.icon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: const BoxDecoration(
        // gradient: LinearGradient(colors: [Color(0xFF1E0A9C), Color.fromARGB(250, 16, 168, 40)]),
        color: Color(0xFFECF2FF),
      ),
      child: Row(
        children: [
          if (icon != null) icon!,
          if (icon != null) const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF2D3B8A),
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (actions != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(children: actions!),
            ),
        ],
      ),
    );
  }
}
