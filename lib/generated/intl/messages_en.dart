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

  static String m0(name) => "Do you really want to delete the file ${name}?";

  static String m1(name) => "Do you really want to delete the gallery ${name}?";

  static String m2(name) => "The file ${name} is in use and cannot be deleted";

  static String m3(name) => "The file ${name} could not be deleted";

  static String m4(name) =>
      "The gallery ${name} is in use and cannot be deleted";

  static String m5(name) => "The gallery ${name} could not be deleted";

  static String m6(name) => "Failed to upload file ${name}";

  static String m7(name) => "Arrange ${name}";

  static String m8(name) => "Account ${name} successfully deleted";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionUndo": MessageLookupByLibrary.simpleMessage("Undo"),
        "appName": MessageLookupByLibrary.simpleMessage("Jinya CMS"),
        "chooseFiles": MessageLookupByLibrary.simpleMessage("Choose files..."),
        "createGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Create gallery"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteFileMessage": m0,
        "deleteFileTitle": MessageLookupByLibrary.simpleMessage("Delete file?"),
        "deleteGalleryMessage": m1,
        "deleteGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Delete gallery?"),
        "discard": MessageLookupByLibrary.simpleMessage("Discard changes"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
        "editFileCancel":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "editFileName": MessageLookupByLibrary.simpleMessage("Name"),
        "editFileNameEmpty":
            MessageLookupByLibrary.simpleMessage("Name cannot be empty"),
        "editFileSave": MessageLookupByLibrary.simpleMessage("Save file"),
        "editFileTitle": MessageLookupByLibrary.simpleMessage("Edit file"),
        "editGalleryNameCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "The gallery name cannot be empty"),
        "editGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Edit gallery"),
        "failedToDeleteFileConflict": m2,
        "failedToDeleteFileGeneric": m3,
        "failedToDeleteGalleryConflict": m4,
        "failedToDeleteGalleryGeneric": m5,
        "failedUploading": m6,
        "galleryAddConflict": MessageLookupByLibrary.simpleMessage(
            "A gallery with the given name already exists"),
        "galleryAddGeneric": MessageLookupByLibrary.simpleMessage(
            "The gallery could not be saved"),
        "galleryDescription":
            MessageLookupByLibrary.simpleMessage("Description"),
        "galleryDesigner": m7,
        "galleryEditConflict": MessageLookupByLibrary.simpleMessage(
            "A gallery with the given name already exists"),
        "galleryEditGeneric": MessageLookupByLibrary.simpleMessage(
            "The gallery could not be saved"),
        "galleryName": MessageLookupByLibrary.simpleMessage("Name"),
        "galleryOrientation":
            MessageLookupByLibrary.simpleMessage("Orientation"),
        "galleryOrientationHorizontal":
            MessageLookupByLibrary.simpleMessage("Horizontal"),
        "galleryOrientationVertical":
            MessageLookupByLibrary.simpleMessage("Vertical"),
        "galleryType": MessageLookupByLibrary.simpleMessage("Type"),
        "galleryTypeGrid": MessageLookupByLibrary.simpleMessage("Grid"),
        "galleryTypeList": MessageLookupByLibrary.simpleMessage("List"),
        "keep": MessageLookupByLibrary.simpleMessage("Don\'t delete"),
        "loginActionLogin": MessageLookupByLibrary.simpleMessage("Login"),
        "loginEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "loginInstance": MessageLookupByLibrary.simpleMessage("Jinya host"),
        "loginInvalidCredentials": MessageLookupByLibrary.simpleMessage(
            "Your credentials are invalid"),
        "loginPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
        "manageAccountsDeleteSuccess": m8,
        "manageAccountsTitle":
            MessageLookupByLibrary.simpleMessage("Manage accounts"),
        "manageFilesTitle": MessageLookupByLibrary.simpleMessage("Files"),
        "manageGalleriesTitle":
            MessageLookupByLibrary.simpleMessage("Galleries"),
        "menuAddAccount": MessageLookupByLibrary.simpleMessage("Add account"),
        "menuManageAccounts":
            MessageLookupByLibrary.simpleMessage("Manage accounts"),
        "menuManageFiles": MessageLookupByLibrary.simpleMessage("Files"),
        "menuManageGalleries":
            MessageLookupByLibrary.simpleMessage("Galleries"),
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
            MessageLookupByLibrary.simpleMessage("Two factor code"),
        "saveFailed": MessageLookupByLibrary.simpleMessage("Save failed"),
        "saveGallery": MessageLookupByLibrary.simpleMessage("Save gallery"),
        "uploadFiles": MessageLookupByLibrary.simpleMessage("Upload files"),
        "uploadingFiles":
            MessageLookupByLibrary.simpleMessage("Uploading files...")
      };
}
