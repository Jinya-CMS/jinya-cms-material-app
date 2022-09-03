import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState>? navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(MaterialPageRoute _rn) {
    return navigationKey!.currentState!.pushReplacement(_rn);
  }

  Future<dynamic> navigateTo(MaterialPageRoute _rn) {
    return navigationKey!.currentState!.push(_rn);
  }

  goBack() {
    return navigationKey!.currentState!.pop();
  }
}
