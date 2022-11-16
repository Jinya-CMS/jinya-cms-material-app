import 'package:cached_network_image/cached_network_image.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:flutter/material.dart';
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

  _MenuDesignerItem(this.nestingIndex, this.parent, this.type, jinya.MenuItem item)
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

class _MenuDesignerEditGroup extends StatefulWidget {
  const _MenuDesignerEditGroup(this.item, this.menu, {super.key});

  final _MenuDesignerItem? item;
  final jinya.Menu menu;

  @override
  State<_MenuDesignerEditGroup> createState() => _MenuDesignerEditGroupState(item, menu);
}

class _MenuDesignerEditGroupState extends State<_MenuDesignerEditGroup> {
  final _MenuDesignerItem? item;
  final jinya.Menu menu;
  final _formKey = GlobalKey<FormState>();
  bool _isHighlighted = false;
  final _titleController = TextEditingController();

  _MenuDesignerEditGroupState(this.item, this.menu) {
    _titleController.text = item?.title ?? '';
    _isHighlighted = item?.highlighted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.menuDesignerItemGroup),
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                  decoration: InputDecoration(labelText: l10n.menuDesignerEditItemTitle),
                ),
              ),
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
            ],
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
                  '',
                  0,
                  _titleController.text,
                  highlighted: _isHighlighted,
                );
              } else {
                await apiClient.updateMenuItem(
                  item!.id!,
                  route: '',
                  position: item!.position,
                  title: _titleController.text,
                  highlighted: _isHighlighted,
                );
              }
              NavigationService.instance.goBack();
            }
          },
          child: Text(l10n.menuDesignerEditItemSaveGroup),
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

  Iterable<jinya.Gallery> galleries = [];
  Iterable<jinya.Artist> artists = [];
  Iterable<jinya.SimplePage> simplePages = [];
  Iterable<jinya.SegmentPage> segmentPages = [];
  Iterable<jinya.Form> forms = [];
  Iterable<jinya.BlogCategory> blogCategories = [];

  Future<void> loadForms() async {
    final forms = await apiClient.getForms();
    setState(() {
      this.forms = forms;
    });
  }

  Future<void> loadCategories() async {
    final blogCategories = await apiClient.getBlogCategories();
    setState(() {
      this.blogCategories = blogCategories;
    });
  }

  Future<void> loadGalleries() async {
    final galleries = await apiClient.getGalleries();
    setState(() {
      this.galleries = galleries;
    });
  }

  Future<void> loadSegmentPages() async {
    final segmentPages = await apiClient.getSegmentPages();
    setState(() {
      this.segmentPages = segmentPages;
    });
  }

  Future<void> loadSimplePages() async {
    final simplePages = await apiClient.getSimplePages();
    setState(() {
      this.simplePages = simplePages;
    });
  }

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
      final resultingItem = _MenuDesignerItem(nestingIndex, parent, getType(item), item);
      result.add(resultingItem);
      if (items.isNotEmpty) {
        result.addAll(flattenItems(parent: resultingItem, nestingIndex: nestingIndex + 1, items: item.items ?? []));
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

      if (item.items?.isNotEmpty == true && item.items?.elementAt(0).position != item.position) {
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
      ));
    }

    if (increaseAllowed) {
      buttons.add(IconButton(
        onPressed: () async {
          final previous = items[items.indexOf(item) - 1];
          if (previous.nestingIndex > 0 && item.nestingIndex == previous.nestingIndex) {
            await apiClient.moveMenuItemToNewParent(item.id!, previous.id!);
          } else {
            await apiClient.moveMenuItemToNewParent(item.id!, previous.parent?.id ?? previous.id!);
          }
          await loadItems();
        },
        icon: const Icon(Icons.format_indent_increase),
      ));
    }

    buttons.add(IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () async {
        switch (item.type) {
          case _MenuDesignerItemType.artist:
            // TODO: Handle this case.
            break;
          case _MenuDesignerItemType.simplePage:
            // TODO: Handle this case.
            break;
          case _MenuDesignerItemType.segmentPage:
            // TODO: Handle this case.
            break;
          case _MenuDesignerItemType.form:
            // TODO: Handle this case.
            break;
          case _MenuDesignerItemType.gallery:
            // TODO: Handle this case.
            break;
          case _MenuDesignerItemType.blogCategory:
            // TODO: Handle this case.
            break;
          case _MenuDesignerItemType.blogHomePage:
            // TODO: Handle this case.
            break;
          case _MenuDesignerItemType.externalLink:
            // TODO: Handle this case.
            break;
          case _MenuDesignerItemType.group:
            final dialog = _MenuDesignerEditGroup(item, menu);
            await showDialog(context: context, builder: (context) => dialog);
            await loadItems();
            break;
        }
      },
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
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: _MenuDesignerItemType.artist,
                  child: Text(l10n.menuDesignerAddItemArtist),
                ),
                PopupMenuItem(
                  value: _MenuDesignerItemType.simplePage,
                  child: Text(l10n.menuDesignerAddItemSimplePage),
                ),
                PopupMenuItem(
                  value: _MenuDesignerItemType.segmentPage,
                  child: Text(l10n.menuDesignerAddItemSegmentPage),
                ),
                PopupMenuItem(
                  value: _MenuDesignerItemType.form,
                  child: Text(l10n.menuDesignerAddItemForm),
                ),
                PopupMenuItem(
                  value: _MenuDesignerItemType.gallery,
                  child: Text(l10n.menuDesignerAddItemGallery),
                ),
                PopupMenuItem(
                  value: _MenuDesignerItemType.blogCategory,
                  child: Text(l10n.menuDesignerAddItemBlogCategory),
                ),
                PopupMenuItem(
                  value: _MenuDesignerItemType.blogHomePage,
                  child: Text(l10n.menuDesignerAddItemBlogHomePage),
                ),
                PopupMenuItem(
                  value: _MenuDesignerItemType.externalLink,
                  child: Text(l10n.menuDesignerAddItemExternalLink),
                ),
                PopupMenuItem(
                  value: _MenuDesignerItemType.group,
                  child: Text(l10n.menuDesignerAddItemGroup),
                ),
              ];
            },
            onSelected: (value) async {
              switch (value) {
                case _MenuDesignerItemType.artist:
                  // TODO: Handle this case.
                  break;
                case _MenuDesignerItemType.simplePage:
                  // TODO: Handle this case.
                  break;
                case _MenuDesignerItemType.segmentPage:
                  // TODO: Handle this case.
                  break;
                case _MenuDesignerItemType.form:
                  // TODO: Handle this case.
                  break;
                case _MenuDesignerItemType.gallery:
                  // TODO: Handle this case.
                  break;
                case _MenuDesignerItemType.blogCategory:
                  // TODO: Handle this case.
                  break;
                case _MenuDesignerItemType.blogHomePage:
                  // TODO: Handle this case.
                  break;
                case _MenuDesignerItemType.externalLink:
                  // TODO: Handle this case.
                  break;
                case _MenuDesignerItemType.group:
                  final dialog = _MenuDesignerEditGroup(null, menu);
                  await showDialog(context: context, builder: (context) => dialog);
                  await loadItems();
                  break;
              }
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Scrollbar(
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) async {
            final dropIdx = newIndex > oldIndex ? newIndex + 1 : newIndex;
            final item = items[oldIndex];
            final menuItemId = item.id;
            final targetItem = dropIdx == items.length ? items[newIndex] : items[dropIdx];
            final position = dropIdx == items.length ? items[newIndex].position! + 1 : targetItem.position;
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
          imageUrl: SettingsDatabase.selectedAccount!.url + (menu.logo?.path ?? ''),
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
            TextButton(
              onPressed: () async {
                // await showDialog(
                //   context: context,
                //   builder: (context) => _EditFormDialog(menu),
                // );
                await loadMenus();
              },
              child: const Icon(Icons.edit),
            ),
            TextButton(
              onPressed: () async {
                await NavigationService.instance.navigateTo(MaterialPageRoute(
                  builder: (context) => _MenuDesigner(menu),
                ));
                await loadMenus();
              },
              child: const Icon(Icons.reorder),
            ),
            TextButton(
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
                              content: Text(l10n.failedToDeleteMenuConflict(menu.name!)),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteMenuGeneric(menu.name!)),
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
                    childAspectRatio: query.size.width >= 1080
                        ? MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height)
                        : MediaQuery.of(context).size.height / (MediaQuery.of(context).size.width),
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
      floatingActionButton: SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                // final dialog = _AddFormDialog();
                // await showDialog(
                //   context: context,
                //   builder: (context) => dialog,
                // );
                await loadMenus();
              },
            )
          : null,
    );
  }
}
