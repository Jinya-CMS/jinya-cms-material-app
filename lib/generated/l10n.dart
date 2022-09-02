// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Jinya CMS`
  String get appName {
    return Intl.message(
      'Jinya CMS',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Manage accounts`
  String get manageAccountsTitle {
    return Intl.message(
      'Manage accounts',
      name: 'manageAccountsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Undo`
  String get actionUndo {
    return Intl.message(
      'Undo',
      name: 'actionUndo',
      desc: '',
      args: [],
    );
  }

  /// `Account {name} successfully deleted`
  String manageAccountsDeleteSuccess(Object name) {
    return Intl.message(
      'Account $name successfully deleted',
      name: 'manageAccountsDeleteSuccess',
      desc: '',
      args: [name],
    );
  }

  /// `An account for that site already exists`
  String get newAccountErrorExists {
    return Intl.message(
      'An account for that site already exists',
      name: 'newAccountErrorExists',
      desc: '',
      args: [],
    );
  }

  /// `The credentials for the account are wrong`
  String get newAccountErrorInvalidCredentials {
    return Intl.message(
      'The credentials for the account are wrong',
      name: 'newAccountErrorInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `New account`
  String get newAccountTitle {
    return Intl.message(
      'New account',
      name: 'newAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `The URL is invalid`
  String get newAccountErrorInvalidUrl {
    return Intl.message(
      'The URL is invalid',
      name: 'newAccountErrorInvalidUrl',
      desc: '',
      args: [],
    );
  }

  /// `The email address is invalid`
  String get newAccountErrorInvalidEmail {
    return Intl.message(
      'The email address is invalid',
      name: 'newAccountErrorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Jinya host`
  String get newAccountInputJinyaHost {
    return Intl.message(
      'Jinya host',
      name: 'newAccountInputJinyaHost',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get newAccountInputEmail {
    return Intl.message(
      'Email',
      name: 'newAccountInputEmail',
      desc: '',
      args: [],
    );
  }

  /// `The password must not be empty`
  String get newAccountErrorInvalidPassword {
    return Intl.message(
      'The password must not be empty',
      name: 'newAccountErrorInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get newAccountInputPassword {
    return Intl.message(
      'Password',
      name: 'newAccountInputPassword',
      desc: '',
      args: [],
    );
  }

  /// `Request two factor code`
  String get newAccountActionTwoFactorCode {
    return Intl.message(
      'Request two factor code',
      name: 'newAccountActionTwoFactorCode',
      desc: '',
      args: [],
    );
  }

  /// `The two factor code is invalid`
  String get newAccountTwoFactorErrorInvalidCode {
    return Intl.message(
      'The two factor code is invalid',
      name: 'newAccountTwoFactorErrorInvalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Two factor code`
  String get newAccountTwoFactorInputCode {
    return Intl.message(
      'Two factor code',
      name: 'newAccountTwoFactorInputCode',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get newAccountTwoFactorActionLogin {
    return Intl.message(
      'Login',
      name: 'newAccountTwoFactorActionLogin',
      desc: '',
      args: [],
    );
  }

  /// `Add account`
  String get menuAddAccount {
    return Intl.message(
      'Add account',
      name: 'menuAddAccount',
      desc: '',
      args: [],
    );
  }

  /// `Manage accounts`
  String get menuManageAccounts {
    return Intl.message(
      'Manage accounts',
      name: 'menuManageAccounts',
      desc: '',
      args: [],
    );
  }

  /// `Jinya host`
  String get loginInstance {
    return Intl.message(
      'Jinya host',
      name: 'loginInstance',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginEmail {
    return Intl.message(
      'Email',
      name: 'loginEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPassword {
    return Intl.message(
      'Password',
      name: 'loginPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginActionLogin {
    return Intl.message(
      'Login',
      name: 'loginActionLogin',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginTitle {
    return Intl.message(
      'Login',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your credentials are invalid`
  String get loginInvalidCredentials {
    return Intl.message(
      'Your credentials are invalid',
      name: 'loginInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Switch account`
  String get menuSwitchAccount {
    return Intl.message(
      'Switch account',
      name: 'menuSwitchAccount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
