import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:uuid/uuid.dart';

enum _MenuDesignerItemType {
  artist,
  simplePage,
  segmentPage,
  form,
  gallery,
  blogCategory,
  blogHomePage,
  externalLink,
  group,
}

class _MenuDesignerItem extends jinya.MenuItem {
  int nestingIndex;
  _MenuDesignerItem? parent;
  _MenuDesignerItemType type;

  _MenuDesignerItem(
      this.nestingIndex, this.parent, this.type, jinya.MenuItem item)
      : super(
          id: item.id,
          position: item.position,
          highlighted: item.highlighted,
          title: item.title,
          route: item.route,
          blogHomePage: item.blogHomePage,
          form: item.form,
          page: item.page,
          artist: item.artist,
          category: item.category,
          gallery: item.gallery,
          segmentPage: item.segmentPage,
          items: item.items,
        );
}

class _MenuDesignerEditDialog extends StatefulWidget {
  const _MenuDesignerEditDialog(this.item, this.menu, {super.key});

  final _MenuDesignerItem? item;
  final jinya.Menu menu;

  @override
  State<_MenuDesignerEditDialog> createState() =>
      _MenuDesignerEditDialogState(item, menu);
}

class _MenuDesignerEditDialogState extends State<_MenuDesignerEditDialog> {
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  final _MenuDesignerItem? item;
  final jinya.Menu menu;
  final _formKey = GlobalKey<FormState>();
  bool _isHighlighted = false;
  final _titleController = TextEditingController();
  final _routeController = TextEditingController();
  var type = _MenuDesignerItemType.group;
  int? selectedGalleryId;
  int? selectedArtistId;
  int? selectedSimplePageId;
  int? selectedSegmentPageId;
  int? selectedFormId;
  int? selectedBlogCategoryId;

  @override
  void dispose() {
    _titleController.dispose();
    _routeController.dispose();
    super.dispose();
  }

  _MenuDesignerEditDialogState(this.item, this.menu) {
    _titleController.text = item?.title ?? '';
    _routeController.text = item?.route ?? '';
    _isHighlighted = item?.highlighted ?? false;
    selectedArtistId = item?.artist?.id ?? 0;
    type = item?.type ?? _MenuDesignerItemType.group;
  }

  Iterable<jinya.Gallery> galleries = [];
  Iterable<jinya.Artist> artists = [];
  Iterable<jinya.SimplePage> simplePages = [];
  Iterable<jinya.SegmentPage> segmentPages = [];
  Iterable<jinya.Form> forms = [];
  Iterable<jinya.BlogCategory> blogCategories = [];

  Future<void> loadArtists() async {
    final artists = await apiClient.getArtists();
    setState(() {
      this.artists = artists;
      if (artists.isNotEmpty) {
        selectedArtistId = item?.artist?.id ?? artists.first.id;
      }
    });
  }

  Future<void> loadForms() async {
    final forms = await apiClient.getForms();
    setState(() {
      this.forms = forms;
      if (forms.isNotEmpty) {
        selectedFormId = item?.form?.id ?? forms.first.id!;
      }
    });
  }

  Future<void> loadCategories() async {
    final blogCategories = await apiClient.getBlogCategories();
    setState(() {
      this.blogCategories = blogCategories;
      if (blogCategories.isNotEmpty) {
        selectedBlogCategoryId = item?.category?.id ?? blogCategories.first.id!;
      }
    });
  }

  Future<void> loadGalleries() async {
    final galleries = await apiClient.getGalleries();
    setState(() {
      this.galleries = galleries;
      if (galleries.isNotEmpty) {
        selectedGalleryId = item?.gallery?.id ?? galleries.first.id!;
      }
    });
  }

  Future<void> loadSegmentPages() async {
    final segmentPages = await apiClient.getSegmentPages();
    setState(() {
      this.segmentPages = segmentPages;
      if (segmentPages.isNotEmpty) {
        selectedSegmentPageId = item?.segmentPage?.id ?? segmentPages.first.id!;
      }
    });
  }

