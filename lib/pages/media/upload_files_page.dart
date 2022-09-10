import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_android_app/l10n/localizations.dart';
import 'package:jinya_cms_android_app/network/media/files.dart';
import 'package:jinya_cms_android_app/shared/navigator_service.dart';
import 'dart:io' as io;

import 'package:path/path.dart';

class UploadFilesPage extends StatefulWidget {
  @override
  _UploadFilesPageState createState() => _UploadFilesPageState(this.onBack);

  final Function? onBack;

  UploadFilesPage({super.key, this.onBack});
}

class _UploadFilesPageState extends State<UploadFilesPage> {
  final Function? onBack;

  _UploadFilesPageState(this.onBack);

  List<io.File> files = <io.File>[];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.uploadFiles),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              final dialog = AlertDialog(
                title: Text(l10n.uploadingFiles),
                content: Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: 48,
                  child: const CircularProgressIndicator(),
                ),
              );
              showDialog(context: context, builder: (context) => dialog);
              for (var element in files) {
                final name = basenameWithoutExtension(element.path);
                try {
                  final file = await createFile(name);
                  await uploadFile(file.id!, element);
                } catch (err) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(l10n.failedUploading(name)),
                    ),
                  );
                }
              }
              NavigationService.instance.goBack();
              NavigationService.instance.goBack();
            },
            icon: const Icon(Icons.check),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (onBack != null) {
              onBack!();
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: files.length,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemBuilder: (context, index) => Dismissible(
            background: Container(
              color: Theme.of(context).errorColor,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            key: Key(files[index].path.toString()),
            onDismissed: (direction) {
              setState(() {
                files.removeAt(index);
              });
            },
            direction: DismissDirection.endToStart,
            child: ListTile(
              title: Text(files[index].uri.pathSegments.last),
              leading: Image.file(
                files[index],
                width: 80,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload_file),
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles(
            dialogTitle: l10n.chooseFiles,
            type: FileType.image,
            allowMultiple: true,
          );
          if (result != null) {
            setState(() {
              files = result.paths.map((path) => io.File(path!)).toList();
            });
          }
        },
      ),
    );
  }
}
