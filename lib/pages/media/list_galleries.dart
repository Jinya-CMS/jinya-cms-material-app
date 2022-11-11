import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/media/add_gallery_dialog.dart';
import 'package:jinya_cms_material_app/pages/media/edit_gallery_dialog.dart';
import 'package:jinya_cms_material_app/pages/media/gallery_designer.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';

class ListGalleries extends StatefulWidget {
  const ListGalleries({super.key});

  @override
  _ListGalleriesState createState() => _ListGalleriesState();
}

class _ListGalleriesState extends State<ListGalleries> {
  Iterable<jinya.Gallery> galleries = <jinya.Gallery>[];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Future<void> loadGalleries() async {
    final galleries = await apiClient.getGalleries();
    setState(() {
      this.galleries = galleries;
    });
  }

  @override
  void initState() {
    super.initState();
    loadGalleries();
  }

  Widget itemBuilder(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    final gallery = galleries.elementAt(index);
    final children = <Widget>[
      ListTile(
        title: Text(gallery.name!),
        subtitle: Text(gallery.description!),
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
          gallery.orientation == jinya.Orientation.horizontal
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
          gallery.type == jinya.Type.masonry ? Text(l10n.galleryTypeGrid) : Text(l10n.galleryTypeList),
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
              onPressed: () {
                NavigationService.instance.navigateTo(MaterialPageRoute(
                  builder: (context) => GalleryDesigner(gallery),
                ));
              },
              child: const Icon(Icons.reorder),
            ),
            TextButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.deleteGalleryTitle),
                    content: Text(l10n.deleteGalleryMessage(gallery.name!)),
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
                            await apiClient.deleteGallery(gallery.id!);
                            NavigationService.instance.goBack();
                            await loadGalleries();
                          } on jinya.ConflictException {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteGalleryConflict(gallery.name!)),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteGalleryGeneric(gallery.name!)),
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
        title: Text(l10n!.manageGalleriesTitle),
      ),
      drawer: const JinyaNavigationDrawer(),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadGalleries();
          },
          child: query.size.width >= 720
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: query.size.width >= 1080 ? 4 : 2,
                    childAspectRatio: query.size.width >= 1080
                        ? MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height)
                        : MediaQuery.of(context).size.height / (MediaQuery.of(context).size.width),
                  ),
                  itemCount: galleries.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                )
              : ListView.builder(
                  itemCount: galleries.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
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