  Future<void> loadSimplePages() async {
    final simplePages = await apiClient.getSimplePages();
    setState(() {
      this.simplePages = simplePages;
      if (simplePages.isNotEmpty) {
        selectedSimplePageId = item?.page?.id ?? simplePages.first.id!;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
    loadForms();
    loadGalleries();
    loadSegmentPages();
    loadSimplePages();
    loadArtists();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dropdownMenuItems = <DropdownMenuItem>[
      DropdownMenuItem(
        value: _MenuDesignerItemType.group,
        child: Text(l10n.menuDesignerItemGroup),
      ),
      DropdownMenuItem(
        value: _MenuDesignerItemType.blogHomePage,
        child: Text(l10n.menuDesignerItemBlogHomePage),
      ),
      DropdownMenuItem(
        value: _MenuDesignerItemType.externalLink,
        child: Text(l10n.menuDesignerItemExternalLink),
      ),
      DropdownMenuItem(
        value: _MenuDesignerItemType.artist,
        child: Text(l10n.menuDesignerItemArtist),
      ),
    ];

    if (simplePages.isNotEmpty) {
      dropdownMenuItems.add(
        DropdownMenuItem(
          value: _MenuDesignerItemType.simplePage,
          child: Text(l10n.menuDesignerItemSimplePage),
        ),
      );
    }

    if (segmentPages.isNotEmpty) {
      dropdownMenuItems.add(
        DropdownMenuItem(
          value: _MenuDesignerItemType.segmentPage,
          child: Text(l10n.menuDesignerItemSegmentPage),
        ),
      );
    }

    if (forms.isNotEmpty) {
      dropdownMenuItems.add(
        DropdownMenuItem(
          value: _MenuDesignerItemType.form,
          child: Text(l10n.menuDesignerItemForm),
        ),
      );
    }

    if (galleries.isNotEmpty) {
      dropdownMenuItems.add(
        DropdownMenuItem(
          value: _MenuDesignerItemType.gallery,
          child: Text(l10n.menuDesignerItemGallery),
        ),
      );
    }

    if (blogCategories.isNotEmpty) {
      dropdownMenuItems.add(
        DropdownMenuItem(
          value: _MenuDesignerItemType.blogCategory,
          child: Text(l10n.menuDesignerItemBlogCategory),
        ),
      );
    }

    final children = <Widget>[];
    if (item == null) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DropdownButtonFormField(
            value: type,
            items: dropdownMenuItems,
            onChanged: (value) {
              setState(() {
                type = value!;
              });
            },
          ),
        ),
      );
    }

    children.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return l10n.menuDesignerEditItemTitleCannotBeEmpty;
            }

