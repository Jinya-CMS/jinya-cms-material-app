import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jinya_cms_material_app/network/base/jinyaRequest.dart';
import 'package:jinya_cms_material_app/shared/currentUser.dart';

mixin BadCredentialsException implements Exception {}

class LoginResult {
  final String apiKey;
  final String deviceCode;
  final List<String> roles;

  LoginResult(this.apiKey, this.deviceCode, this.roles);

  factory LoginResult.fromMap(Map<String, dynamic> data) {
    final roles = <String>[];
    final rolesFromMap = data['roles'];
    for (final role in rolesFromMap) {
      roles.add(role.toString());
    }

    return LoginResult(
      data['apiKey'],
      data['deviceCode'],
      roles,
    );
  }
}

Future<bool> checkApiKey(String apiKey) async {
  try {
    final response = await head('api/login');
    if (response != HttpStatus.noContent) {
      return false;
    }

    return true;
  } catch (ex) {
    return false;
  }
}

Future<void> requestTwoFactorCode(
  String username,
  String password, {
  String? host,
}) async {
  var data = {
    'username': username,
    'password': password,
  };
  final target = host ?? SettingsDatabase.selectedAccount!.url;
  final response = await http.post(
    Uri.parse('$target/api/2fa'),
    body: jsonEncode(data).codeUnits,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
  if (response.statusCode != HttpStatus.noContent) {
    throw BadCredentialsException;
  }
}

Future<LoginResult> login(
  String username,
  String password, {
  String? host,
  String? twoFactorCode,
}) async {
  var data = {
    'username': username,
    'password': password,
  };
  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  if (twoFactorCode != null) {
    data.addAll({'twoFactorCode': twoFactorCode});
  } else {
    headers.addAll(
        {'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken});
  }
  final target = host ?? SettingsDatabase.selectedAccount!.url;
  final response = await http.post(
    Uri.parse('$target/api/login'),
    body: jsonEncode(data).codeUnits,
    headers: headers,
  );

  return LoginResult.fromMap(jsonDecode(response.body));
}
