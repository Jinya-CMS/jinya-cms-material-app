import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/shared/navigator_service.dart';

class _AddBlogCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBlogCategoryState();
}

class _AddBlogCategoryState extends State<_AddBlogCategory> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _webhookUrlController = TextEditingController();
  bool webhookEnabled = false;
  jinya.BlogCategory? parent;
  int? parentId;
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Iterable<jinya.BlogCategory?> categories = [];

  Future<void> loadCategories() async {
    final cats = await apiClient.getBlogCategories();
    setState(() {
      categories = [null, ...cats];
    });
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.addBlogCategory),
      scrollable: true,
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _nameController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: l10n.categoryName),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.addCategoryTitleCannotBeEmpty;
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: l10n.categoryParent),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: categories.map((cat) {
                    if (cat == null) {
                      return DropdownMenuItem(
                        value: null,
                        child: Text(l10n.categoryNoParent),
                      );
                    }

                    return DropdownMenuItem(
                      value: cat.id,
                      child: Text(cat.name!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    parentId = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(labelText: l10n.categoryDescription),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _webhookUrlController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: l10n.categoryWebhookUrl),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: webhookEnabled,
                    onChanged: (value) {
                      setState(() {
                        webhookEnabled = value;
                      });
                    },
                  ),
                  Text(l10n.categoryWebhookEnabled),
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
          child: Text(l10n.discardCategory),
        ),
        TextButton(
          onPressed: () async {
            parent = categories.firstWhere((element) => element?.id == parentId);
            await apiClient.createBlogCategory(
              _nameController.text,
              _descriptionController.text,
              parent?.id,
              webhookEnabled,
              _webhookUrlController.text,
            );

            NavigationService.instance.goBack();
          },
          child: Text(l10n.saveCategory),
        ),
      ],
    );
  }
}

class _EditBlogCategory extends StatefulWidget {
  final jinya.BlogCategory category;

  const _EditBlogCategory(this.category, {super.key});

  @override
  State<StatefulWidget> createState() => _EditBlogCategoryState(category);
}

class _EditBlogCategoryState extends State<_EditBlogCategory> {
  final jinya.BlogCategory category;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _webhookUrlController = TextEditingController();
  bool webhookEnabled = false;
  int? parentId;
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Iterable<jinya.BlogCategory?> categories = [];

  _EditBlogCategoryState(this.category) {
    _nameController.text = category.name!;
    _descriptionController.text = category.description!;
    _webhookUrlController.text = category.webhookUrl!;
    webhookEnabled = category.webhookEnabled ?? false;
    parentId = category.parent?.id;
  }

  Future<void> loadCategories() async {
    final cats = await apiClient.getBlogCategories();
    setState(() {
      categories = [null, ...cats];
    });
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.editBlogCategory),
      scrollable: true,
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _nameController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: l10n.categoryName),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.editCategoryTitleCannotBeEmpty;
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: l10n.categoryParent),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: parentId,
                  items: categories.map((cat) {
                    if (cat == null) {
                      return DropdownMenuItem(
                        value: null,
                        child: Text(l10n.categoryNoParent),
                      );
                    }

                    return DropdownMenuItem(
                      value: cat.id,
                      child: Text(cat.name!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    parentId = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(labelText: l10n.categoryDescription),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _webhookUrlController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: l10n.categoryWebhookUrl),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: webhookEnabled,
                    onChanged: (value) {
                      setState(() {
                        webhookEnabled = value;
                      });
                    },
                  ),
                  Text(l10n.categoryWebhookEnabled),
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
          child: Text(l10n.discardCategory),
        ),
        TextButton(
          onPressed: () async {
            final parent = categories.firstWhere((element) => element?.id == parentId);
            await apiClient.updateBlogCategory(jinya.BlogCategory(
              id: category.id,
              name: _nameController.text,
              description: _descriptionController.text,
              parent: parent,
              webhookEnabled: webhookEnabled,
              webhookUrl: _webhookUrlController.text,
            ));

            NavigationService.instance.goBack();
          },
          child: Text(l10n.saveCategory),
        ),
      ],
    );
  }
}

class ListBlogCategories extends StatefulWidget {
  const ListBlogCategories({super.key});

  @override
  _ListBlogCategoriesState createState() => _ListBlogCategoriesState();
}

class _ListBlogCategoriesState extends State<ListBlogCategories> {
  Iterable<jinya.BlogCategory> categories = <jinya.BlogCategory>[];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Future<void> loadCategories() async {
    final categories = await apiClient.getBlogCategories();
    setState(() {
      this.categories = categories;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Widget itemBuilder(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    final category = categories.elementAt(index);
    final children = <Widget>[
      ListTile(
        title: Text(category.name!),
        subtitle: Text(category.description!),
        isThreeLine: true,
      ),
    ];

    if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
      children.add(
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                final dialog = _EditBlogCategory(category);
                await showDialog(context: context, builder: (context) => dialog);
                await loadCategories();
              },
              child: const Icon(Icons.edit),
            ),
            TextButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.deleteSimplePageTitle),
                    content: Text(l10n.deleteSimplePageMessage(category.name!)),
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
                            await apiClient.deleteBlogCategory(category.id!);
                            NavigationService.instance.goBack();
                            await loadCategories();
                          } on jinya.ConflictException {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteCategoryConflict(category.name!)),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteCategoryGeneric(category.name!)),
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
            await loadCategories();
          },
          child: query.size.width >= 720
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: query.size.width >= 1080 ? 4 : 2,
                    childAspectRatio: query.size.width >= 1080
                        ? MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height)
                        : MediaQuery.of(context).size.height / (MediaQuery.of(context).size.width),
                  ),
                  itemCount: categories.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                )
              : ListView.builder(
                  itemCount: categories.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                ),
        ),
      ),
      floatingActionButton: SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                final dialog = _AddBlogCategory();
                await showDialog(context: context, builder: (context) => dialog);
                await loadCategories();
              },
            )
          : null,
    );
  }
}
