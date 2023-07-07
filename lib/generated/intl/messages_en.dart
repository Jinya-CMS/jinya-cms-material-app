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

  static String m0(name) => "Do you want to activate theme ${name}?";

  static String m1(name) => "Arrange ${name}";

  static String m2(name) =>
      "Do you want to generate the assets for theme ${name}?";

  static String m3(name) =>
      "Do you really want to delete the artist ${name}? Please consider to disable ${name} if the deletion doesn\'t work.";

  static String m4(name) =>
      "Do you really want to delete the category ${name}?";

  static String m5(name) => "Do you really want to delete the post ${name}?";

  static String m6(name) => "Do you really want to delete the file ${name}?";

  static String m7(title) => "Do you really want to delete the form ${title}?";

  static String m8(name) => "Do you really want to delete the gallery ${name}?";

  static String m9(name) => "Do you really want to delete the menu ${name}?";

  static String m10(title) => "Do you really want to delete the page ${title}?";

  static String m11(title) => "Do you really want to delete the page ${title}?";

  static String m12(name) => "Do you want to disable ${name}?";

  static String m13(name) => "Do you want to enable ${name}?";

  static String m14(name) =>
      "The artist ${name} is in use and cannot be deleted";

  static String m15(name) => "The artist ${name} could not be deleted";

  static String m16(name) =>
      "The category ${name} is in use and cannot be deleted";

  static String m17(name) => "The category ${name} could not be deleted";

  static String m18(name) => "The file ${name} is in use and cannot be deleted";

  static String m19(name) => "The file ${name} could not be deleted";

  static String m20(title) =>
      "The form ${title} is in use and cannot be deleted";

  static String m21(title) => "The form ${title} could not be deleted";

  static String m22(name) =>
      "The gallery ${name} is in use and cannot be deleted";

  static String m23(name) => "The gallery ${name} could not be deleted";

  static String m24(name) => "The menu ${name} is in use and cannot be deleted";

  static String m25(name) => "The menu ${name} could not be deleted";

  static String m26(title) =>
      "The post ${title} is in use and cannot be deleted";

  static String m27(title) => "The post ${title} could not be deleted";

  static String m28(title) =>
      "The page ${title} is in use and cannot be deleted";

  static String m29(title) => "The page ${title} could not be deleted";

  static String m30(title) =>
      "The page ${title} is in use and cannot be deleted";

  static String m31(title) => "The page ${title} could not be deleted";

  static String m32(name) => "Failed to upload file ${name}";

  static String m33(title) => "Arrange ${title}";

  static String m34(name) => "Arrange ${name}";

  static String m35(name) => "Account ${name} successfully deleted";

  static String m36(name) => "Arrange ${name}";

  static String m37(name) => "Arrange ${name}";

  static String m38(count) => "Segment count: ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionUndo": MessageLookupByLibrary.simpleMessage("Undo"),
        "activateThemeActivate":
            MessageLookupByLibrary.simpleMessage("Activate theme"),
        "activateThemeCancel":
            MessageLookupByLibrary.simpleMessage("Don\'t activate"),
        "activateThemeContent": m0,
        "activateThemeFailure": MessageLookupByLibrary.simpleMessage(
            "The theme could not be activated"),
        "activateThemeSuccess": MessageLookupByLibrary.simpleMessage(
            "The theme was activated successfully"),
        "activateThemeTitle":
            MessageLookupByLibrary.simpleMessage("Activate theme?"),
        "addArtist": MessageLookupByLibrary.simpleMessage("Add artist"),
        "addBlogCategory": MessageLookupByLibrary.simpleMessage("Add category"),
        "addBlogPost": MessageLookupByLibrary.simpleMessage("Add post"),
        "addBlogPostSegment":
            MessageLookupByLibrary.simpleMessage("Add segment"),
        "addCategoryTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The name cannot be empty"),
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
        "addMenu": MessageLookupByLibrary.simpleMessage("Add menu"),
        "addPostSlugCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The slug cannot be empty"),
        "addPostTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The title cannot be empty"),
        "addSegmentPage": MessageLookupByLibrary.simpleMessage("Add page"),
        "addSegmentPageCancel":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "addSegmentPageSave":
            MessageLookupByLibrary.simpleMessage("Create page"),
        "addSegmentPageSegment":
            MessageLookupByLibrary.simpleMessage("Add segment"),
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
        "artistAddConflict": MessageLookupByLibrary.simpleMessage(
            "An artist with the given email already exists"),
        "artistAddGeneric": MessageLookupByLibrary.simpleMessage(
            "The artist could not be saved"),
        "artistEditConflict": MessageLookupByLibrary.simpleMessage(
            "An artist with the given email already exists"),
        "artistEditGeneric": MessageLookupByLibrary.simpleMessage(
            "The artist could not be saved"),
        "artistName": MessageLookupByLibrary.simpleMessage("Artist name"),
        "artistNameCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "The artist name cannot be empty"),
        "blogPostDesigner": m1,
        "categoryAddConflict": MessageLookupByLibrary.simpleMessage(
            "A category with the given name already exists"),
        "categoryAddGeneric": MessageLookupByLibrary.simpleMessage(
            "The category could not be saved"),
        "categoryDescription":
            MessageLookupByLibrary.simpleMessage("Description"),
        "categoryEditConflict": MessageLookupByLibrary.simpleMessage(
            "A category with the given name already exists"),
        "categoryEditGeneric": MessageLookupByLibrary.simpleMessage(
            "The category could not be saved"),
        "categoryName": MessageLookupByLibrary.simpleMessage("Name"),
        "categoryNoParent": MessageLookupByLibrary.simpleMessage("No parent"),
        "categoryParent": MessageLookupByLibrary.simpleMessage("Parent"),
        "categoryWebhookEnabled":
            MessageLookupByLibrary.simpleMessage("Webhook enabled"),
        "categoryWebhookUrl":
            MessageLookupByLibrary.simpleMessage("Webhook URL"),
        "chooseFiles": MessageLookupByLibrary.simpleMessage("Choose files..."),
        "compileThemeActivate":
            MessageLookupByLibrary.simpleMessage("Generate assets"),
        "compileThemeCancel":
            MessageLookupByLibrary.simpleMessage("Don\'t generate"),
        "compileThemeContent": m2,
        "compileThemeFailure": MessageLookupByLibrary.simpleMessage(
            "The assets could not be generated"),
        "compileThemeSuccess": MessageLookupByLibrary.simpleMessage(
            "The assets were generated successfully"),
        "compileThemeTitle":
            MessageLookupByLibrary.simpleMessage("Generate assets?"),
        "createGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Create gallery"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteArtist": MessageLookupByLibrary.simpleMessage("Delete artist"),
        "deleteArtistMessage": m3,
        "deleteArtistTitle":
            MessageLookupByLibrary.simpleMessage("Delete artist?"),
        "deleteBlogCategory":
            MessageLookupByLibrary.simpleMessage("Delete category"),
        "deleteBlogCategoryMessage": m4,
        "deleteBlogCategoryTitle":
            MessageLookupByLibrary.simpleMessage("Delete category?"),
        "deleteBlogPost": MessageLookupByLibrary.simpleMessage("Delete post"),
        "deleteBlogPostMessage": m5,
        "deleteBlogPostTitle":
            MessageLookupByLibrary.simpleMessage("Delete post?"),
        "deleteFileMessage": m6,
        "deleteFileTitle": MessageLookupByLibrary.simpleMessage("Delete file?"),
        "deleteForm": MessageLookupByLibrary.simpleMessage("Delete form"),
        "deleteFormMessage": m7,
        "deleteFormTitle": MessageLookupByLibrary.simpleMessage("Delete form?"),
        "deleteGallery": MessageLookupByLibrary.simpleMessage("Delete gallery"),
        "deleteGalleryMessage": m8,
        "deleteGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Delete gallery?"),
        "deleteMenu": MessageLookupByLibrary.simpleMessage("Delete menu"),
        "deleteMenuMessage": m9,
        "deleteMenuTitle": MessageLookupByLibrary.simpleMessage("Delete form?"),
        "deleteSegmentPage":
            MessageLookupByLibrary.simpleMessage("Delete page"),
        "deleteSegmentPageMessage": m10,
        "deleteSegmentPageTitle":
            MessageLookupByLibrary.simpleMessage("Delete page?"),
        "deleteSimplePage": MessageLookupByLibrary.simpleMessage("Delete page"),
        "deleteSimplePageMessage": m11,
        "deleteSimplePageTitle":
            MessageLookupByLibrary.simpleMessage("Delete page?"),
        "disableArtist": MessageLookupByLibrary.simpleMessage("Disable artist"),
        "disableArtistCancel":
            MessageLookupByLibrary.simpleMessage("Keep enabled"),
        "disableArtistConfirm":
            MessageLookupByLibrary.simpleMessage("Disable artist"),
        "disableArtistContent": m12,
        "disableArtistFailure":
            MessageLookupByLibrary.simpleMessage("Disabling the artist failed"),
        "disableArtistTitle":
            MessageLookupByLibrary.simpleMessage("Disable artist?"),
        "discard": MessageLookupByLibrary.simpleMessage("Discard changes"),
        "discardCategory":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "discardMenu": MessageLookupByLibrary.simpleMessage("Discard changes"),
        "discardPost": MessageLookupByLibrary.simpleMessage("Discard post"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
        "editArtist": MessageLookupByLibrary.simpleMessage("Edit artist"),
        "editBlogCategory":
            MessageLookupByLibrary.simpleMessage("Edit category"),
        "editBlogPost": MessageLookupByLibrary.simpleMessage("Edit post"),
        "editBlogPostSegment":
            MessageLookupByLibrary.simpleMessage("Edit segment"),
        "editCategoryTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The name cannot be empty"),
        "editFileCancel":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "editFileName": MessageLookupByLibrary.simpleMessage("Name"),
        "editFileNameEmpty":
            MessageLookupByLibrary.simpleMessage("Name cannot be empty"),
        "editFileSave": MessageLookupByLibrary.simpleMessage("Save file"),
        "editFileTitle": MessageLookupByLibrary.simpleMessage("Edit file"),
        "editFormCancel":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "editFormItem": MessageLookupByLibrary.simpleMessage("Edit item"),
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
        "editMenu": MessageLookupByLibrary.simpleMessage("Edit menu"),
        "editPostSlugCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The slug cannot be empty"),
        "editPostTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The title cannot be empty"),
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
        "editSegmentPageSegment":
            MessageLookupByLibrary.simpleMessage("Edit segment"),
        "editSegmentPageTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage(
                "The page name cannot be empty"),
        "editSegmentSave": MessageLookupByLibrary.simpleMessage("Save segment"),
        "editSimplePage": MessageLookupByLibrary.simpleMessage("Edit page"),
        "editSimplePageTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage(
                "The page title cannot be empty"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The email cannot be empty"),
        "emailWrongFormat": MessageLookupByLibrary.simpleMessage(
            "The email has the wrong format"),
        "enableArtist": MessageLookupByLibrary.simpleMessage("Enable artist"),
        "enableArtistCancel":
            MessageLookupByLibrary.simpleMessage("Keep disabled"),
        "enableArtistConfirm":
            MessageLookupByLibrary.simpleMessage("Enable artist"),
        "enableArtistContent": m13,
        "enableArtistFailure":
            MessageLookupByLibrary.simpleMessage("Enabling the artist failed"),
        "enableArtistTitle":
            MessageLookupByLibrary.simpleMessage("Enable artist?"),
        "failedToDeleteArtistConflict": m14,
        "failedToDeleteArtistGeneric": m15,
        "failedToDeleteCategoryConflict": m16,
        "failedToDeleteCategoryGeneric": m17,
        "failedToDeleteFileConflict": m18,
        "failedToDeleteFileGeneric": m19,
        "failedToDeleteFormConflict": m20,
        "failedToDeleteFormGeneric": m21,
        "failedToDeleteGalleryConflict": m22,
        "failedToDeleteGalleryGeneric": m23,
        "failedToDeleteMenuConflict": m24,
        "failedToDeleteMenuGeneric": m25,
        "failedToDeletePostConflict": m26,
        "failedToDeletePostGeneric": m27,
        "failedToDeleteSegmentPageConflict": m28,
        "failedToDeleteSegmentPageGeneric": m29,
        "failedToDeleteSimplePageConflict": m30,
        "failedToDeleteSimplePageGeneric": m31,
        "failedUploading": m32,
        "formAddConflict": MessageLookupByLibrary.simpleMessage(
            "A form with the given title already exists"),
        "formAddGeneric":
            MessageLookupByLibrary.simpleMessage("The form could not be saved"),
        "formDesigner": m33,
        "formDesignerAddItem": MessageLookupByLibrary.simpleMessage("Add item"),
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
        "galleryDesigner": m34,
        "galleryDesignerAddItem":
            MessageLookupByLibrary.simpleMessage("Add file"),
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
        "loginActionBiometric":
            MessageLookupByLibrary.simpleMessage("Login passwordless"),
        "loginActionLogin": MessageLookupByLibrary.simpleMessage("Login"),
        "loginBiometric": MessageLookupByLibrary.simpleMessage(
            "Authenticate with biometry and you don\'t need to enter your password"),
        "loginEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "loginInstance": MessageLookupByLibrary.simpleMessage("Jinya host"),
        "loginInvalidCredentials": MessageLookupByLibrary.simpleMessage(
            "Your credentials are invalid"),
        "loginPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
        "manageAccountsDeleteSuccess": m35,
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
        "menuAddConflict": MessageLookupByLibrary.simpleMessage(
            "A menu with the given name already exists"),
        "menuAddGeneric":
            MessageLookupByLibrary.simpleMessage("The menu could not be saved"),
        "menuArtists": MessageLookupByLibrary.simpleMessage("Artists"),
        "menuBlog": MessageLookupByLibrary.simpleMessage("Blog"),
        "menuDesigner": m36,
        "menuDesignerAddDialogTitle":
            MessageLookupByLibrary.simpleMessage("Add menu item"),
        "menuDesignerAddItem": MessageLookupByLibrary.simpleMessage("Add item"),
        "menuDesignerDecreaseItem":
            MessageLookupByLibrary.simpleMessage("Decrease nesting"),
        "menuDesignerEditDialogTitle":
            MessageLookupByLibrary.simpleMessage("Edit menu item"),
        "menuDesignerEditItem":
            MessageLookupByLibrary.simpleMessage("Edit menu item"),
        "menuDesignerEditItemDiscardChanges":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "menuDesignerEditItemHighlighted":
            MessageLookupByLibrary.simpleMessage("Highlighted"),
        "menuDesignerEditItemRoute":
            MessageLookupByLibrary.simpleMessage("Route"),
        "menuDesignerEditItemSaveChanges":
            MessageLookupByLibrary.simpleMessage("Save item"),
        "menuDesignerEditItemTitle":
            MessageLookupByLibrary.simpleMessage("Title"),
        "menuDesignerEditItemTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The title cannot be empty"),
        "menuDesignerIncreaseItem":
            MessageLookupByLibrary.simpleMessage("Increase nesting"),
        "menuDesignerItemArtist":
            MessageLookupByLibrary.simpleMessage("Artist"),
        "menuDesignerItemBlogCategory":
            MessageLookupByLibrary.simpleMessage("Blog category"),
        "menuDesignerItemBlogHomePage":
            MessageLookupByLibrary.simpleMessage("Blog home page"),
        "menuDesignerItemExternalLink":
            MessageLookupByLibrary.simpleMessage("External website"),
        "menuDesignerItemForm": MessageLookupByLibrary.simpleMessage("Form"),
        "menuDesignerItemGallery":
            MessageLookupByLibrary.simpleMessage("Gallery"),
        "menuDesignerItemGroup": MessageLookupByLibrary.simpleMessage("Group"),
        "menuDesignerItemRoute": MessageLookupByLibrary.simpleMessage("Route"),
        "menuDesignerItemSegmentPage":
            MessageLookupByLibrary.simpleMessage("Segment page"),
        "menuDesignerItemSimplePage":
            MessageLookupByLibrary.simpleMessage("Simple page"),
        "menuDesignerItemType": MessageLookupByLibrary.simpleMessage("Type"),
        "menuEditConflict": MessageLookupByLibrary.simpleMessage(
            "A menu with the given name already exists"),
        "menuEditGeneric":
            MessageLookupByLibrary.simpleMessage("The menu could not be saved"),
        "menuForms": MessageLookupByLibrary.simpleMessage("Forms"),
        "menuLogo": MessageLookupByLibrary.simpleMessage("Logo"),
        "menuManageAccounts":
            MessageLookupByLibrary.simpleMessage("Manage accounts"),
        "menuManageBlogCategories":
            MessageLookupByLibrary.simpleMessage("Categories"),
        "menuManageBlogPosts": MessageLookupByLibrary.simpleMessage("Posts"),
        "menuManageFiles": MessageLookupByLibrary.simpleMessage("Files"),
        "menuManageGalleries":
            MessageLookupByLibrary.simpleMessage("Galleries"),
        "menuManageSegmentPages":
            MessageLookupByLibrary.simpleMessage("Segment pages"),
        "menuManageSimplePages":
            MessageLookupByLibrary.simpleMessage("Simple pages"),
        "menuMedia": MessageLookupByLibrary.simpleMessage("Media"),
        "menuMenu": MessageLookupByLibrary.simpleMessage("Menus"),
        "menuName": MessageLookupByLibrary.simpleMessage("Name"),
        "menuNameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The name cannot be empty"),
        "menuNoLogo": MessageLookupByLibrary.simpleMessage("No logo"),
        "menuPages": MessageLookupByLibrary.simpleMessage("Pages"),
        "menuSwitchAccount":
            MessageLookupByLibrary.simpleMessage("Switch account"),
        "menuTheme": MessageLookupByLibrary.simpleMessage("Themes"),
        "menuThemeLinks": MessageLookupByLibrary.simpleMessage("Links"),
        "menuThemeSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "menuThemeVariables": MessageLookupByLibrary.simpleMessage("Variables"),
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
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "The password cannot be empty"),
        "pickFile": MessageLookupByLibrary.simpleMessage("Choose file"),
        "postAddConflict": MessageLookupByLibrary.simpleMessage(
            "A post with the given title or slug already exists"),
        "postAddGeneric":
            MessageLookupByLibrary.simpleMessage("The post could not be saved"),
        "postCategory": MessageLookupByLibrary.simpleMessage("Category"),
        "postEditConflict": MessageLookupByLibrary.simpleMessage(
            "A post with the given title or slug already exists"),
        "postEditGeneric":
            MessageLookupByLibrary.simpleMessage("The post could not be saved"),
        "postImage": MessageLookupByLibrary.simpleMessage("Post image"),
        "postNoHeaderImage":
            MessageLookupByLibrary.simpleMessage("No post image"),
        "postPublic": MessageLookupByLibrary.simpleMessage("Public"),
        "postSegmentsError":
            MessageLookupByLibrary.simpleMessage("The post could not be saved"),
        "postSegmentsSaved": MessageLookupByLibrary.simpleMessage(
            "The post was saved successfully"),
        "postSlug": MessageLookupByLibrary.simpleMessage("Slug"),
        "postTitle": MessageLookupByLibrary.simpleMessage("Title"),
        "roleAdmin": MessageLookupByLibrary.simpleMessage("Admin"),
        "roleReader": MessageLookupByLibrary.simpleMessage("Reader"),
        "roleWriter": MessageLookupByLibrary.simpleMessage("Writer"),
        "saveCategory": MessageLookupByLibrary.simpleMessage("Save category"),
        "saveFailed": MessageLookupByLibrary.simpleMessage("Save failed"),
        "saveGallery": MessageLookupByLibrary.simpleMessage("Save gallery"),
        "saveMenu": MessageLookupByLibrary.simpleMessage("Save menu"),
        "savePost": MessageLookupByLibrary.simpleMessage("Save post"),
        "segmentPageAddConflict": MessageLookupByLibrary.simpleMessage(
            "A segment page with the given title already exists"),
        "segmentPageAddGeneric": MessageLookupByLibrary.simpleMessage(
            "The segment page could not be saved"),
        "segmentPageDesigner": m37,
        "segmentPageEditConflict": MessageLookupByLibrary.simpleMessage(
            "A segment page with the given title already exists"),
        "segmentPageEditGeneric": MessageLookupByLibrary.simpleMessage(
            "The segment page could not be saved"),
        "segmentPageName": MessageLookupByLibrary.simpleMessage("Name"),
        "segmentPageSegmentCount": m38,
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
        "themeActivate": MessageLookupByLibrary.simpleMessage("Activate theme"),
        "themeAssets": MessageLookupByLibrary.simpleMessage("Generate assets"),
        "themeConfigurationSaveError": MessageLookupByLibrary.simpleMessage(
            "Failed to save configuration"),
        "themeConfigurationSaved": MessageLookupByLibrary.simpleMessage(
            "Configuration saved successfully"),
        "themeLinks": MessageLookupByLibrary.simpleMessage("Theme links"),
        "themeLinksBlogCategories":
            MessageLookupByLibrary.simpleMessage("Blog categories"),
        "themeLinksFiles": MessageLookupByLibrary.simpleMessage("Files"),
        "themeLinksForms": MessageLookupByLibrary.simpleMessage("Forms"),
        "themeLinksGalleries":
            MessageLookupByLibrary.simpleMessage("Galleries"),
        "themeLinksMenus": MessageLookupByLibrary.simpleMessage("Menus"),
        "themeLinksSave": MessageLookupByLibrary.simpleMessage("Save links"),
        "themeLinksSaveError":
            MessageLookupByLibrary.simpleMessage("Failed to save links"),
        "themeLinksSaved":
            MessageLookupByLibrary.simpleMessage("Links saved successfully"),
        "themeLinksSegmentPages":
            MessageLookupByLibrary.simpleMessage("Segment pages"),
        "themeLinksSimplePages":
            MessageLookupByLibrary.simpleMessage("Simple pages"),
        "themeSettings": MessageLookupByLibrary.simpleMessage("Theme settings"),
        "themeSettingsSave":
            MessageLookupByLibrary.simpleMessage("Save settings"),
        "themeVariables":
            MessageLookupByLibrary.simpleMessage("Theme variables"),
        "themeVariablesSave":
            MessageLookupByLibrary.simpleMessage("Save variables"),
        "themeVariablesSaveError":
            MessageLookupByLibrary.simpleMessage("Failed to save variables"),
        "themeVariablesSaved": MessageLookupByLibrary.simpleMessage(
            "Variables saved successfully"),
        "uploadFiles": MessageLookupByLibrary.simpleMessage("Upload files"),
        "uploadingFiles":
            MessageLookupByLibrary.simpleMessage("Uploading files...")
      };
}
