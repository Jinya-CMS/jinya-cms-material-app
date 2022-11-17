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

  /// `Files`
  String get menuManageFiles {
    return Intl.message(
      'Files',
      name: 'menuManageFiles',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get manageFilesTitle {
    return Intl.message(
      'Files',
      name: 'manageFilesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Upload files`
  String get uploadFiles {
    return Intl.message(
      'Upload files',
      name: 'uploadFiles',
      desc: '',
      args: [],
    );
  }

  /// `Choose files...`
  String get chooseFiles {
    return Intl.message(
      'Choose files...',
      name: 'chooseFiles',
      desc: '',
      args: [],
    );
  }

  /// `Uploading files...`
  String get uploadingFiles {
    return Intl.message(
      'Uploading files...',
      name: 'uploadingFiles',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload file {name}`
  String failedUploading(Object name) {
    return Intl.message(
      'Failed to upload file $name',
      name: 'failedUploading',
      desc: '',
      args: [name],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Don't delete`
  String get keep {
    return Intl.message(
      'Don\'t delete',
      name: 'keep',
      desc: '',
      args: [],
    );
  }

  /// `Save file`
  String get editFileSave {
    return Intl.message(
      'Save file',
      name: 'editFileSave',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get editFileCancel {
    return Intl.message(
      'Discard changes',
      name: 'editFileCancel',
      desc: '',
      args: [],
    );
  }

  /// `Edit file`
  String get editFileTitle {
    return Intl.message(
      'Edit file',
      name: 'editFileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get editFileName {
    return Intl.message(
      'Name',
      name: 'editFileName',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty`
  String get editFileNameEmpty {
    return Intl.message(
      'Name cannot be empty',
      name: 'editFileNameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Delete file?`
  String get deleteFileTitle {
    return Intl.message(
      'Delete file?',
      name: 'deleteFileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete the file {name}?`
  String deleteFileMessage(Object name) {
    return Intl.message(
      'Do you really want to delete the file $name?',
      name: 'deleteFileMessage',
      desc: '',
      args: [name],
    );
  }

  /// `The file {name} is in use and cannot be deleted`
  String failedToDeleteFileConflict(Object name) {
    return Intl.message(
      'The file $name is in use and cannot be deleted',
      name: 'failedToDeleteFileConflict',
      desc: '',
      args: [name],
    );
  }

  /// `The file {name} could not be deleted`
  String failedToDeleteFileGeneric(Object name) {
    return Intl.message(
      'The file $name could not be deleted',
      name: 'failedToDeleteFileGeneric',
      desc: '',
      args: [name],
    );
  }

  /// `Galleries`
  String get manageGalleriesTitle {
    return Intl.message(
      'Galleries',
      name: 'manageGalleriesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Galleries`
  String get menuManageGalleries {
    return Intl.message(
      'Galleries',
      name: 'menuManageGalleries',
      desc: '',
      args: [],
    );
  }

  /// `Delete gallery?`
  String get deleteGalleryTitle {
    return Intl.message(
      'Delete gallery?',
      name: 'deleteGalleryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete the gallery {name}?`
  String deleteGalleryMessage(Object name) {
    return Intl.message(
      'Do you really want to delete the gallery $name?',
      name: 'deleteGalleryMessage',
      desc: '',
      args: [name],
    );
  }

  /// `The gallery {name} is in use and cannot be deleted`
  String failedToDeleteGalleryConflict(Object name) {
    return Intl.message(
      'The gallery $name is in use and cannot be deleted',
      name: 'failedToDeleteGalleryConflict',
      desc: '',
      args: [name],
    );
  }

  /// `The gallery {name} could not be deleted`
  String failedToDeleteGalleryGeneric(Object name) {
    return Intl.message(
      'The gallery $name could not be deleted',
      name: 'failedToDeleteGalleryGeneric',
      desc: '',
      args: [name],
    );
  }

  /// `Orientation`
  String get galleryOrientation {
    return Intl.message(
      'Orientation',
      name: 'galleryOrientation',
      desc: '',
      args: [],
    );
  }

  /// `Horizontal`
  String get galleryOrientationHorizontal {
    return Intl.message(
      'Horizontal',
      name: 'galleryOrientationHorizontal',
      desc: '',
      args: [],
    );
  }

  /// `Vertical`
  String get galleryOrientationVertical {
    return Intl.message(
      'Vertical',
      name: 'galleryOrientationVertical',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get galleryType {
    return Intl.message(
      'Type',
      name: 'galleryType',
      desc: '',
      args: [],
    );
  }

  /// `Grid`
  String get galleryTypeGrid {
    return Intl.message(
      'Grid',
      name: 'galleryTypeGrid',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get galleryTypeList {
    return Intl.message(
      'List',
      name: 'galleryTypeList',
      desc: '',
      args: [],
    );
  }

  /// `Edit gallery`
  String get editGalleryTitle {
    return Intl.message(
      'Edit gallery',
      name: 'editGalleryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create gallery`
  String get createGalleryTitle {
    return Intl.message(
      'Create gallery',
      name: 'createGalleryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get discard {
    return Intl.message(
      'Discard changes',
      name: 'discard',
      desc: '',
      args: [],
    );
  }

  /// `Save gallery`
  String get saveGallery {
    return Intl.message(
      'Save gallery',
      name: 'saveGallery',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get galleryName {
    return Intl.message(
      'Name',
      name: 'galleryName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get galleryDescription {
    return Intl.message(
      'Description',
      name: 'galleryDescription',
      desc: '',
      args: [],
    );
  }

  /// `The gallery name cannot be empty`
  String get editGalleryNameCannotBeEmpty {
    return Intl.message(
      'The gallery name cannot be empty',
      name: 'editGalleryNameCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `A gallery with the given name already exists`
  String get galleryEditConflict {
    return Intl.message(
      'A gallery with the given name already exists',
      name: 'galleryEditConflict',
      desc: '',
      args: [],
    );
  }

  /// `A gallery with the given name already exists`
  String get galleryAddConflict {
    return Intl.message(
      'A gallery with the given name already exists',
      name: 'galleryAddConflict',
      desc: '',
      args: [],
    );
  }

  /// `The gallery could not be saved`
  String get galleryEditGeneric {
    return Intl.message(
      'The gallery could not be saved',
      name: 'galleryEditGeneric',
      desc: '',
      args: [],
    );
  }

  /// `The gallery could not be saved`
  String get galleryAddGeneric {
    return Intl.message(
      'The gallery could not be saved',
      name: 'galleryAddGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Save failed`
  String get saveFailed {
    return Intl.message(
      'Save failed',
      name: 'saveFailed',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Arrange {name}`
  String galleryDesigner(Object name) {
    return Intl.message(
      'Arrange $name',
      name: 'galleryDesigner',
      desc: '',
      args: [name],
    );
  }

  /// `Choose file`
  String get pickFile {
    return Intl.message(
      'Choose file',
      name: 'pickFile',
      desc: '',
      args: [],
    );
  }

  /// `Simple pages`
  String get menuManageSimplePages {
    return Intl.message(
      'Simple pages',
      name: 'menuManageSimplePages',
      desc: '',
      args: [],
    );
  }

  /// `Simple pages`
  String get manageSimplePagesTitle {
    return Intl.message(
      'Simple pages',
      name: 'manageSimplePagesTitle',
      desc: '',
      args: [],
    );
  }

  /// `The page {title} is in use and cannot be deleted`
  String failedToDeleteSimplePageConflict(Object title) {
    return Intl.message(
      'The page $title is in use and cannot be deleted',
      name: 'failedToDeleteSimplePageConflict',
      desc: '',
      args: [title],
    );
  }

  /// `The page {title} could not be deleted`
  String failedToDeleteSimplePageGeneric(Object title) {
    return Intl.message(
      'The page $title could not be deleted',
      name: 'failedToDeleteSimplePageGeneric',
      desc: '',
      args: [title],
    );
  }

  /// `Delete page?`
  String get deleteSimplePageTitle {
    return Intl.message(
      'Delete page?',
      name: 'deleteSimplePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete the page {title}?`
  String deleteSimplePageMessage(Object title) {
    return Intl.message(
      'Do you really want to delete the page $title?',
      name: 'deleteSimplePageMessage',
      desc: '',
      args: [title],
    );
  }

  /// `Edit page`
  String get editSimplePage {
    return Intl.message(
      'Edit page',
      name: 'editSimplePage',
      desc: '',
      args: [],
    );
  }

  /// `The page title cannot be empty`
  String get editSimplePageTitleCannotBeEmpty {
    return Intl.message(
      'The page title cannot be empty',
      name: 'editSimplePageTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get simplePageTitle {
    return Intl.message(
      'Title',
      name: 'simplePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `A simple page with the given title already exists`
  String get simplePageEditConflict {
    return Intl.message(
      'A simple page with the given title already exists',
      name: 'simplePageEditConflict',
      desc: '',
      args: [],
    );
  }

  /// `The simple page could not be saved`
  String get simplePageEditGeneric {
    return Intl.message(
      'The simple page could not be saved',
      name: 'simplePageEditGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Add page`
  String get addSimplePage {
    return Intl.message(
      'Add page',
      name: 'addSimplePage',
      desc: '',
      args: [],
    );
  }

  /// `The page title cannot be empty`
  String get addSimplePageTitleCannotBeEmpty {
    return Intl.message(
      'The page title cannot be empty',
      name: 'addSimplePageTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `A simple page with the given title already exists`
  String get simplePageAddConflict {
    return Intl.message(
      'A simple page with the given title already exists',
      name: 'simplePageAddConflict',
      desc: '',
      args: [],
    );
  }

  /// `The simple page could not be saved`
  String get simplePageAddGeneric {
    return Intl.message(
      'The simple page could not be saved',
      name: 'simplePageAddGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Segment pages`
  String get menuManageSegmentPages {
    return Intl.message(
      'Segment pages',
      name: 'menuManageSegmentPages',
      desc: '',
      args: [],
    );
  }

  /// `Segment pages`
  String get manageSegmentPagesTitle {
    return Intl.message(
      'Segment pages',
      name: 'manageSegmentPagesTitle',
      desc: '',
      args: [],
    );
  }

  /// `The page {title} is in use and cannot be deleted`
  String failedToDeleteSegmentPageConflict(Object title) {
    return Intl.message(
      'The page $title is in use and cannot be deleted',
      name: 'failedToDeleteSegmentPageConflict',
      desc: '',
      args: [title],
    );
  }

  /// `The page {title} could not be deleted`
  String failedToDeleteSegmentPageGeneric(Object title) {
    return Intl.message(
      'The page $title could not be deleted',
      name: 'failedToDeleteSegmentPageGeneric',
      desc: '',
      args: [title],
    );
  }

  /// `Delete page?`
  String get deleteSegmentPageTitle {
    return Intl.message(
      'Delete page?',
      name: 'deleteSegmentPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete the page {title}?`
  String deleteSegmentPageMessage(Object title) {
    return Intl.message(
      'Do you really want to delete the page $title?',
      name: 'deleteSegmentPageMessage',
      desc: '',
      args: [title],
    );
  }

  /// `Edit page`
  String get editSegmentPage {
    return Intl.message(
      'Edit page',
      name: 'editSegmentPage',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get editSegmentPageCancel {
    return Intl.message(
      'Discard changes',
      name: 'editSegmentPageCancel',
      desc: '',
      args: [],
    );
  }

  /// `Save page`
  String get editSegmentPageSave {
    return Intl.message(
      'Save page',
      name: 'editSegmentPageSave',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get segmentPageName {
    return Intl.message(
      'Name',
      name: 'segmentPageName',
      desc: '',
      args: [],
    );
  }

  /// `A segment page with the given title already exists`
  String get segmentPageEditConflict {
    return Intl.message(
      'A segment page with the given title already exists',
      name: 'segmentPageEditConflict',
      desc: '',
      args: [],
    );
  }

  /// `The segment page could not be saved`
  String get segmentPageEditGeneric {
    return Intl.message(
      'The segment page could not be saved',
      name: 'segmentPageEditGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Add page`
  String get addSegmentPage {
    return Intl.message(
      'Add page',
      name: 'addSegmentPage',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get addSegmentPageCancel {
    return Intl.message(
      'Discard changes',
      name: 'addSegmentPageCancel',
      desc: '',
      args: [],
    );
  }

  /// `Create page`
  String get addSegmentPageSave {
    return Intl.message(
      'Create page',
      name: 'addSegmentPageSave',
      desc: '',
      args: [],
    );
  }

  /// `A segment page with the given title already exists`
  String get segmentPageAddConflict {
    return Intl.message(
      'A segment page with the given title already exists',
      name: 'segmentPageAddConflict',
      desc: '',
      args: [],
    );
  }

  /// `The segment page could not be saved`
  String get segmentPageAddGeneric {
    return Intl.message(
      'The segment page could not be saved',
      name: 'segmentPageAddGeneric',
      desc: '',
      args: [],
    );
  }

  /// `The page name cannot be empty`
  String get editSegmentPageTitleCannotBeEmpty {
    return Intl.message(
      'The page name cannot be empty',
      name: 'editSegmentPageTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The page name cannot be empty`
  String get addSegmentPageTitleCannotBeEmpty {
    return Intl.message(
      'The page name cannot be empty',
      name: 'addSegmentPageTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Segment count: {count}`
  String segmentPageSegmentCount(Object count) {
    return Intl.message(
      'Segment count: $count',
      name: 'segmentPageSegmentCount',
      desc: '',
      args: [count],
    );
  }

  /// `Arrange {name}`
  String segmentPageDesigner(Object name) {
    return Intl.message(
      'Arrange $name',
      name: 'segmentPageDesigner',
      desc: '',
      args: [name],
    );
  }

  /// `File`
  String get segmentTypeFile {
    return Intl.message(
      'File',
      name: 'segmentTypeFile',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get segmentTypeGallery {
    return Intl.message(
      'Gallery',
      name: 'segmentTypeGallery',
      desc: '',
      args: [],
    );
  }

  /// `Formatted text`
  String get segmentTypeHtml {
    return Intl.message(
      'Formatted text',
      name: 'segmentTypeHtml',
      desc: '',
      args: [],
    );
  }

  /// `Add file`
  String get addSegmentTypeFile {
    return Intl.message(
      'Add file',
      name: 'addSegmentTypeFile',
      desc: '',
      args: [],
    );
  }

  /// `Add gallery`
  String get addSegmentTypeGallery {
    return Intl.message(
      'Add gallery',
      name: 'addSegmentTypeGallery',
      desc: '',
      args: [],
    );
  }

  /// `Add formatted text`
  String get addSegmentTypeHtml {
    return Intl.message(
      'Add formatted text',
      name: 'addSegmentTypeHtml',
      desc: '',
      args: [],
    );
  }

  /// `No link`
  String get segmentTypeFileNoLink {
    return Intl.message(
      'No link',
      name: 'segmentTypeFileNoLink',
      desc: '',
      args: [],
    );
  }

  /// `Save segment`
  String get editSegmentSave {
    return Intl.message(
      'Save segment',
      name: 'editSegmentSave',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get editSegmentDiscard {
    return Intl.message(
      'Discard changes',
      name: 'editSegmentDiscard',
      desc: '',
      args: [],
    );
  }

  /// `Has link`
  String get editSegmentFileHasLink {
    return Intl.message(
      'Has link',
      name: 'editSegmentFileHasLink',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get editSegmentFileLink {
    return Intl.message(
      'Link',
      name: 'editSegmentFileLink',
      desc: '',
      args: [],
    );
  }

  /// `Media`
  String get menuMedia {
    return Intl.message(
      'Media',
      name: 'menuMedia',
      desc: '',
      args: [],
    );
  }

  /// `Pages`
  String get menuPages {
    return Intl.message(
      'Pages',
      name: 'menuPages',
      desc: '',
      args: [],
    );
  }

  /// `Forms`
  String get menuForms {
    return Intl.message(
      'Forms',
      name: 'menuForms',
      desc: '',
      args: [],
    );
  }

  /// `The form {title} is in use and cannot be deleted`
  String failedToDeleteFormConflict(Object title) {
    return Intl.message(
      'The form $title is in use and cannot be deleted',
      name: 'failedToDeleteFormConflict',
      desc: '',
      args: [title],
    );
  }

  /// `The form {title} could not be deleted`
  String failedToDeleteFormGeneric(Object title) {
    return Intl.message(
      'The form $title could not be deleted',
      name: 'failedToDeleteFormGeneric',
      desc: '',
      args: [title],
    );
  }

  /// `Delete form?`
  String get deleteFormTitle {
    return Intl.message(
      'Delete form?',
      name: 'deleteFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete the form {title}?`
  String deleteFormMessage(Object title) {
    return Intl.message(
      'Do you really want to delete the form $title?',
      name: 'deleteFormMessage',
      desc: '',
      args: [title],
    );
  }

  /// `The title cannot be empty`
  String get addFormTitleCannotBeEmpty {
    return Intl.message(
      'The title cannot be empty',
      name: 'addFormTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The to address cannot be empty`
  String get addFormToAddressCannotBeEmpty {
    return Intl.message(
      'The to address cannot be empty',
      name: 'addFormToAddressCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The to address must be an email`
  String get addFormToAddressWrongFormat {
    return Intl.message(
      'The to address must be an email',
      name: 'addFormToAddressWrongFormat',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get formTitle {
    return Intl.message(
      'Title',
      name: 'formTitle',
      desc: '',
      args: [],
    );
  }

  /// `To address`
  String get formToAddress {
    return Intl.message(
      'To address',
      name: 'formToAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add form`
  String get addFormTitle {
    return Intl.message(
      'Add form',
      name: 'addFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save form`
  String get addFormSave {
    return Intl.message(
      'Save form',
      name: 'addFormSave',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get addFormCancel {
    return Intl.message(
      'Discard changes',
      name: 'addFormCancel',
      desc: '',
      args: [],
    );
  }

  /// `A form with the given title already exists`
  String get formAddConflict {
    return Intl.message(
      'A form with the given title already exists',
      name: 'formAddConflict',
      desc: '',
      args: [],
    );
  }

  /// `The form could not be saved`
  String get formAddGeneric {
    return Intl.message(
      'The form could not be saved',
      name: 'formAddGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Edit form`
  String get editFormTitle {
    return Intl.message(
      'Edit form',
      name: 'editFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save form`
  String get editFormSave {
    return Intl.message(
      'Save form',
      name: 'editFormSave',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get editFormCancel {
    return Intl.message(
      'Discard changes',
      name: 'editFormCancel',
      desc: '',
      args: [],
    );
  }

  /// `A form with the given title already exists`
  String get formEditConflict {
    return Intl.message(
      'A form with the given title already exists',
      name: 'formEditConflict',
      desc: '',
      args: [],
    );
  }

  /// `The form could not be saved`
  String get formEditGeneric {
    return Intl.message(
      'The form could not be saved',
      name: 'formEditGeneric',
      desc: '',
      args: [],
    );
  }

  /// `The title cannot be empty`
  String get editFormTitleCannotBeEmpty {
    return Intl.message(
      'The title cannot be empty',
      name: 'editFormTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The to address cannot be empty`
  String get editFormToAddressCannotBeEmpty {
    return Intl.message(
      'The to address cannot be empty',
      name: 'editFormToAddressCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The to address must be an email`
  String get editFormToAddressWrongFormat {
    return Intl.message(
      'The to address must be an email',
      name: 'editFormToAddressWrongFormat',
      desc: '',
      args: [],
    );
  }

  /// `Arrange {title}`
  String formDesigner(Object title) {
    return Intl.message(
      'Arrange $title',
      name: 'formDesigner',
      desc: '',
      args: [title],
    );
  }

  /// `Text input`
  String get addFormItemText {
    return Intl.message(
      'Text input',
      name: 'addFormItemText',
      desc: '',
      args: [],
    );
  }

  /// `Email input`
  String get addFormItemEmail {
    return Intl.message(
      'Email input',
      name: 'addFormItemEmail',
      desc: '',
      args: [],
    );
  }

  /// `Multiline input`
  String get addFormItemMultiline {
    return Intl.message(
      'Multiline input',
      name: 'addFormItemMultiline',
      desc: '',
      args: [],
    );
  }

  /// `Dropdown`
  String get addFormItemDropdown {
    return Intl.message(
      'Dropdown',
      name: 'addFormItemDropdown',
      desc: '',
      args: [],
    );
  }

  /// `Checkbox`
  String get addFormItemCheckbox {
    return Intl.message(
      'Checkbox',
      name: 'addFormItemCheckbox',
      desc: '',
      args: [],
    );
  }

  /// `Email input`
  String get formItemTypeEmail {
    return Intl.message(
      'Email input',
      name: 'formItemTypeEmail',
      desc: '',
      args: [],
    );
  }

  /// `Multiline input`
  String get formItemTypeMultiline {
    return Intl.message(
      'Multiline input',
      name: 'formItemTypeMultiline',
      desc: '',
      args: [],
    );
  }

  /// `Text input`
  String get formItemTypeText {
    return Intl.message(
      'Text input',
      name: 'formItemTypeText',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get editItemDiscard {
    return Intl.message(
      'Discard changes',
      name: 'editItemDiscard',
      desc: '',
      args: [],
    );
  }

  /// `Save item`
  String get editItemSave {
    return Intl.message(
      'Save item',
      name: 'editItemSave',
      desc: '',
      args: [],
    );
  }

  /// `Label`
  String get editFormItemLabel {
    return Intl.message(
      'Label',
      name: 'editFormItemLabel',
      desc: '',
      args: [],
    );
  }

  /// `Placeholder`
  String get editFormItemPlaceholder {
    return Intl.message(
      'Placeholder',
      name: 'editFormItemPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Help text`
  String get editFormItemHelpText {
    return Intl.message(
      'Help text',
      name: 'editFormItemHelpText',
      desc: '',
      args: [],
    );
  }

  /// `Spam filter`
  String get editFormItemSpamFilter {
    return Intl.message(
      'Spam filter',
      name: 'editFormItemSpamFilter',
      desc: '',
      args: [],
    );
  }

  /// `Is subject`
  String get editFormItemIsSubject {
    return Intl.message(
      'Is subject',
      name: 'editFormItemIsSubject',
      desc: '',
      args: [],
    );
  }

  /// `Is required`
  String get editFormItemIsRequired {
    return Intl.message(
      'Is required',
      name: 'editFormItemIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Is from address`
  String get editFormItemIsFromAddress {
    return Intl.message(
      'Is from address',
      name: 'editFormItemIsFromAddress',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get editFormItemOptions {
    return Intl.message(
      'Options',
      name: 'editFormItemOptions',
      desc: '',
      args: [],
    );
  }

  /// `The label cannot be empty`
  String get editFormItemLabelCannotBeEmpty {
    return Intl.message(
      'The label cannot be empty',
      name: 'editFormItemLabelCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Blog`
  String get menuBlog {
    return Intl.message(
      'Blog',
      name: 'menuBlog',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get menuManageBlogCategories {
    return Intl.message(
      'Categories',
      name: 'menuManageBlogCategories',
      desc: '',
      args: [],
    );
  }

  /// `Posts`
  String get menuManageBlogPosts {
    return Intl.message(
      'Posts',
      name: 'menuManageBlogPosts',
      desc: '',
      args: [],
    );
  }

  /// `The category {name} is in use and cannot be deleted`
  String failedToDeleteCategoryConflict(Object name) {
    return Intl.message(
      'The category $name is in use and cannot be deleted',
      name: 'failedToDeleteCategoryConflict',
      desc: '',
      args: [name],
    );
  }

  /// `The category {name} could not be deleted`
  String failedToDeleteCategoryGeneric(Object name) {
    return Intl.message(
      'The category $name could not be deleted',
      name: 'failedToDeleteCategoryGeneric',
      desc: '',
      args: [name],
    );
  }

  /// `Add category`
  String get addBlogCategory {
    return Intl.message(
      'Add category',
      name: 'addBlogCategory',
      desc: '',
      args: [],
    );
  }

  /// `The name cannot be empty`
  String get addCategoryTitleCannotBeEmpty {
    return Intl.message(
      'The name cannot be empty',
      name: 'addCategoryTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No parent`
  String get categoryNoParent {
    return Intl.message(
      'No parent',
      name: 'categoryNoParent',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get categoryName {
    return Intl.message(
      'Name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get categoryDescription {
    return Intl.message(
      'Description',
      name: 'categoryDescription',
      desc: '',
      args: [],
    );
  }

  /// `Parent`
  String get categoryParent {
    return Intl.message(
      'Parent',
      name: 'categoryParent',
      desc: '',
      args: [],
    );
  }

  /// `Webhook URL`
  String get categoryWebhookUrl {
    return Intl.message(
      'Webhook URL',
      name: 'categoryWebhookUrl',
      desc: '',
      args: [],
    );
  }

  /// `Webhook enabled`
  String get categoryWebhookEnabled {
    return Intl.message(
      'Webhook enabled',
      name: 'categoryWebhookEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Save category`
  String get saveCategory {
    return Intl.message(
      'Save category',
      name: 'saveCategory',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get discardCategory {
    return Intl.message(
      'Discard changes',
      name: 'discardCategory',
      desc: '',
      args: [],
    );
  }

  /// `Edit category`
  String get editBlogCategory {
    return Intl.message(
      'Edit category',
      name: 'editBlogCategory',
      desc: '',
      args: [],
    );
  }

  /// `The name cannot be empty`
  String get editCategoryTitleCannotBeEmpty {
    return Intl.message(
      'The name cannot be empty',
      name: 'editCategoryTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `A category with the given name already exists`
  String get categoryAddConflict {
    return Intl.message(
      'A category with the given name already exists',
      name: 'categoryAddConflict',
      desc: '',
      args: [],
    );
  }

  /// `The category could not be saved`
  String get categoryAddGeneric {
    return Intl.message(
      'The category could not be saved',
      name: 'categoryAddGeneric',
      desc: '',
      args: [],
    );
  }

  /// `A category with the given name already exists`
  String get categoryEditConflict {
    return Intl.message(
      'A category with the given name already exists',
      name: 'categoryEditConflict',
      desc: '',
      args: [],
    );
  }

  /// `The category could not be saved`
  String get categoryEditGeneric {
    return Intl.message(
      'The category could not be saved',
      name: 'categoryEditGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Add post`
  String get addBlogPost {
    return Intl.message(
      'Add post',
      name: 'addBlogPost',
      desc: '',
      args: [],
    );
  }

  /// `Discard post`
  String get discardPost {
    return Intl.message(
      'Discard post',
      name: 'discardPost',
      desc: '',
      args: [],
    );
  }

  /// `Save post`
  String get savePost {
    return Intl.message(
      'Save post',
      name: 'savePost',
      desc: '',
      args: [],
    );
  }

  /// `Edit post`
  String get editBlogPost {
    return Intl.message(
      'Edit post',
      name: 'editBlogPost',
      desc: '',
      args: [],
    );
  }

  /// `The post {title} is in use and cannot be deleted`
  String failedToDeletePostConflict(Object title) {
    return Intl.message(
      'The post $title is in use and cannot be deleted',
      name: 'failedToDeletePostConflict',
      desc: '',
      args: [title],
    );
  }

  /// `The post {title} could not be deleted`
  String failedToDeletePostGeneric(Object title) {
    return Intl.message(
      'The post $title could not be deleted',
      name: 'failedToDeletePostGeneric',
      desc: '',
      args: [title],
    );
  }

  /// `Title`
  String get postTitle {
    return Intl.message(
      'Title',
      name: 'postTitle',
      desc: '',
      args: [],
    );
  }

  /// `Slug`
  String get postSlug {
    return Intl.message(
      'Slug',
      name: 'postSlug',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get postCategory {
    return Intl.message(
      'Category',
      name: 'postCategory',
      desc: '',
      args: [],
    );
  }

  /// `Post image`
  String get postImage {
    return Intl.message(
      'Post image',
      name: 'postImage',
      desc: '',
      args: [],
    );
  }

  /// `Public`
  String get postPublic {
    return Intl.message(
      'Public',
      name: 'postPublic',
      desc: '',
      args: [],
    );
  }

  /// `No post image`
  String get postNoHeaderImage {
    return Intl.message(
      'No post image',
      name: 'postNoHeaderImage',
      desc: '',
      args: [],
    );
  }

  /// `The title cannot be empty`
  String get addPostTitleCannotBeEmpty {
    return Intl.message(
      'The title cannot be empty',
      name: 'addPostTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The slug cannot be empty`
  String get addPostSlugCannotBeEmpty {
    return Intl.message(
      'The slug cannot be empty',
      name: 'addPostSlugCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `A post with the given title or slug already exists`
  String get postAddConflict {
    return Intl.message(
      'A post with the given title or slug already exists',
      name: 'postAddConflict',
      desc: '',
      args: [],
    );
  }

  /// `The post could not be saved`
  String get postAddGeneric {
    return Intl.message(
      'The post could not be saved',
      name: 'postAddGeneric',
      desc: '',
      args: [],
    );
  }

  /// `A post with the given title or slug already exists`
  String get postEditConflict {
    return Intl.message(
      'A post with the given title or slug already exists',
      name: 'postEditConflict',
      desc: '',
      args: [],
    );
  }

  /// `The post could not be saved`
  String get postEditGeneric {
    return Intl.message(
      'The post could not be saved',
      name: 'postEditGeneric',
      desc: '',
      args: [],
    );
  }

  /// `The title cannot be empty`
  String get editPostTitleCannotBeEmpty {
    return Intl.message(
      'The title cannot be empty',
      name: 'editPostTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The slug cannot be empty`
  String get editPostSlugCannotBeEmpty {
    return Intl.message(
      'The slug cannot be empty',
      name: 'editPostSlugCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The post could not be saved`
  String get postSegmentsError {
    return Intl.message(
      'The post could not be saved',
      name: 'postSegmentsError',
      desc: '',
      args: [],
    );
  }

  /// `The post was saved successfully`
  String get postSegmentsSaved {
    return Intl.message(
      'The post was saved successfully',
      name: 'postSegmentsSaved',
      desc: '',
      args: [],
    );
  }

  /// `Menus`
  String get menuMenu {
    return Intl.message(
      'Menus',
      name: 'menuMenu',
      desc: '',
      args: [],
    );
  }

  /// `The menu {name} is in use and cannot be deleted`
  String failedToDeleteMenuConflict(Object name) {
    return Intl.message(
      'The menu $name is in use and cannot be deleted',
      name: 'failedToDeleteMenuConflict',
      desc: '',
      args: [name],
    );
  }

  /// `The menu {name} could not be deleted`
  String failedToDeleteMenuGeneric(Object name) {
    return Intl.message(
      'The menu $name could not be deleted',
      name: 'failedToDeleteMenuGeneric',
      desc: '',
      args: [name],
    );
  }

  /// `Delete form?`
  String get deleteMenuTitle {
    return Intl.message(
      'Delete form?',
      name: 'deleteMenuTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete the menu {name}?`
  String deleteMenuMessage(Object name) {
    return Intl.message(
      'Do you really want to delete the menu $name?',
      name: 'deleteMenuMessage',
      desc: '',
      args: [name],
    );
  }

  /// `Arrange {name}`
  String menuDesigner(Object name) {
    return Intl.message(
      'Arrange $name',
      name: 'menuDesigner',
      desc: '',
      args: [name],
    );
  }

  /// `Link artist`
  String get menuDesignerAddItemArtist {
    return Intl.message(
      'Link artist',
      name: 'menuDesignerAddItemArtist',
      desc: '',
      args: [],
    );
  }

  /// `Link simple page`
  String get menuDesignerAddItemSimplePage {
    return Intl.message(
      'Link simple page',
      name: 'menuDesignerAddItemSimplePage',
      desc: '',
      args: [],
    );
  }

  /// `Link segment page`
  String get menuDesignerAddItemSegmentPage {
    return Intl.message(
      'Link segment page',
      name: 'menuDesignerAddItemSegmentPage',
      desc: '',
      args: [],
    );
  }

  /// `Link form`
  String get menuDesignerAddItemForm {
    return Intl.message(
      'Link form',
      name: 'menuDesignerAddItemForm',
      desc: '',
      args: [],
    );
  }

  /// `Link gallery`
  String get menuDesignerAddItemGallery {
    return Intl.message(
      'Link gallery',
      name: 'menuDesignerAddItemGallery',
      desc: '',
      args: [],
    );
  }

  /// `Link blog category`
  String get menuDesignerAddItemBlogCategory {
    return Intl.message(
      'Link blog category',
      name: 'menuDesignerAddItemBlogCategory',
      desc: '',
      args: [],
    );
  }

  /// `Link blog home page`
  String get menuDesignerAddItemBlogHomePage {
    return Intl.message(
      'Link blog home page',
      name: 'menuDesignerAddItemBlogHomePage',
      desc: '',
      args: [],
    );
  }

  /// `Link external website`
  String get menuDesignerAddItemExternalLink {
    return Intl.message(
      'Link external website',
      name: 'menuDesignerAddItemExternalLink',
      desc: '',
      args: [],
    );
  }

  /// `Add group`
  String get menuDesignerAddItemGroup {
    return Intl.message(
      'Add group',
      name: 'menuDesignerAddItemGroup',
      desc: '',
      args: [],
    );
  }

  /// `The title cannot be empty`
  String get menuDesignerEditItemTitleCannotBeEmpty {
    return Intl.message(
      'The title cannot be empty',
      name: 'menuDesignerEditItemTitleCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get menuDesignerEditItemTitle {
    return Intl.message(
      'Title',
      name: 'menuDesignerEditItemTitle',
      desc: '',
      args: [],
    );
  }

  /// `Route`
  String get menuDesignerEditItemRoute {
    return Intl.message(
      'Route',
      name: 'menuDesignerEditItemRoute',
      desc: '',
      args: [],
    );
  }

  /// `Highlighted`
  String get menuDesignerEditItemHighlighted {
    return Intl.message(
      'Highlighted',
      name: 'menuDesignerEditItemHighlighted',
      desc: '',
      args: [],
    );
  }

  /// `Save group`
  String get menuDesignerEditItemSaveGroup {
    return Intl.message(
      'Save group',
      name: 'menuDesignerEditItemSaveGroup',
      desc: '',
      args: [],
    );
  }

  /// `Discard changes`
  String get menuDesignerEditItemDiscardChanges {
    return Intl.message(
      'Discard changes',
      name: 'menuDesignerEditItemDiscardChanges',
      desc: '',
      args: [],
    );
  }

  /// `Artist`
  String get menuDesignerItemArtist {
    return Intl.message(
      'Artist',
      name: 'menuDesignerItemArtist',
      desc: '',
      args: [],
    );
  }

  /// `Simple page`
  String get menuDesignerItemSimplePage {
    return Intl.message(
      'Simple page',
      name: 'menuDesignerItemSimplePage',
      desc: '',
      args: [],
    );
  }

  /// `Segment page`
  String get menuDesignerItemSegmentPage {
    return Intl.message(
      'Segment page',
      name: 'menuDesignerItemSegmentPage',
      desc: '',
      args: [],
    );
  }

  /// `Form`
  String get menuDesignerItemForm {
    return Intl.message(
      'Form',
      name: 'menuDesignerItemForm',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get menuDesignerItemGallery {
    return Intl.message(
      'Gallery',
      name: 'menuDesignerItemGallery',
      desc: '',
      args: [],
    );
  }

  /// `Blog category`
  String get menuDesignerItemBlogCategory {
    return Intl.message(
      'Blog category',
      name: 'menuDesignerItemBlogCategory',
      desc: '',
      args: [],
    );
  }

  /// `Blog home page`
  String get menuDesignerItemBlogHomePage {
    return Intl.message(
      'Blog home page',
      name: 'menuDesignerItemBlogHomePage',
      desc: '',
      args: [],
    );
  }

  /// `External website`
  String get menuDesignerItemExternalLink {
    return Intl.message(
      'External website',
      name: 'menuDesignerItemExternalLink',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get menuDesignerItemGroup {
    return Intl.message(
      'Group',
      name: 'menuDesignerItemGroup',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get menuDesignerItemType {
    return Intl.message(
      'Type',
      name: 'menuDesignerItemType',
      desc: '',
      args: [],
    );
  }

  /// `Route`
  String get menuDesignerItemRoute {
    return Intl.message(
      'Route',
      name: 'menuDesignerItemRoute',
      desc: '',
      args: [],
    );
  }

  /// `Add item`
  String get menuDesignerEditDialogTitle {
    return Intl.message(
      'Add item',
      name: 'menuDesignerEditDialogTitle',
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
