import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/pages/add_simple_page.dart';
import 'package:jinya_cms_material_app/pages/pages/edit_simple_page.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';

class ListSimplePages extends StatefulWidget {
  const ListSimplePages({super.key});

  @override
  State<StatefulWidget> createState() => _ListSimplePagesState();
}

class _ListSimplePagesState extends State<ListSimplePages> {
  Iterable<jinya.SimplePage> pages = <jinya.SimplePage>[];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Future<void> loadPages() async {
    final pages = await apiClient.getSimplePages();
    setState(() {
      this.pages = pages;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPages();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.manageSimplePagesTitle),
      ),
      drawer: const JinyaNavigationDrawer(),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadPages();
          },
          child: ListView.builder(
            itemCount: pages.length,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (context, index) {
              final page = pages.elementAt(index);
              final children = <Widget>[
                ListTile(
                  title: Text(page.title!),
                ),
              ];

              if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
                children.add(
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditSimplePage(page, onSave: () {
                                loadPages();
                              }),
                            ),
                          );
                        },
                        child: const Icon(Icons.edit),
                      ),
                      TextButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(l10n.deleteSimplePageTitle),
                              content: Text(l10n.deleteSimplePageMessage(page.title!)),
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
                                      await apiClient.deleteSimplePage(page.id!);
                                      NavigationService.instance.goBack();
                                      await loadPages();
                                    } on jinya.ConflictException {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(l10n.failedToDeleteSimplePageConflict(page.title!)),
                                      ));
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(l10n.failedToDeleteSimplePageGeneric(page.title!)),
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
            },
          ),
        ),
      ),
      floatingActionButton: SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddSimplePage(onSave: () {
                      loadPages();
                    }),
                  ),
                );
              },
            )
          : null,
    );
  }
}
