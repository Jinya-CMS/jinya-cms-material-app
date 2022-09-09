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

  static String m0(name) => "Soll die Datei ${name} wirklich gelöscht werden?";

  static String m1(name) =>
      "Soll die Galerie ${name} wirklich gelöscht werden?";

  static String m2(name) =>
      "Die Datei ${name} konnte nicht gelöscht werden, da sie verwendet wird";

  static String m3(name) => "Die Datei ${name} konnte nicht gelöscht werden";

  static String m4(name) =>
      "Die Galerie ${name} konnte nicht gelöscht werden, da sie verwendet wird";

  static String m5(name) => "Die Galerie ${name} konnte nicht gelöscht werden";

  static String m6(name) => "Die Datei ${name} konnte nicht hochgeladen werden";

  static String m7(name) => "Account ${name} wurde erfolgreich gelöscht";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionUndo": MessageLookupByLibrary.simpleMessage("Rückgängig"),
        "appName": MessageLookupByLibrary.simpleMessage("Jinya CMS"),
        "chooseFiles":
            MessageLookupByLibrary.simpleMessage("Dateien wählen..."),
        "createGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Galerie anlegen"),
        "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "deleteFileMessage": m0,
        "deleteFileTitle":
            MessageLookupByLibrary.simpleMessage("Datei löschen?"),
        "deleteGalleryMessage": m1,
        "deleteGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Galerie löschen?"),
        "discard": MessageLookupByLibrary.simpleMessage("Änderungen verwerfen"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Schließen"),
        "editFileCancel":
            MessageLookupByLibrary.simpleMessage("Änderungen verwerfen"),
        "editFileName": MessageLookupByLibrary.simpleMessage("Name"),
        "editFileNameEmpty":
            MessageLookupByLibrary.simpleMessage("Der Name ist erforderlich"),
        "editFileSave": MessageLookupByLibrary.simpleMessage("Datei speichern"),
        "editFileTitle":
            MessageLookupByLibrary.simpleMessage("Datei bearbeiten"),
        "editGalleryNameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Der Name ist erforderlich"),
        "editGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Galerie bearbeiten"),
        "failedToDeleteFileConflict": m2,
        "failedToDeleteFileGeneric": m3,
        "failedToDeleteGalleryConflict": m4,
        "failedToDeleteGalleryGeneric": m5,
        "failedUploading": m6,
        "galleryAddConflict": MessageLookupByLibrary.simpleMessage(
            "Eine Galerie mit dem gewählten Namen existiert bereits"),
        "galleryAddGeneric": MessageLookupByLibrary.simpleMessage(
            "Die Galerie konnte nicht gespeichert werden"),
        "galleryDescription":
            MessageLookupByLibrary.simpleMessage("Beschreibung"),
        "galleryEditConflict": MessageLookupByLibrary.simpleMessage(
            "Eine Galerie mit dem gewählten Namen existiert bereits"),
        "galleryEditGeneric": MessageLookupByLibrary.simpleMessage(
            "Die Galerie konnte nicht gespeichert werden"),
        "galleryName": MessageLookupByLibrary.simpleMessage("Name"),
        "galleryOrientation":
            MessageLookupByLibrary.simpleMessage("Orientierung"),
        "galleryOrientationHorizontal":
            MessageLookupByLibrary.simpleMessage("Horizontal"),
        "galleryOrientationVertical":
            MessageLookupByLibrary.simpleMessage("Vertikal"),
        "galleryType": MessageLookupByLibrary.simpleMessage("Typ"),
        "galleryTypeGrid": MessageLookupByLibrary.simpleMessage("Raster"),
        "galleryTypeList": MessageLookupByLibrary.simpleMessage("Liste"),
        "keep": MessageLookupByLibrary.simpleMessage("Nicht löschen"),
        "loginActionLogin": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "loginEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "loginInstance": MessageLookupByLibrary.simpleMessage("Jinya Host"),
        "loginInvalidCredentials": MessageLookupByLibrary.simpleMessage(
            "Die Zugangsdaten für den Account sind falsch"),
        "loginPassword": MessageLookupByLibrary.simpleMessage("Passwort"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "manageAccountsDeleteSuccess": m7,
        "manageAccountsTitle":
            MessageLookupByLibrary.simpleMessage("Accounts verwalten"),
        "manageFilesTitle": MessageLookupByLibrary.simpleMessage("Dateien"),
        "manageGalleriesTitle":
            MessageLookupByLibrary.simpleMessage("Galerien"),
        "menuAddAccount":
            MessageLookupByLibrary.simpleMessage("Account hinzufügen"),
        "menuManageAccounts":
            MessageLookupByLibrary.simpleMessage("Accounts verwalten"),
        "menuManageFiles": MessageLookupByLibrary.simpleMessage("Dateien"),
        "menuManageGalleries": MessageLookupByLibrary.simpleMessage("Galerien"),
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
            MessageLookupByLibrary.simpleMessage("Zwei Faktor Code"),
        "saveFailed":
            MessageLookupByLibrary.simpleMessage("Speichern fehlgeschlagen"),
        "saveGallery":
            MessageLookupByLibrary.simpleMessage("Galerie speichern"),
        "uploadFiles":
            MessageLookupByLibrary.simpleMessage("Dateien hochladen"),
        "uploadingFiles":
            MessageLookupByLibrary.simpleMessage("Dateien hochladen...")
      };
}
