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

  static String m1(title) => "Do you really want to delete the form ${title}?";

  static String m2(name) => "Do you really want to delete the gallery ${name}?";

  static String m3(title) => "Do you really want to delete the page ${title}?";

  static String m4(title) => "Do you really want to delete the page ${title}?";

  static String m5(name) => "The file ${name} is in use and cannot be deleted";

  static String m6(name) => "The file ${name} could not be deleted";

  static String m7(title) =>
      "The form ${title} is in use and cannot be deleted";

  static String m8(title) => "The form ${title} could not be deleted";

  static String m9(name) =>
      "The gallery ${name} is in use and cannot be deleted";

  static String m10(name) => "The gallery ${name} could not be deleted";

  static String m11(title) =>
      "The page ${title} is in use and cannot be deleted";

  static String m12(title) => "The page ${title} could not be deleted";

  static String m13(title) =>
      "The page ${title} is in use and cannot be deleted";

  static String m14(title) => "The page ${title} could not be deleted";

  static String m15(name) => "Failed to upload file ${name}";

  static String m16(title) => "Arrange ${title}";

  static String m17(name) => "Arrange ${name}";

  static String m18(name) => "Account ${name} successfully deleted";

  static String m19(name) => "Arrange ${name}";

  static String m20(count) => "Segment count: ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionUndo": MessageLookupByLibrary.simpleMessage("Undo"),
        "addFormCancel":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "addFormItemCheckbox": MessageLookupByLibrary.simpleMessage("Checkbox"),
        "addFormItemDropdown": MessageLookupByLibrary.simpleMessage("Dropdown"),
        "addFormItemEmail": MessageLookupByLibrary.simpleMessage("Email input"),
        "addFormItemMultiline":
            MessageLookupByLibrary.simpleMessage("Multiline input"),
        "addFormItemText": MessageLookupByLibrary.simpleMessage("Text input"),
        "addFormSave": MessageLookupByLibrary.simpleMessage("Save form"),
        "addFormTitle": MessageLookupByLibrary.simpleMessage("Add form"),
        "addFormTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The title cannot be empty"),
        "addFormToAddressCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "The to address cannot be empty"),
        "addFormToAddressWrongFormat": MessageLookupByLibrary.simpleMessage(
            "The to address must be an email"),
        "addSegmentPage": MessageLookupByLibrary.simpleMessage("Add page"),
        "addSegmentPageCancel":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "addSegmentPageSave":
            MessageLookupByLibrary.simpleMessage("Create page"),
        "addSegmentPageTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage(
                "The page name cannot be empty"),
        "addSegmentTypeFile": MessageLookupByLibrary.simpleMessage("Add file"),
        "addSegmentTypeGallery":
            MessageLookupByLibrary.simpleMessage("Add gallery"),
        "addSegmentTypeHtml":
            MessageLookupByLibrary.simpleMessage("Add formatted text"),
        "addSimplePage": MessageLookupByLibrary.simpleMessage("Add page"),
        "addSimplePageTitleCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "The page title cannot be empty"),
        "appName": MessageLookupByLibrary.simpleMessage("Jinya CMS"),
        "chooseFiles": MessageLookupByLibrary.simpleMessage("Choose files..."),
        "createGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Create gallery"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteFileMessage": m0,
        "deleteFileTitle": MessageLookupByLibrary.simpleMessage("Delete file?"),
        "deleteFormMessage": m1,
        "deleteFormTitle": MessageLookupByLibrary.simpleMessage("Delete form?"),
        "deleteGalleryMessage": m2,
        "deleteGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Delete gallery?"),
        "deleteSegmentPageMessage": m3,
        "deleteSegmentPageTitle":
            MessageLookupByLibrary.simpleMessage("Delete page?"),
        "deleteSimplePageMessage": m4,
        "deleteSimplePageTitle":
            MessageLookupByLibrary.simpleMessage("Delete page?"),
        "discard": MessageLookupByLibrary.simpleMessage("Discard changes"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
        "editFileCancel":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "editFileName": MessageLookupByLibrary.simpleMessage("Name"),
        "editFileNameEmpty":
            MessageLookupByLibrary.simpleMessage("Name cannot be empty"),
        "editFileSave": MessageLookupByLibrary.simpleMessage("Save file"),
        "editFileTitle": MessageLookupByLibrary.simpleMessage("Edit file"),
        "editFormCancel":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "editFormItemHelpText":
            MessageLookupByLibrary.simpleMessage("Help text"),
        "editFormItemIsFromAddress":
            MessageLookupByLibrary.simpleMessage("Is from address"),
        "editFormItemIsRequired":
            MessageLookupByLibrary.simpleMessage("Is required"),
        "editFormItemIsSubject":
            MessageLookupByLibrary.simpleMessage("Is subject"),
        "editFormItemLabel": MessageLookupByLibrary.simpleMessage("Label"),
        "editFormItemLabelCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The label cannot be empty"),
        "editFormItemOptions": MessageLookupByLibrary.simpleMessage("Options"),
        "editFormItemPlaceholder":
            MessageLookupByLibrary.simpleMessage("Placeholder"),
        "editFormItemSpamFilter":
            MessageLookupByLibrary.simpleMessage("Spam filter"),
        "editFormSave": MessageLookupByLibrary.simpleMessage("Save form"),
        "editFormTitle": MessageLookupByLibrary.simpleMessage("Edit form"),
        "editFormTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The title cannot be empty"),
        "editFormToAddressCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "The to address cannot be empty"),
        "editFormToAddressWrongFormat": MessageLookupByLibrary.simpleMessage(
            "The to address must be an email"),
        "editGalleryNameCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "The gallery name cannot be empty"),
        "editGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Edit gallery"),
        "editItemDiscard":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "editItemSave": MessageLookupByLibrary.simpleMessage("Save item"),
        "editSegmentDiscard":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "editSegmentFileHasLink":
            MessageLookupByLibrary.simpleMessage("Has link"),
        "editSegmentFileLink": MessageLookupByLibrary.simpleMessage("Link"),
        "editSegmentPage": MessageLookupByLibrary.simpleMessage("Edit page"),
        "editSegmentPageCancel":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "editSegmentPageSave":
            MessageLookupByLibrary.simpleMessage("Save page"),
        "editSegmentPageTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage(
                "The page name cannot be empty"),
        "editSegmentSave": MessageLookupByLibrary.simpleMessage("Save segment"),
        "editSimplePage": MessageLookupByLibrary.simpleMessage("Edit page"),
        "editSimplePageTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage(
                "The page title cannot be empty"),
        "failedToDeleteFileConflict": m5,
        "failedToDeleteFileGeneric": m6,
        "failedToDeleteFormConflict": m7,
        "failedToDeleteFormGeneric": m8,
        "failedToDeleteGalleryConflict": m9,
        "failedToDeleteGalleryGeneric": m10,
        "failedToDeleteSegmentPageConflict": m11,
        "failedToDeleteSegmentPageGeneric": m12,
        "failedToDeleteSimplePageConflict": m13,
        "failedToDeleteSimplePageGeneric": m14,
        "failedUploading": m15,
        "formAddConflict": MessageLookupByLibrary.simpleMessage(
            "A form with the given title already exists"),
        "formAddGeneric":
            MessageLookupByLibrary.simpleMessage("The form could not be saved"),
        "formDesigner": m16,
        "formEditConflict": MessageLookupByLibrary.simpleMessage(
            "A form with the given title already exists"),
        "formEditGeneric":
            MessageLookupByLibrary.simpleMessage("The form could not be saved"),
        "formItemTypeEmail":
            MessageLookupByLibrary.simpleMessage("Email input"),
        "formItemTypeMultiline":
            MessageLookupByLibrary.simpleMessage("Multiline input"),
        "formItemTypeText": MessageLookupByLibrary.simpleMessage("Text input"),
        "formTitle": MessageLookupByLibrary.simpleMessage("Title"),
        "formToAddress": MessageLookupByLibrary.simpleMessage("To address"),
        "galleryAddConflict": MessageLookupByLibrary.simpleMessage(
            "A gallery with the given name already exists"),
        "galleryAddGeneric": MessageLookupByLibrary.simpleMessage(
            "The gallery could not be saved"),
        "galleryDescription":
            MessageLookupByLibrary.simpleMessage("Description"),
        "galleryDesigner": m17,
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
        "manageAccountsDeleteSuccess": m18,
        "manageAccountsTitle":
            MessageLookupByLibrary.simpleMessage("Manage accounts"),
        "manageFilesTitle": MessageLookupByLibrary.simpleMessage("Files"),
        "manageGalleriesTitle":
            MessageLookupByLibrary.simpleMessage("Galleries"),
        "manageSegmentPagesTitle":
            MessageLookupByLibrary.simpleMessage("Segment pages"),
        "manageSimplePagesTitle":
            MessageLookupByLibrary.simpleMessage("Simple pages"),
        "menuAddAccount": MessageLookupByLibrary.simpleMessage("Add account"),
        "menuForms": MessageLookupByLibrary.simpleMessage("Forms"),
        "menuManageAccounts":
            MessageLookupByLibrary.simpleMessage("Manage accounts"),
        "menuManageFiles": MessageLookupByLibrary.simpleMessage("Files"),
        "menuManageGalleries":
            MessageLookupByLibrary.simpleMessage("Galleries"),
        "menuManageSegmentPages":
            MessageLookupByLibrary.simpleMessage("Segment pages"),
        "menuManageSimplePages":
            MessageLookupByLibrary.simpleMessage("Simple pages"),
        "menuMedia": MessageLookupByLibrary.simpleMessage("Media"),
        "menuPages": MessageLookupByLibrary.simpleMessage("Pages"),
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
        "pickFile": MessageLookupByLibrary.simpleMessage("Choose file"),
        "saveFailed": MessageLookupByLibrary.simpleMessage("Save failed"),
        "saveGallery": MessageLookupByLibrary.simpleMessage("Save gallery"),
        "segmentPageAddConflict": MessageLookupByLibrary.simpleMessage(
            "A segment page with the given title already exists"),
        "segmentPageAddGeneric": MessageLookupByLibrary.simpleMessage(
            "The segment page could not be saved"),
        "segmentPageDesigner": m19,
        "segmentPageEditConflict": MessageLookupByLibrary.simpleMessage(
            "A segment page with the given title already exists"),
        "segmentPageEditGeneric": MessageLookupByLibrary.simpleMessage(
            "The segment page could not be saved"),
        "segmentPageName": MessageLookupByLibrary.simpleMessage("Name"),
        "segmentPageSegmentCount": m20,
        "segmentTypeFile": MessageLookupByLibrary.simpleMessage("File"),
        "segmentTypeFileNoLink":
            MessageLookupByLibrary.simpleMessage("No link"),
        "segmentTypeGallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "segmentTypeHtml":
            MessageLookupByLibrary.simpleMessage("Formatted text"),
        "simplePageAddConflict": MessageLookupByLibrary.simpleMessage(
            "A simple page with the given title already exists"),
        "simplePageAddGeneric": MessageLookupByLibrary.simpleMessage(
            "The simple page could not be saved"),
        "simplePageEditConflict": MessageLookupByLibrary.simpleMessage(
            "A simple page with the given title already exists"),
        "simplePageEditGeneric": MessageLookupByLibrary.simpleMessage(
            "The simple page could not be saved"),
        "simplePageTitle": MessageLookupByLibrary.simpleMessage("Title"),
        "uploadFiles": MessageLookupByLibrary.simpleMessage("Upload files"),
        "uploadingFiles":
            MessageLookupByLibrary.simpleMessage("Uploading files...")
      };
}