            return null;
          },
          controller: _titleController,
          maxLines: 1,
          decoration:
              InputDecoration(labelText: l10n.menuDesignerEditItemTitle),
        ),
      ),
    );

    if (type != _MenuDesignerItemType.group &&
        type != _MenuDesignerItemType.blogHomePage) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.menuDesignerEditItemTitleCannotBeEmpty;
              }

              return null;
            },
            controller: _routeController,
            maxLines: 1,
            decoration:
                InputDecoration(labelText: l10n.menuDesignerEditItemRoute),
          ),
        ),
      );
    }

    switch (type) {
      case _MenuDesignerItemType.artist:
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField(
              items: artists
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.artistName!),
                      ))
                  .toList(),
              value: selectedArtistId,
              onChanged: (int? value) {
                setState(() {
                  selectedArtistId = value!;
                });
              },
              decoration:
                  InputDecoration(label: Text(l10n.menuDesignerItemArtist)),
            ),
          ),
        );
        break;
      case _MenuDesignerItemType.simplePage:
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField(
              items: simplePages
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.title!),
                      ))
                  .toList(),
              value: selectedArtistId,
              onChanged: (int? value) {
                setState(() {
                  selectedArtistId = value!;
                });
              },
              decoration:
                  InputDecoration(label: Text(l10n.menuDesignerItemSimplePage)),
            ),
          ),
        );
        break;
      case _MenuDesignerItemType.segmentPage:
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField(
              items: segmentPages
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name!),
                      ))
                  .toList(),
              value: selectedSegmentPageId,
              onChanged: (int? value) {
                setState(() {
                  selectedSegmentPageId = value!;
                });
              },
              decoration: InputDecoration(
                  label: Text(l10n.menuDesignerItemSegmentPage)),
            ),
          ),
        );
        break;
      case _MenuDesignerItemType.form:
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField(
              items: forms
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.title!),
                      ))
                  .toList(),
              value: selectedFormId,
              onChanged: (int? value) {
                setState(() {
                  selectedFormId = value!;
                });
              },
              decoration:
                  InputDecoration(label: Text(l10n.menuDesignerItemForm)),
            ),
          ),
        );
        break;
      case _MenuDesignerItemType.gallery:
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField(
              items: galleries
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name!),
                      ))
                  .toList(),
              value: selectedGalleryId,
              onChanged: (int? value) {
                setState(() {
                  selectedGalleryId = value!;
                });
              },
              decoration:
                  InputDecoration(label: Text(l10n.menuDesignerItemGallery)),
            ),
          ),
        );
        break;
      case _MenuDesignerItemType.blogCategory:
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField(
              items: blogCategories
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name!),
                      ))
                  .toList(),
              value: selectedBlogCategoryId,
              onChanged: (int? value) {
                setState(() {
                  selectedBlogCategoryId = value!;
                });
              },
              decoration: InputDecoration(
                  label: Text(l10n.menuDesignerItemBlogCategory)),
            ),
          ),
        );
        break;
      default:
        break;
    }

    children.add(
      Row(
        children: [
          Switch(
            value: _isHighlighted,
            onChanged: (value) {
              setState(() {
                _isHighlighted = value;
              });
            },
          ),
          Text(l10n.menuDesignerEditItemHighlighted),
        ],
      ),
    );

    return AlertDialog(
      scrollable: true,
      title: Text(item == null
          ? l10n.menuDesignerAddDialogTitle
          : l10n.menuDesignerEditDialogTitle),
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: children,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.menuDesignerEditItemDiscardChanges),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final apiClient = SettingsDatabase.getClientForCurrentAccount();
              if (item == null) {
                await apiClient.createMenuItemByMenu(
                  menu.id!,
                  _routeController.text,
                  0,
                  _titleController.text,
                  highlighted: _isHighlighted,
                  artist: type == _MenuDesignerItemType.artist
                      ? selectedArtistId
                      : null,
                  category: type == _MenuDesignerItemType.blogCategory
                      ? selectedBlogCategoryId
                      : null,
                  gallery: type == _MenuDesignerItemType.gallery
                      ? selectedGalleryId
                      : null,
                  segmentPage: type == _MenuDesignerItemType.segmentPage
                      ? selectedSegmentPageId
                      : null,
                  page: type == _MenuDesignerItemType.simplePage
                      ? selectedSimplePageId
                      : null,
                  form: type == _MenuDesignerItemType.form
                      ? selectedFormId
                      : null,
                  blogHomePage: type == _MenuDesignerItemType.blogHomePage,
                );
              } else {
                await apiClient.updateMenuItem(
                  item!.id!,
                  route: _routeController.text,
                  position: item!.position,
                  title: _titleController.text,
                  highlighted: _isHighlighted,
                  artist: type == _MenuDesignerItemType.artist
                      ? selectedArtistId
                      : null,
                  category: type == _MenuDesignerItemType.blogCategory
                      ? selectedBlogCategoryId
                      : null,
                  gallery: type == _MenuDesignerItemType.gallery
                      ? selectedGalleryId
                      : null,
                  segmentPage: type == _MenuDesignerItemType.segmentPage
                      ? selectedSegmentPageId
                      : null,
                  page: type == _MenuDesignerItemType.simplePage
                      ? selectedSimplePageId
                      : null,
                  form: type == _MenuDesignerItemType.form
                      ? selectedFormId
                      : null,
                  blogHomePage: type == _MenuDesignerItemType.blogHomePage,
                );
              }
              NavigationService.instance.goBack();
            }
          },
          child: Text(l10n.menuDesignerEditItemSaveChanges),
        ),
      ],
    );
  }
}

class _MenuDesigner extends StatefulWidget {
  final jinya.Menu menu;

  const _MenuDesigner(this.menu, {super.key});

  @override
  State<StatefulWidget> createState() => _MenuDesignerState(menu);
}

class _MenuDesignerState extends State<_MenuDesigner> {
  final jinya.Menu menu;
  final uuid = const Uuid();
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  List<_MenuDesignerItem> items = [];

  _MenuDesignerItemType getType(jinya.MenuItem item) {
    if (item.artist != null) {
      return _MenuDesignerItemType.artist;
    } else if (item.page != null) {
      return _MenuDesignerItemType.simplePage;
    } else if (item.segmentPage != null) {
      return _MenuDesignerItemType.segmentPage;
    } else if (item.form != null) {
      return _MenuDesignerItemType.form;
    } else if (item.gallery != null) {
      return _MenuDesignerItemType.gallery;
    } else if (item.category != null) {
      return _MenuDesignerItemType.blogCategory;
    } else if (item.blogHomePage == true) {
      return _MenuDesignerItemType.blogHomePage;
    } else if (item.route?.isNotEmpty == true) {
      return _MenuDesignerItemType.externalLink;
    }

    return _MenuDesignerItemType.group;
  }

