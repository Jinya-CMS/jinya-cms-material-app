import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:notustohtml/notustohtml.dart';

class _EditSimplePage extends StatefulWidget {
  const _EditSimplePage(this.page, {super.key});

  final jinya.SimplePage page;

  @override
  _EditSimplePageState createState() => _EditSimplePageState(page);
}

class _EditSimplePageState extends State<_EditSimplePage> {
  _EditSimplePageState(this.page) {
    _titleController.text = page.title!;
    try {
      final delta = converter.decode(page.content!);
      final document = ParchmentDocument.fromDelta(delta);
      _contentController = FleatherController(document);
    } catch (ex) {
      hideEditor = true;
    }
  }

  bool hideEditor = false;
  final converter = const NotusHtmlCodec();
  final jinya.SimplePage page;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  FleatherController _contentController = FleatherController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final fleather = <Widget>[];
    if (!hideEditor) {
      fleather.add(FleatherToolbar.basic(controller: _contentController));
      fleather.add(Expanded(
        child: FleatherEditor(controller: _contentController),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.editSimplePage),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final apiClient = SettingsDatabase.getClientForCurrentAccount();
                try {
                  await apiClient.updateSimplePage(jinya.SimplePage(
                    id: page.id,
                    title: _titleController.text,
                    content: hideEditor ? page.content : converter.encode(_contentController.document.toDelta()),
                  ));
                  NavigationService.instance.goBack();
                } on jinya.ConflictException {
                  final dialog = AlertDialog(
                    title: Text(l10n.saveFailed),
                    content: Text(l10n.simplePageEditConflict),
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
                    content: Text(l10n.simplePageEditGeneric),
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
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 32.0,
        ),
        child: Scrollbar(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.editSimplePageTitleCannotBeEmpty;
                    }

                    return null;
                  },
                  decoration: InputDecoration(labelText: l10n.simplePageTitle),
                ),
                ...fleather
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddSimplePage extends StatefulWidget {
  const _AddSimplePage({super.key});

  @override
  _AddSimplePageState createState() => _AddSimplePageState();
}

class _AddSimplePageState extends State<_AddSimplePage> {
  final converter = const NotusHtmlCodec();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final FleatherController _contentController = FleatherController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.addSimplePage),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final apiClient = SettingsDatabase.getClientForCurrentAccount();
                try {
                  await apiClient.createSimplePage(
                    _titleController.text,
                    converter.encode(
                      _contentController.document.toDelta(),
                    ),
                  );
                  NavigationService.instance.goBack();
                } on jinya.ConflictException {
                  final dialog = AlertDialog(
                    title: Text(l10n.saveFailed),
                    content: Text(l10n.simplePageEditConflict),
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
                    content: Text(l10n.simplePageEditGeneric),
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
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 32.0,
        ),
        child: Scrollbar(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.addSimplePageTitleCannotBeEmpty;
                    }

                    return null;
                  },
                  decoration: InputDecoration(labelText: l10n.simplePageTitle),
                ),
                FleatherToolbar.basic(controller: _contentController),
                Expanded(
                  child: FleatherEditor(controller: _contentController),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

  Widget itemBuilder(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
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
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _EditSimplePage(page),
                  ),
                );
                await loadPages();
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
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => _AddSimplePage(),
                  ),
                );
                await loadPages();
              },
            )
          : null,
    );
  }
}
