import 'package:flutter/material.dart';
import 'package:jinya_cms_app/l10n/localizations.dart';
import 'package:jinya_cms_app/network/errors/ConflictException.dart';
import 'package:jinya_cms_app/network/media/galleries.dart';
import 'package:jinya_cms_app/network/media/galleries.dart' as media;
import 'package:jinya_cms_app/pages/media/add_gallery_dialog.dart';
import 'package:jinya_cms_app/pages/media/edit_gallery_dialog.dart';
import 'package:jinya_cms_app/shared/currentUser.dart';
import 'package:jinya_cms_app/shared/navDrawer.dart';
import 'package:jinya_cms_app/shared/navigator_service.dart';

class ListGalleries extends StatefulWidget {
  const ListGalleries({super.key});

  @override
  _ListGalleriesState createState() => _ListGalleriesState();
}

class _ListGalleriesState extends State<ListGalleries> {
  var galleries = <Gallery>[];

  Future<void> loadGalleries() async {
    final galleries = await getGalleries();
    setState(() {
      this.galleries = galleries;
    });
  }

  @override
  void initState() {
    super.initState();
    loadGalleries();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.manageGalleriesTitle),
      ),
      drawer: const JinyaNavigationDrawer(),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadGalleries();
          },
          child: ListView.builder(
            itemCount: galleries.length,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (context, index) {
              final gallery = galleries[index];
              final children = <Widget>[
                ListTile(
                  title: Text(gallery.name),
                  subtitle: Text(gallery.description),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                      child: Text(
                        l10n.galleryOrientation,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    gallery.orientation == media.Orientation.horizontal
                        ? Text(l10n.galleryOrientationHorizontal)
                        : Text(l10n.galleryOrientationVertical),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                      child: Text(
                        l10n.galleryType,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    gallery.type == media.Type.masonry ? Text(l10n.galleryTypeGrid) : Text(l10n.galleryTypeList),
                  ],
                ),
              ];

              if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
                children.add(
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () async {
                          final dialog = EditGalleryDialog(gallery);
                          await showDialog(context: context, builder: (context) => dialog);
                          await loadGalleries();
                        },
                        child: const Icon(Icons.edit),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Icon(Icons.reorder),
                      ),
                      TextButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(l10n.deleteGalleryTitle),
                              content: Text(l10n.deleteGalleryMessage(gallery.name)),
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
                                      await deleteGallery(gallery.id);
                                      NavigationService.instance.goBack();
                                      await loadGalleries();
                                    } on ConflictException {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(l10n.failedToDeleteGalleryConflict(gallery.name)),
                                      ));
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(l10n.failedToDeleteGalleryGeneric(gallery.name)),
                                      ));
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    primary: Theme.of(context).errorColor,
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
            },
          ),
        ),
      ),
      floatingActionButton: SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                const dialog = AddGalleryDialog();
                await showDialog(context: context, builder: (context) => dialog);
                await loadGalleries();
              },
            )
          : null,
    );
  }
}