  List<_MenuDesignerItem> flattenItems({
    _MenuDesignerItem? parent,
    int nestingIndex = 0,
    required Iterable<jinya.MenuItem> items,
  }) {
    final result = <_MenuDesignerItem>[];

    for (var item in items) {
      final resultingItem =
          _MenuDesignerItem(nestingIndex, parent, getType(item), item);
      result.add(resultingItem);
      if (items.isNotEmpty) {
        result.addAll(flattenItems(
            parent: resultingItem,
            nestingIndex: nestingIndex + 1,
            items: item.items ?? []));
      }
    }

    return result;
  }

  _MenuDesignerState(this.menu);

  loadItems() async {
    final items = flattenItems(items: await apiClient.getMenuItems(menu.id!));
    setState(() {
      this.items = items;
    });
  }

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  List<_MenuDesignerItem> findItemsToRemove(_MenuDesignerItem removedItem) {
    final result = <_MenuDesignerItem>[];

    for (var item in items) {
      if (item.parent?.id == removedItem.id) {
        result.addAll(findItemsToRemove(item));
        result.add(item);
      }
    }

    return result;
  }

  void resetPositions() {
    setState(() {
      for (var i = 0; i < items.length; i++) {
        items.elementAt(i).position = i;
      }
    });
  }

  Future<void> removeItem(jinya.MenuItem item) async {
    await apiClient.deleteMenuItem(item.id!);
  }

  Widget getEntryByType(_MenuDesignerItem item) {
    final l10n = AppLocalizations.of(context)!;

    final buttons = <Widget>[];
    var decreaseAllowed = item.nestingIndex != 0;
    var increaseAllowed = true;

    final current = items.indexOf(item);
    if (current != 0) {
      final previous = items.elementAt(current - 1);

      if (item.items?.isNotEmpty == true &&
          item.items?.elementAt(0).position != item.position) {
        increaseAllowed = !(item.parent == previous);
      } else if (previous.nestingIndex < item.nestingIndex) {
        increaseAllowed = false;
      }
    } else {
      increaseAllowed = false;
    }

    if (decreaseAllowed) {
      buttons.add(IconButton(
        onPressed: () async {
          await apiClient.moveMenuItemParentOneLevelUp(menu.id!, item.id!);
          await loadItems();
        },
        icon: const Icon(Icons.format_indent_decrease),
        tooltip: l10n.menuDesignerDecreaseItem,
      ));
    }

    if (increaseAllowed) {
      buttons.add(IconButton(
        onPressed: () async {
          final previous = items[items.indexOf(item) - 1];
          if (previous.nestingIndex > 0 &&
              item.nestingIndex == previous.nestingIndex) {
            await apiClient.moveMenuItemToNewParent(item.id!, previous.id!);
          } else {
            await apiClient.moveMenuItemToNewParent(
                item.id!, previous.parent?.id ?? previous.id!);
          }
          await loadItems();
        },
        icon: const Icon(Icons.format_indent_increase),
        tooltip: l10n.menuDesignerIncreaseItem,
      ));
    }

    buttons.add(IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () async {
        final dialog = _MenuDesignerEditDialog(item, menu);
        await showDialog(context: context, builder: (context) => dialog);
        await loadItems();
      },
      tooltip: l10n.menuDesignerEditItem,
    ));

    var typeOfItem = '';
    switch (item.type) {
      case _MenuDesignerItemType.artist:
        typeOfItem = l10n.menuDesignerItemArtist;
        break;
      case _MenuDesignerItemType.simplePage:
        typeOfItem = l10n.menuDesignerItemSimplePage;
        break;
      case _MenuDesignerItemType.segmentPage:
        typeOfItem = l10n.menuDesignerItemSegmentPage;
        break;
      case _MenuDesignerItemType.form:
        typeOfItem = l10n.menuDesignerItemForm;
        break;
      case _MenuDesignerItemType.gallery:
        typeOfItem = l10n.menuDesignerItemGallery;
        break;
      case _MenuDesignerItemType.blogCategory:
        typeOfItem = l10n.menuDesignerItemBlogCategory;
        break;
      case _MenuDesignerItemType.blogHomePage:
        typeOfItem = l10n.menuDesignerItemBlogHomePage;
        break;
      case _MenuDesignerItemType.externalLink:
        typeOfItem = l10n.menuDesignerItemExternalLink;
        break;
      case _MenuDesignerItemType.group:
        typeOfItem = l10n.menuDesignerItemGroup;
        break;
    }

