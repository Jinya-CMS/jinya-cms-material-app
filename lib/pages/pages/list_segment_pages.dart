import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/pages/add_simple_page.dart';
import 'package:jinya_cms_material_app/pages/pages/edit_simple_page.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class ListSegmentPages extends StatefulWidget {
  const ListSegmentPages({super.key});

  @override
  State<StatefulWidget> createState() => _ListSegmentPagesState();
}

class _ListSegmentPagesState extends State<ListSegmentPages> {
  Iterable<jinya.SegmentPage> pages = <jinya.SegmentPage>[];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Future<void> loadPages() async {
    final pages = await apiClient.getSegmentPages();
    setState(() {
      this.pages = pages;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPages();
  }

  Widget itemBuilder(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context);
    final page = pages.elementAt(index);
    final children = <Widget>[
      ListTile(
        title: Text(page.name!),
        subtitle: Text(l10n!.segmentPageSegmentCount(page.segmentCount!)),
      ),
    ];

    if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
      children.add(
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                final response = await prompt(
                  context,
                  title: Text(l10n.editSegmentPage),
                  textOK: Text(l10n.editSegmentPageSave),
                  textCancel: Text(l10n.editSegmentPageCancel),
                  initialValue: page.name,
                  validator: (p0) => p0!.isEmpty ? l10n.editSegmentPageTitleCannotBeEmpty : null,
                  hintText: l10n.segmentPageName,
                );

                if (response != null) {
                  try {
                    final client = SettingsDatabase.getClientForCurrentAccount();
                    await client.updateSegmentPage(jinya.SegmentPage(id: page.id, name: response));
                    await loadPages();
                  } on jinya.ConflictException {
                    final dialog = AlertDialog(
                      title: Text(l10n.saveFailed),
                      content: Text(l10n.segmentPageEditConflict),
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
                      content: Text(l10n.segmentPageEditGeneric),
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
              child: const Icon(Icons.edit),
            ),
            TextButton(
              onPressed: () {
                // NavigationService.instance.navigateTo(MaterialPageRoute(
                //   builder: (context) => GalleryDesigner(gallery),
                // ));
              },
              child: const Icon(Icons.reorder),
            ),
            TextButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.deleteSegmentPageTitle),
                    content: Text(l10n.deleteSegmentPageMessage(page.name!)),
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
                            await apiClient.deleteSegmentPage(page.id!);
                            NavigationService.instance.goBack();
                            await loadPages();
                          } on jinya.ConflictException {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteSegmentPageConflict(page.name!)),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteSegmentPageGeneric(page.name!)),
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
        title: Text(l10n!.manageSegmentPagesTitle),
      ),
      drawer: const JinyaNavigationDrawer(),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadPages();
          },
          child: query.size.width >= 720
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: query.size.width >= 1080 ? 4 : 2,
                    childAspectRatio: query.size.width >= 1080
                        ? MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height)
                        : MediaQuery.of(context).size.height / (MediaQuery.of(context).size.width),
                  ),
                  itemCount: pages.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                )
              : ListView.builder(
                  itemCount: pages.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                ),
        ),
      ),
      floatingActionButton: SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                final response = await prompt(
                  context,
                  title: Text(l10n.addSegmentPage),
                  textOK: Text(l10n.addSegmentPageSave),
                  textCancel: Text(l10n.addSegmentPageCancel),
                  validator: (p0) => p0!.isEmpty ? l10n.addSegmentPageTitleCannotBeEmpty : null,
                  hintText: l10n.segmentPageName,
                );

                if (response != null) {
                  try {
                    final client = SettingsDatabase.getClientForCurrentAccount();
                    await client.createSegmentPage(response);
                    await loadPages();
                  } on jinya.ConflictException {
                    final dialog = AlertDialog(
                      title: Text(l10n.saveFailed),
                      content: Text(l10n.segmentPageAddConflict),
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
                      content: Text(l10n.segmentPageAddGeneric),
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
            )
          : null,
    );
  }
}
