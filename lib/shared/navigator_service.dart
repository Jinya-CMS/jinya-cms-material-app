import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState>? navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(MaterialPageRoute rn) {
    return navigationKey!.currentState!.pushReplacement(rn);
  }

  Future<dynamic> navigateTo(MaterialPageRoute rn) {
    return navigationKey!.currentState!.push(rn);
  }

  goBack({dynamic result}) {
    return navigationKey!.currentState!.pop(result);
  }
}
