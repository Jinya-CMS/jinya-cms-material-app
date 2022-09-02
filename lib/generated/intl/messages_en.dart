// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Account ${name} successfully deleted";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionUndo": MessageLookupByLibrary.simpleMessage("Undo"),
        "appName": MessageLookupByLibrary.simpleMessage("Jinya CMS"),
        "loginActionLogin": MessageLookupByLibrary.simpleMessage("Login"),
        "loginEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "loginInstance": MessageLookupByLibrary.simpleMessage("Jinya host"),
        "loginInvalidCredentials": MessageLookupByLibrary.simpleMessage(
            "Your credentials are invalid"),
        "loginPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
        "manageAccountsDeleteSuccess": m0,
        "manageAccountsTitle":
            MessageLookupByLibrary.simpleMessage("Manage accounts"),
        "menuAddAccount": MessageLookupByLibrary.simpleMessage("Add account"),
        "menuManageAccounts":
            MessageLookupByLibrary.simpleMessage("Manage accounts"),
        "menuSwitchAccount":
            MessageLookupByLibrary.simpleMessage("Switch account"),
        "newAccountActionTwoFactorCode":
            MessageLookupByLibrary.simpleMessage("Request two factor code"),
        "newAccountErrorExists": MessageLookupByLibrary.simpleMessage(
            "An account for that site already exists"),
        "newAccountErrorInvalidCredentials":
            MessageLookupByLibrary.simpleMessage(
                "The credentials for the account are wrong"),
        "newAccountErrorInvalidEmail": MessageLookupByLibrary.simpleMessage(
            "The email address is invalid"),
        "newAccountErrorInvalidPassword": MessageLookupByLibrary.simpleMessage(
            "The password must not be empty"),
        "newAccountErrorInvalidUrl":
            MessageLookupByLibrary.simpleMessage("The URL is invalid"),
        "newAccountInputEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "newAccountInputJinyaHost":
            MessageLookupByLibrary.simpleMessage("Jinya host"),
        "newAccountInputPassword":
            MessageLookupByLibrary.simpleMessage("Password"),
        "newAccountTitle": MessageLookupByLibrary.simpleMessage("New account"),
        "newAccountTwoFactorActionLogin":
            MessageLookupByLibrary.simpleMessage("Login"),
        "newAccountTwoFactorErrorInvalidCode":
            MessageLookupByLibrary.simpleMessage(
                "The two factor code is invalid"),
        "newAccountTwoFactorInputCode":
            MessageLookupByLibrary.simpleMessage("Two factor code")
      };
}
