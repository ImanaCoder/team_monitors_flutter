import 'package:flutter/material.dart';

class NavigationService {
  var navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToLogin() {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil('/users/login', (route) => false);
  }

  Future<dynamic> navigateToDashboard() {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil('/dashboard', (route) => false);
  }
}
