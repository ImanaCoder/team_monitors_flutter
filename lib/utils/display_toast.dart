import 'package:team_monitor/core/navigation_service.dart';
import 'package:team_monitor/core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  var fToast = FToast();
  AppToast() {
    fToast.init(sl<NavigationService>().navigatorKey.currentContext!);
  }

  void success(String msg) {
    fToast.showToast(
      child: _Toast(message: msg),
      gravity: ToastGravity.CENTER,
    );
  }

  void error(String msg) {
    fToast.showToast(
      child: _Toast(message: msg, isSuccess: false),
      gravity: ToastGravity.CENTER,
    );
  }
}

class _Toast extends StatelessWidget {
  final String message;
  final bool isSuccess;
  const _Toast({required this.message, this.isSuccess = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: isSuccess ? Colors.green : Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isSuccess ? Icons.check : Icons.close, color: Colors.white, size: 20),
          const SizedBox(width: 8.0),
          Expanded(child: Text(message, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
