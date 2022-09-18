import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/network/media/galleries.dart' as media;
import 'package:jinya_cms_material_app/network/media/files.dart' as mediaFiles;
import 'package:jinya_cms_material_app/shared/currentUser.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';

class GalleryDesigner extends StatefulWidget {
  media.Gallery gallery;

  GalleryDesigner(this.gallery, {super.key});

  @override
  _GalleryDesignerState createState() => _GalleryDesignerState(gallery);
}

class _GalleryDesignerState extends State<GalleryDesigner> {
  media.Gallery gallery;
  Iterable<mediaFiles.File> files = [];
  Iterable<media.GalleryFilePosition> positions = [];

  _GalleryDesignerState(this.gallery);

  loadFiles() async {
    final files = await mediaFiles.getFiles();
    setState(() {
      this.files = files;
    });
  }

  loadPositions() async {
    final positions = await media.getPositions(gallery.id);
    setState(() {
      this.positions = positions;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPositions();
    loadFiles();
  }

  void resetPositions() {
    setState(() {
      for (var i = 0; i < positions.length; i++) {
        positions.elementAt(i).position = i;
      }
    });
  }

  Future<void> removePosition(media.GalleryFilePosition position) async {
    await media.removePosition(gallery.id, position.position);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.galleryDesigner(gallery.name)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              final positionIds = positions.map((m) => m.file.id);
              final files = this.files.where((value) => !positionIds.contains(value.id));

              final dialog = AlertDialog(
                title: Text(l10n.pickFile),
                actions: [
                  TextButton(
                    onPressed: () {
                      NavigationService.instance.goBack();
                    },
                    child: Text(l10n.dismiss),
                  ),
                ],
                content: ListView.builder(
                  itemBuilder: (context, index) {
                    final file = files.elementAt(index);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () async {
                          final position = await media.addPosition(gallery.id, file.id!, positions.length);
                          final data = positions.toList();
                          data.add(position);
                          setState(() {
                            positions = data;
                          });
                          NavigationService.instance.goBack();
                        },
                        child: CachedNetworkImage(
                          imageUrl: '${SettingsDatabase.selectedAccount!.url}/${file.path}',
                        ),
                      ),
                    );
                  },
                  itemCount: files.length,
                ),
              );
              await showDialog(context: context, builder: (context) => dialog);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.instance.goBack();
          },
        ),
      ),
      body: ReorderableListView(
        children: positions
            .map(
              (position) => Dismissible(
                key: Key(position.id.toString()),
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
                onDismissed: (direction) {
                  removePosition(position);
                  final filtered = positions.where((element) => element.id != position.id);
                  setState(() {
                    positions = filtered;
                    resetPositions();
                  });
                },
                direction: DismissDirection.endToStart,
                child: ListTile(
                  key: Key('tile${position.id}'),
                  title: Text(position.file.name!),
                  leading: CachedNetworkImage(
                    imageUrl: '${SettingsDatabase.selectedAccount!.url}/${position.file.path}',
                    width: 80,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
            .toList(),
        onReorder: (int oldIndex, int newIndex) {
          final pos = positions.toList();
          final oldPos = pos.elementAt(oldIndex);
          if (oldIndex > newIndex) {
            pos.removeAt(oldIndex);
            pos.insert(newIndex, oldPos);
          } else {
            pos.insert(newIndex, oldPos);
            pos.removeAt(oldIndex);
          }
          setState(() {
            positions = pos;
            resetPositions();
          });
          media.updatePosition(gallery.id, oldIndex, newIndex);
        },
      ),
    );
  }
}
