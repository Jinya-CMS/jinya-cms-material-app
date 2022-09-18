import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jinya_cms_material_app/login.dart';
import 'package:jinya_cms_material_app/network/errors/ConflictException.dart';
import 'package:jinya_cms_material_app/network/errors/MissingApiKeyException.dart';
import 'package:jinya_cms_material_app/network/errors/MissingFieldException.dart';
import 'package:jinya_cms_material_app/network/errors/NotEnoughPermissionsException.dart';
import 'package:jinya_cms_material_app/network/errors/NotFoundException.dart';
import 'package:jinya_cms_material_app/shared/currentUser.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';

class JinyaResponse {
  dynamic data;
  int statusCode = 204;

  JinyaResponse();

  factory JinyaResponse.fromHttpResponse(http.Response response) {
    final _response = JinyaResponse();
    if (response.body != '') {
      _response.data = jsonDecode(response.body);
    }
    _response.statusCode = response.statusCode;

    if (response.statusCode == HttpStatus.badRequest) {
      throw MissingFieldsException(_response.data['validation'].keys);
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw MissingApiKeyException();
    } else if (response.statusCode == HttpStatus.notFound) {
      throw NotFoundException();
    } else if (response.statusCode == HttpStatus.forbidden) {
      NavigationService.instance.navigateTo(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
      throw NotEnoughPermissionsException();
    } else if (response.statusCode == HttpStatus.conflict) {
      throw ConflictException();
    }

    return _response;
  }
}

dynamic prepareBody(body) {
  if (body is String) {
    return body.codeUnits;
  }

  if (body is Map) {
    return jsonEncode(body).codeUnits;
  }

  return body;
}

Future<JinyaResponse> post(
  String path, {
  data,
}) async {
  final response = await http.post(
    Uri.parse('${SettingsDatabase.selectedAccount!.url}/$path'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'JinyaApiKey': SettingsDatabase.selectedAccount!.apiKey,
      'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken,
    },
    body: prepareBody(data),
  );

  return JinyaResponse.fromHttpResponse(response);
}

Future<JinyaResponse> unauthenticatedPost(
  String path, {
  data,
}) async {
  final response = await http.post(
    Uri.parse('${SettingsDatabase.selectedAccount!.url}/$path'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken,
    },
    body: prepareBody(data),
  );

  return JinyaResponse.fromHttpResponse(response);
}

Future<JinyaResponse> put(
  String path, {
  data,
}) async {
  final response = await http.put(
    Uri.parse('${SettingsDatabase.selectedAccount!.url}/$path'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'JinyaApiKey': SettingsDatabase.selectedAccount!.apiKey,
      'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken,
    },
    body: prepareBody(data),
  );

  return JinyaResponse.fromHttpResponse(response);
}

Future<JinyaResponse> unauthenticatedPut(
  String path, {
  data,
}) async {
  final response = await http.put(
    Uri.parse('${SettingsDatabase.selectedAccount!.url}/$path'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken,
    },
    body: prepareBody(data),
  );

  return JinyaResponse.fromHttpResponse(response);
}

Future<JinyaResponse> get(String path) async {
  final response = await http.get(Uri.parse('${SettingsDatabase.selectedAccount!.url}/$path'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    'JinyaApiKey': SettingsDatabase.selectedAccount!.apiKey,
    'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken,
  });

  return JinyaResponse.fromHttpResponse(response);
}

Future<JinyaResponse> unauthenticatedGet(String path) async {
  final response = await http.get(Uri.parse('${SettingsDatabase.selectedAccount!.url}/$path'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken,
  });

  return JinyaResponse.fromHttpResponse(response);
}

Future<int> head(String path) async {
  final response = await http.head(Uri.parse('${SettingsDatabase.selectedAccount!.url}/$path'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    'JinyaApiKey': SettingsDatabase.selectedAccount!.apiKey,
    'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken,
  });

  return response.statusCode;
}

Future<int> unauthenticatedHead(String path) async {
  final response = await http.head(Uri.parse('${SettingsDatabase.selectedAccount!.url}/$path'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken,
  });

  return response.statusCode;
}

Future<JinyaResponse> delete(String path) async {
  final response = await http.delete(Uri.parse('${SettingsDatabase.selectedAccount!.url}/$path'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    'JinyaApiKey': SettingsDatabase.selectedAccount!.apiKey,
    'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken,
  });

  return JinyaResponse.fromHttpResponse(response);
}

Future<JinyaResponse> unauthenticatedDelete(String path) async {
  final response = await http.delete(Uri.parse('${SettingsDatabase.selectedAccount!.url}/$path'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    'JinyaDeviceCode': SettingsDatabase.selectedAccount!.deviceToken,
  });

  return JinyaResponse.fromHttpResponse(response);
}
