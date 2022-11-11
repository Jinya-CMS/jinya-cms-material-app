import 'dart:io' as io;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/media/upload_files_page.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class ListFiles extends StatefulWidget {
  const ListFiles({super.key});

  @override
  ListFilesState createState() => ListFilesState();
}

class ListFilesState extends State<ListFiles> {
  Iterable<jinya.File> files = <jinya.File>[];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Future<void> loadFiles() async {
    final files = await apiClient.getFiles();
    setState(() {
      this.files = files;
    });
  }

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  Widget itemBuilder(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    final item = files.elementAt(index);
    final children = [
      ListTile(
        title: Text(item.name!),
      ),
      CachedNetworkImage(
        imageUrl: SettingsDatabase.selectedAccount!.url + (item.path ?? ''),
        fit: BoxFit.cover,
        height: 240,
        width: double.infinity,
        progressIndicatorBuilder: (context, url, progress) => Container(
          height: 48,
          width: 48,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      ),
    ];

    if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
      children.add(
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final result = await prompt(
                  context,
                  textOK: Text(l10n.editFileSave),
                  textCancel: Text(l10n.editFileCancel),
                  initialValue: item.name!,
                  title: Text(l10n.editFileTitle),
                  hintText: l10n.editFileName,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return l10n.editFileNameEmpty;
                    }
                    return null;
                  },
                );
                if (result != null) {
                  try {
                    item.name = result;
                    await apiClient.updateFile(item);
                    await loadFiles();
                  } catch (e) {
                    messenger.showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(l10n.failedUploading(item.name!)),
                      ),
                    );
                  }
                }
              },
              child: const Icon(Icons.edit),
            ),
            TextButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final result = await FilePicker.platform.pickFiles(
                  dialogTitle: l10n.chooseFiles,
                  type: FileType.image,
                );
                if (result != null) {
                  try {
                    await apiClient.startFileUpload(item.id!);
                    await apiClient.uploadFileChunk(item.id!, 0, await io.File(result.paths.first!).readAsBytes());
                    await apiClient.finishFileUpload(item.id!);
                    await loadFiles();
                  } catch (e) {
                    messenger.showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(l10n.failedUploading(item.name!)),
                      ),
                    );
                  }
                }
              },
              child: const Icon(Icons.upload),
            ),
            TextButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.deleteFileTitle),
                    content: Text(l10n.deleteFileMessage(item.name!)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          NavigationService.instance.goBack();
                        },
                        child: Text(l10n.keep),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await apiClient.deleteFile(item.id!);
                            NavigationService.instance.goBack();
                            await loadFiles();
                          } on jinya.ConflictException {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteFileConflict(item.name!)),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteFileGeneric(item.name!)),
                            ));
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).errorColor,
                        ),
                        child: Text(l10n.delete),
                      ),
                    ],
                  ),
                );
              },
              child: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      );
    }
    return Card(
      margin: const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.manageFilesTitle),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const JinyaNavigationDrawer(),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadFiles();
          },
          child: query.size.width >= 720
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: query.size.width >= 1080 ? 4 : 2,
                    childAspectRatio: query.size.width >= 1080 ? 9 / 11 : 9 / 9,
                  ),
                  itemCount: files.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                )
              : ListView.builder(
                  itemCount: files.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                ),
        ),
      ),
      floatingActionButton: SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
          ? FloatingActionButton(
              child: const Icon(Icons.upload_file),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UploadFilesPage(
                      onBack: () => loadFiles(),
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }
}
