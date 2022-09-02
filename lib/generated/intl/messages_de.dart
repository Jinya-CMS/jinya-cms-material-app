// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(name) => "Account ${name} wurde erfolgreich gelöscht";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionUndo": MessageLookupByLibrary.simpleMessage("Rückgängig"),
        "appName": MessageLookupByLibrary.simpleMessage("Jinya CMS"),
        "loginActionLogin": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "loginEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "loginInstance": MessageLookupByLibrary.simpleMessage("Jinya Host"),
        "loginPassword": MessageLookupByLibrary.simpleMessage("Passwort"),
        "manageAccountsDeleteSuccess": m0,
        "manageAccountsTitle":
            MessageLookupByLibrary.simpleMessage("Accounts verwalten"),
        "menuAddAccount":
            MessageLookupByLibrary.simpleMessage("Account hinzufügen"),
        "menuManageAccounts":
            MessageLookupByLibrary.simpleMessage("Accounts verwalten"),
        "menuSwitchAccount":
            MessageLookupByLibrary.simpleMessage("Account wechseln"),
        "newAccountActionTwoFactorCode":
            MessageLookupByLibrary.simpleMessage("Zwei Faktor Code anfragen"),
        "newAccountErrorExists": MessageLookupByLibrary.simpleMessage(
            "Ein Account für diese Seite existiert bereits"),
        "newAccountErrorInvalidCredentials":
            MessageLookupByLibrary.simpleMessage(
                "Die Zugangsdaten für den Account sind falsch"),
        "newAccountErrorInvalidEmail": MessageLookupByLibrary.simpleMessage(
            "Die Emailadresse ist ungültig"),
        "newAccountErrorInvalidPassword": MessageLookupByLibrary.simpleMessage(
            "Das Passwort darf nicht leer sein"),
        "newAccountErrorInvalidUrl":
            MessageLookupByLibrary.simpleMessage("Die URL ist ungültig"),
        "newAccountInputEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "newAccountInputJinyaHost":
            MessageLookupByLibrary.simpleMessage("Jinya Host"),
        "newAccountInputPassword":
            MessageLookupByLibrary.simpleMessage("Passwort"),
        "newAccountTitle":
            MessageLookupByLibrary.simpleMessage("Neuer Account"),
        "newAccountTwoFactorActionLogin":
            MessageLookupByLibrary.simpleMessage("Anmelden"),
        "newAccountTwoFactorErrorInvalidCode":
            MessageLookupByLibrary.simpleMessage(
                "Der Zwei Faktor Code ist ungültig"),
        "newAccountTwoFactorInputCode":
            MessageLookupByLibrary.simpleMessage("Zwei Faktor Code")
      };
}