    var subtitle = '${l10n.menuDesignerItemType}: $typeOfItem';
    if (item.type != _MenuDesignerItemType.group) {
      subtitle += '\n${l10n.menuDesignerItemRoute}: ${item.route ?? ''}';
    }

    return Padding(
      padding: EdgeInsets.only(left: item.nestingIndex * 16),
      child: ListTile(
        title: Text(item.title!),
        isThreeLine: subtitle.contains('\n'),
        subtitle: Text(subtitle),
        trailing: SizedBox(
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: buttons,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.menuDesigner(menu.name!)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.instance.goBack();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final dialog = _MenuDesignerEditDialog(null, menu);
              await showDialog(context: context, builder: (context) => dialog);
              await loadItems();
            },
            icon: const Icon(Icons.add),
            tooltip: l10n.menuDesignerAddItem,
          )
        ],
      ),
      body: Scrollbar(
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) async {
            final dropIdx = newIndex > oldIndex ? newIndex + 1 : newIndex;
            final item = items[oldIndex];
            final menuItemId = item.id;
            final targetItem =
                dropIdx == items.length ? items[newIndex] : items[dropIdx];
            final position = dropIdx == items.length
                ? items[newIndex].position! + 1
                : targetItem.position;
            final newParent = targetItem.parent?.id;
            final dataParentId = item.parent?.id;
            final parentList = items.where((i) => i.id == dataParentId);
            var currentParent = parentList.isNotEmpty ? parentList.first : null;
            if (newParent != null) {
              var allowMove = true;
              while (currentParent != null) {
                if (currentParent.id == menuItemId) {
                  allowMove = false;
                  break;
                }

                currentParent = currentParent.parent;
              }

              if (allowMove) {
                await apiClient.moveMenuItemToNewParent(menuItemId!, newParent);
                await apiClient.moveMenuItem(menuItemId, position!);
              }
            } else {
              await apiClient.moveMenuItemToMenuParent(menu.id!, menuItemId!);
              await apiClient.moveMenuItem(menuItemId, position!);
            }
            await loadItems();
          },
          children: items
              .map(
                (item) => Dismissible(
                  key: Key(uuid.v4()),
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
                    removeItem(item);
                    final itemsToRemove = [item, ...findItemsToRemove(item)];
                    setState(() {
                      for (var itemToRemove in itemsToRemove) {
                        if (items.contains(itemToRemove)) {
                          items.remove(itemToRemove);
                        }
                      }
                    });
                  },
                  direction: DismissDirection.endToStart,
                  child: getEntryByType(item),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _AddMenuDialog extends StatefulWidget {
  const _AddMenuDialog({Key? key}) : super(key: key);

  @override
  State<_AddMenuDialog> createState() => _AddMenuDialogState();
}

class _AddMenuDialogState extends State<_AddMenuDialog> {
  final _formKey = GlobalKey<FormState>();
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  final _nameController = TextEditingController();
  int? _logoId;

  Iterable<jinya.File?> files = [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> loadFiles() async {
    final files = await apiClient.getFiles();
    setState(() {
      this.files = [null, ...files];
    });
  }

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.addMenu),
      scrollable: true,
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.menuNameCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _nameController,
                  decoration: InputDecoration(label: Text(l10n.menuName)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField(
                  onChanged: (value) {
                    _logoId = value;
                  },
                  items: files.map((file) {
                    if (file == null) {
                      return DropdownMenuItem(
                        value: null,
                        child: Text(l10n.menuNoLogo),
                      );
                    }

                    return DropdownMenuItem(
                      value: file.id,
                      child: Text(file.name!),
                    );
                  }).toList(),
                  decoration: InputDecoration(label: Text(l10n.menuLogo)),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.discardMenu),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                await apiClient.createMenu(
                  _nameController.text,
                  _logoId,
                );

                NavigationService.instance.goBack();
              } on jinya.ConflictException {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.menuAddConflict),
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
              } catch (ex) {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.menuAddGeneric),
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
          child: Text(l10n.saveMenu),
        ),
      ],
    );
  }
}

class _EditMenuDialog extends StatefulWidget {
  const _EditMenuDialog(this.menu, {Key? key}) : super(key: key);

