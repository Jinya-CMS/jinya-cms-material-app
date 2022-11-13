import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class _GalleryDesigner extends StatefulWidget {
  final jinya.Gallery gallery;

  const _GalleryDesigner(this.gallery, {super.key});

  @override
  _GalleryDesignerState createState() => _GalleryDesignerState(gallery);
}

class _GalleryDesignerState extends State<_GalleryDesigner> {
  jinya.Gallery gallery;
  Iterable<jinya.File> files = [];
  Iterable<jinya.GalleryFilePosition> positions = [];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  _GalleryDesignerState(this.gallery);

  loadFiles() async {
    final files = await apiClient.getFiles();
    setState(() {
      this.files = files;
    });
  }

  loadPositions() async {
    final positions = await apiClient.getGalleryFilePositions(gallery.id!);
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

  Future<void> removePosition(jinya.GalleryFilePosition position) async {
    await apiClient.deleteGalleryFilePosition(gallery.id!, position.position!);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.galleryDesigner(gallery.name!)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              final positionIds = positions.map((m) => m.file!.id!);
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
                          final position =
                              await apiClient.createGalleryFilePosition(gallery.id!, file.id!, positions.length);
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
                  title: Text(position.file!.name!),
                  leading: CachedNetworkImage(
                    imageUrl: '${SettingsDatabase.selectedAccount!.url}/${position.file!.path!}',
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
          apiClient.moveGalleryFilePosition(gallery.id!, oldIndex, newIndex);
        },
      ),
    );
  }
}

class _AddGalleryDialog extends StatefulWidget {
  const _AddGalleryDialog({super.key});

  @override
  _AddGalleryDialogState createState() => _AddGalleryDialogState();
}

class _AddGalleryDialogState extends State<_AddGalleryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  var _orientation = jinya.Orientation.vertical;
  var _type = jinya.Type.sequence;

  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      scrollable: true,
      title: Text(l10n!.createGalleryTitle),
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.editGalleryNameCannotBeEmpty;
                    }

                    return null;
                  },
                  decoration: InputDecoration(labelText: l10n.galleryName),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(labelText: l10n.galleryDescription),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: l10n.galleryOrientation),
                  value: jinya.Orientation.vertical,
                  items: [
                    DropdownMenuItem(
                      value: jinya.Orientation.vertical,
                      child: Text(l10n.galleryOrientationVertical),
                    ),
                    DropdownMenuItem(
                      value: jinya.Orientation.horizontal,
                      child: Text(l10n.galleryOrientationHorizontal),
                    ),
                  ],
                  onChanged: (jinya.Orientation? value) {
                    _orientation = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: l10n.galleryType),
                  value: jinya.Type.sequence,
                  items: [
                    DropdownMenuItem(
                      value: jinya.Type.masonry,
                      child: Text(l10n.galleryTypeGrid),
                    ),
                    DropdownMenuItem(
                      value: jinya.Type.sequence,
                      child: Text(l10n.galleryTypeList),
                    ),
                  ],
                  onChanged: (jinya.Type? value) {
                    _type = value!;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.discard),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                await apiClient.createGallery(
                  _nameController.text,
                  _descriptionController.text,
                  _orientation,
                  _type,
                );
                NavigationService.instance.goBack();
              } on jinya.ConflictException {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.galleryAddConflict),
                  actions: [
                    TextButton(
                      onPressed: () => NavigationService.instance.goBack(),
                      child: Text(l10n.dismiss),
                    ),
                  ],
                );
                await showDialog(
                  context: context,
                  builder: (context) => dialog,
                );
              } catch (err) {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.galleryAddGeneric),
                  actions: [
                    TextButton(
                      onPressed: () => NavigationService.instance.goBack(),
                      child: Text(l10n.dismiss),
                    ),
                  ],
                );
                await showDialog(
                  context: context,
                  builder: (context) => dialog,
                );
              }
            }
          },
          child: Text(l10n.saveGallery),
        ),
      ],
    );
  }
}

class _EditGalleryDialog extends StatefulWidget {
  final jinya.Gallery gallery;

  const _EditGalleryDialog(this.gallery, {super.key});

  @override
  _EditGalleryDialogState createState() => _EditGalleryDialogState(gallery);
}

class _EditGalleryDialogState extends State<_EditGalleryDialog> {
  jinya.Gallery gallery;

  _EditGalleryDialogState(this.gallery) {
    _nameController.text = gallery.name!;
    _descriptionController.text = gallery.description!;
  }

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  var _orientation = jinya.Orientation.vertical;
  var _type = jinya.Type.sequence;

  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      scrollable: true,
      title: Text(l10n!.createGalleryTitle),
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.editGalleryNameCannotBeEmpty;
                    }

                    return null;
                  },
                  decoration: InputDecoration(labelText: l10n.galleryName),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(labelText: l10n.galleryDescription),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: l10n.galleryOrientation),
                  value: gallery.orientation,
                  items: [
                    DropdownMenuItem(
                      value: jinya.Orientation.vertical,
                      child: Text(l10n.galleryOrientationVertical),
                    ),
                    DropdownMenuItem(
                      value: jinya.Orientation.horizontal,
                      child: Text(l10n.galleryOrientationHorizontal),
                    ),
                  ],
                  onChanged: (jinya.Orientation? value) {
                    _orientation = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: l10n.galleryType),
                  value: gallery.type,
                  items: [
                    DropdownMenuItem(
                      value: jinya.Type.masonry,
                      child: Text(l10n.galleryTypeGrid),
                    ),
                    DropdownMenuItem(
                      value: jinya.Type.sequence,
                      child: Text(l10n.galleryTypeList),
                    ),
                  ],
                  onChanged: (jinya.Type? value) {
                    _type = value!;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.discard),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                await apiClient.updateGallery(jinya.Gallery(
                  name: _nameController.text,
                  description: _descriptionController.text,
                  orientation: _orientation,
                  type: _type,
                  id: gallery.id,
                ));
                NavigationService.instance.goBack();
              } on jinya.ConflictException {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.galleryEditConflict),
                  actions: [
                    TextButton(
                      onPressed: () => NavigationService.instance.goBack(),
                      child: Text(l10n.dismiss),
                    ),
                  ],
                );
                await showDialog(
                  context: context,
                  builder: (context) => dialog,
                );
              } catch (err) {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.galleryEditGeneric),
                  actions: [
                    TextButton(
                      onPressed: () => NavigationService.instance.goBack(),
                      child: Text(l10n.dismiss),
                    ),
                  ],
                );
                await showDialog(
                  context: context,
                  builder: (context) => dialog,
                );
              }
            }
          },
          child: Text(l10n.saveGallery),
        ),
      ],
    );
  }
}

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
                final dialog = _EditGalleryDialog(gallery);
                await showDialog(context: context, builder: (context) => dialog);
                await loadGalleries();
              },
              child: const Icon(Icons.edit),
            ),
            TextButton(
              onPressed: () {
                NavigationService.instance.navigateTo(MaterialPageRoute(
                  builder: (context) => _GalleryDesigner(gallery),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return Scaffold(
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
                        ? 16 / 10
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
                const dialog = _AddGalleryDialog();
                await showDialog(context: context, builder: (context) => dialog);
                await loadGalleries();
              },
            )
          : null,
    );
  }
}
