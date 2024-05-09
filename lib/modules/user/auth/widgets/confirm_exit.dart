import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

Future<bool?> confirmExit(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        icon: SvgPicture.asset('assets/svg/logo.svg', height: 60),
        content: const Text("Are you sure to close?"),
        actions: [
          TextButton(
            child: const Text("No"),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            child: const Text("Yes"),
            onPressed: () async {
              Navigator.pop(context, true);
              SystemNavigator.pop();
              // Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