  final jinya.Menu menu;

  @override
  State<_EditMenuDialog> createState() => _EditMenuDialogState(menu);
}

class _EditMenuDialogState extends State<_EditMenuDialog> {
  final _formKey = GlobalKey<FormState>();
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  final _nameController = TextEditingController();
  int? _logoId;
  final jinya.Menu menu;

  Iterable<jinya.File?> files = [];

  _EditMenuDialogState(this.menu) {
    _nameController.text = menu.name!;
    _logoId = menu.logo?.id;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> loadFiles() async {
    final files = await apiClient.getFiles();
    setState(() {
      this.files = [null, ...files];
    });
  }

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.editMenu),
      scrollable: true,
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.menuNameCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _nameController,
                  decoration: InputDecoration(label: Text(l10n.menuName)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField(
                  onChanged: (value) {
                    _logoId = value;
                  },
                  value: _logoId,
                  items: files.map((file) {
                    if (file == null) {
                      return DropdownMenuItem(
                        value: null,
                        child: Text(l10n.menuNoLogo),
                      );
                    }

                    return DropdownMenuItem(
                      value: file.id,
                      child: Text(file.name!),
                    );
                  }).toList(),
                  decoration: InputDecoration(label: Text(l10n.menuLogo)),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.discardMenu),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                await apiClient.updateMenu(jinya.Menu(
                  id: menu.id!,
                  name: _nameController.text,
                  logo: files.singleWhere(
                    (element) => element?.id == _logoId,
                    orElse: () => null,
                  ),
                ));

                NavigationService.instance.goBack();
              } on jinya.ConflictException {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.menuEditConflict),
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
              } catch (ex) {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.menuEditGeneric),
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
          child: Text(l10n.saveMenu),
        ),
      ],
    );
  }
}

class Menus extends StatefulWidget {
  const Menus({super.key});

  @override
  _MenusState createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  Iterable<jinya.Menu> menus = [];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Future<void> loadMenus() async {
    final menus = await apiClient.getMenus();
    setState(() {
      this.menus = menus;
    });
  }

  @override
  void initState() {
    super.initState();
    loadMenus();
  }

  Widget itemBuilder(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    final menu = menus.elementAt(index);
    final children = <Widget>[
      ListTile(
        title: Text(menu.name!),
      ),
    ];

    if (menu.logo != null) {
      children.add(
        CachedNetworkImage(
          imageUrl:
              '${SettingsDatabase.selectedAccount!.url}/api/media/file/${menu.logo!.id!}/content',
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
      );
    }

    if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
      children.add(
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => _EditMenuDialog(menu),
                );
                await loadMenus();
              },
              icon: const Icon(Icons.edit),
              tooltip: l10n.addMenu,
            ),
            IconButton(
              onPressed: () async {
                await NavigationService.instance.navigateTo(MaterialPageRoute(
                  builder: (context) => _MenuDesigner(menu),
                ));
                await loadMenus();
              },
              icon: const Icon(Icons.reorder),
              tooltip: l10n.menuDesigner(menu.name!),
            ),
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.deleteMenuTitle),
                    content: Text(l10n.deleteMenuMessage(menu.name!)),
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
                            await apiClient.deleteMenu(menu.id!);
                            NavigationService.instance.goBack();
                            await loadMenus();
                          } on jinya.ConflictException {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  l10n.failedToDeleteMenuConflict(menu.name!)),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  l10n.failedToDeleteMenuGeneric(menu.name!)),
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
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              tooltip: l10n.deleteMenu,
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
    final l10n = AppLocalizations.of(context)!;
    final query = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.menuMenu),
      ),
      drawer: const JinyaNavigationDrawer(),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadMenus();
          },
          child: query.size.width >= 720
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: query.size.width >= 1080 ? 4 : 2,
                    childAspectRatio:
                        query.size.width >= 1080 ? 9 / 12 : 9 / 10,
                  ),
                  itemCount: menus.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                )
              : ListView.builder(
                  itemCount: menus.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                ),
        ),
      ),
      floatingActionButton:
          SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
              ? FloatingActionButton(
                  onPressed: () async {
                    const dialog = _AddMenuDialog();
                    await showDialog(
                      context: context,
                      builder: (context) => dialog,
                    );
                    await loadMenus();
                  },
                  tooltip: l10n.addMenu,
                  child: const Icon(Icons.add),
                )
              : null,
    );
  }
}
