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

  static String m1(name) =>
      "Do you want to generate the assets for theme ${name}?";

  static String m2(name) => "Do you really want to delete the file ${name}?";

  static String m3(title) => "Do you really want to delete the form ${title}?";

  static String m4(name) => "Do you really want to delete the gallery ${name}?";

  static String m5(name) => "Do you really want to delete the menu ${name}?";

  static String m6(title) => "Do you really want to delete the page ${title}?";

  static String m7(title) => "Do you really want to delete the page ${title}?";

  static String m8(name) =>
      "The category ${name} is in use and cannot be deleted";

  static String m9(name) => "The category ${name} could not be deleted";

  static String m10(name) => "The file ${name} is in use and cannot be deleted";

  static String m11(name) => "The file ${name} could not be deleted";

  static String m12(title) =>
      "The form ${title} is in use and cannot be deleted";

  static String m13(title) => "The form ${title} could not be deleted";

  static String m14(name) =>
      "The gallery ${name} is in use and cannot be deleted";

  static String m15(name) => "The gallery ${name} could not be deleted";

  static String m16(name) => "The menu ${name} is in use and cannot be deleted";

  static String m17(name) => "The menu ${name} could not be deleted";

  static String m18(title) =>
      "The post ${title} is in use and cannot be deleted";

  static String m19(title) => "The post ${title} could not be deleted";

  static String m20(title) =>
      "The page ${title} is in use and cannot be deleted";

  static String m21(title) => "The page ${title} could not be deleted";

  static String m22(title) =>
      "The page ${title} is in use and cannot be deleted";

  static String m23(title) => "The page ${title} could not be deleted";

  static String m24(name) => "Failed to upload file ${name}";

  static String m25(title) => "Arrange ${title}";

  static String m26(name) => "Arrange ${name}";

  static String m27(name) => "Account ${name} successfully deleted";

  static String m28(name) => "Arrange ${name}";

  static String m29(name) => "Arrange ${name}";

  static String m30(count) => "Segment count: ${count}";

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
        "addBlogCategory": MessageLookupByLibrary.simpleMessage("Add category"),
        "addBlogPost": MessageLookupByLibrary.simpleMessage("Add post"),
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
        "addPostSlugCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The slug cannot be empty"),
        "addPostTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("The title cannot be empty"),
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
        "compileThemeContent": m1,
        "compileThemeFailure": MessageLookupByLibrary.simpleMessage(
            "The assets could not be generated"),
        "compileThemeSuccess": MessageLookupByLibrary.simpleMessage(
            "The assets were generated successfully"),
        "compileThemeTitle":
            MessageLookupByLibrary.simpleMessage("Generate assets?"),
        "createGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Create gallery"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteFileMessage": m2,
        "deleteFileTitle": MessageLookupByLibrary.simpleMessage("Delete file?"),
        "deleteFormMessage": m3,
        "deleteFormTitle": MessageLookupByLibrary.simpleMessage("Delete form?"),
        "deleteGalleryMessage": m4,
        "deleteGalleryTitle":
            MessageLookupByLibrary.simpleMessage("Delete gallery?"),
        "deleteMenuMessage": m5,
        "deleteMenuTitle": MessageLookupByLibrary.simpleMessage("Delete form?"),
        "deleteSegmentPageMessage": m6,
        "deleteSegmentPageTitle":
            MessageLookupByLibrary.simpleMessage("Delete page?"),
        "deleteSimplePageMessage": m7,
        "deleteSimplePageTitle":
            MessageLookupByLibrary.simpleMessage("Delete page?"),
        "discard": MessageLookupByLibrary.simpleMessage("Discard changes"),
        "discardCategory":
            MessageLookupByLibrary.simpleMessage("Discard changes"),
        "discardMenu": MessageLookupByLibrary.simpleMessage("Discard changes"),
        "discardPost": MessageLookupByLibrary.simpleMessage("Discard post"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Dismiss"),
        "editBlogCategory":
            MessageLookupByLibrary.simpleMessage("Edit category"),
        "editBlogPost": MessageLookupByLibrary.simpleMessage("Edit post"),
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
        "editSegmentPageTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage(
                "The page name cannot be empty"),
        "editSegmentSave": MessageLookupByLibrary.simpleMessage("Save segment"),
        "editSimplePage": MessageLookupByLibrary.simpleMessage("Edit page"),
        "editSimplePageTitleCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage(
                "The page title cannot be empty"),
        "failedToDeleteCategoryConflict": m8,
        "failedToDeleteCategoryGeneric": m9,
        "failedToDeleteFileConflict": m10,
        "failedToDeleteFileGeneric": m11,
        "failedToDeleteFormConflict": m12,
        "failedToDeleteFormGeneric": m13,
        "failedToDeleteGalleryConflict": m14,
        "failedToDeleteGalleryGeneric": m15,
        "failedToDeleteMenuConflict": m16,
        "failedToDeleteMenuGeneric": m17,
        "failedToDeletePostConflict": m18,
        "failedToDeletePostGeneric": m19,
        "failedToDeleteSegmentPageConflict": m20,
        "failedToDeleteSegmentPageGeneric": m21,
        "failedToDeleteSimplePageConflict": m22,
        "failedToDeleteSimplePageGeneric": m23,
        "failedUploading": m24,
        "formAddConflict": MessageLookupByLibrary.simpleMessage(
            "A form with the given title already exists"),
        "formAddGeneric":
            MessageLookupByLibrary.simpleMessage("The form could not be saved"),
        "formDesigner": m25,
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
        "galleryDesigner": m26,
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
        "manageAccountsDeleteSuccess": m27,
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
        "menuBlog": MessageLookupByLibrary.simpleMessage("Blog"),
        "menuDesigner": m28,
        "menuDesignerAddDialogTitle":
            MessageLookupByLibrary.simpleMessage("Add menu item"),
        "menuDesignerEditDialogTitle":
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
        "saveCategory": MessageLookupByLibrary.simpleMessage("Save category"),
        "saveFailed": MessageLookupByLibrary.simpleMessage("Save failed"),
        "saveGallery": MessageLookupByLibrary.simpleMessage("Save gallery"),
        "saveMenu": MessageLookupByLibrary.simpleMessage("Save menu"),
        "savePost": MessageLookupByLibrary.simpleMessage("Save post"),
        "segmentPageAddConflict": MessageLookupByLibrary.simpleMessage(
            "A segment page with the given title already exists"),
        "segmentPageAddGeneric": MessageLookupByLibrary.simpleMessage(
            "The segment page could not be saved"),
        "segmentPageDesigner": m29,
        "segmentPageEditConflict": MessageLookupByLibrary.simpleMessage(
            "A segment page with the given title already exists"),
        "segmentPageEditGeneric": MessageLookupByLibrary.simpleMessage(
            "The segment page could not be saved"),
        "segmentPageName": MessageLookupByLibrary.simpleMessage("Name"),
        "segmentPageSegmentCount": m30,
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
        "themeConfigurationSaveError": MessageLookupByLibrary.simpleMessage(
            "Failed to save configuration"),
        "themeConfigurationSaved": MessageLookupByLibrary.simpleMessage(
            "Configuration saved successfully"),
        "themeLinksBlogCategories":
            MessageLookupByLibrary.simpleMessage("Blog categories"),
        "themeLinksFiles": MessageLookupByLibrary.simpleMessage("Files"),
        "themeLinksForms": MessageLookupByLibrary.simpleMessage("Forms"),
        "themeLinksGalleries":
            MessageLookupByLibrary.simpleMessage("Galleries"),
        "themeLinksMenus": MessageLookupByLibrary.simpleMessage("Menus"),
        "themeLinksSaveError":
            MessageLookupByLibrary.simpleMessage("Failed to save links"),
        "themeLinksSaved":
            MessageLookupByLibrary.simpleMessage("Links saved successfully"),
        "themeLinksSegmentPages":
            MessageLookupByLibrary.simpleMessage("Segment pages"),
        "themeLinksSimplePages":
            MessageLookupByLibrary.simpleMessage("Simple pages"),
        "themeVariablesSaveError":
            MessageLookupByLibrary.simpleMessage("Failed to save variables"),
        "themeVariablesSaved": MessageLookupByLibrary.simpleMessage(
            "Variables saved successfully"),
        "uploadFiles": MessageLookupByLibrary.simpleMessage("Upload files"),
        "uploadingFiles":
            MessageLookupByLibrary.simpleMessage("Uploading files...")
      };
}
