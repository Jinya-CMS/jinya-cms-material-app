import 'package:fleather/fleather.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:notustohtml/notustohtml.dart';
import 'package:validators/validators.dart';

class _AddFormDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddFormDialogState();
}

class _AddFormDialogState extends State<_AddFormDialog> {
  final converter = const NotusHtmlCodec();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _toAddressController = TextEditingController();
  final FleatherController _descriptionController = FleatherController();
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.addFormTitle),
      scrollable: true,
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.addFormTitleCannotBeEmpty;
                    }

                    return null;
                  },
                  decoration: InputDecoration(labelText: l10n.formTitle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _toAddressController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.addFormToAddressCannotBeEmpty;
                    }
                    if (!isEmail(value)) {
                      return l10n.addFormToAddressWrongFormat;
                    }

                    return null;
                  },
                  decoration: InputDecoration(labelText: l10n.formToAddress),
                ),
              ),
              FleatherToolbar.basic(controller: _descriptionController),
              FleatherEditor(
                controller: _descriptionController,
                minHeight: 300,
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
          child: Text(l10n.addFormCancel),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                await apiClient.createForm(
                  converter.encode(_descriptionController.document.toDelta()),
                  _titleController.text,
                  _toAddressController.text,
                );
                NavigationService.instance.goBack();
              } on jinya.ConflictException {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.formAddConflict),
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
                  content: Text(l10n.formAddGeneric),
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
          child: Text(l10n.addFormSave),
        ),
      ],
    );
  }
}

class _EditFormDialog extends StatefulWidget {
  _EditFormDialog(this.form);

  final jinya.Form form;

  @override
  State<StatefulWidget> createState() => _EditFormDialogState(form);
}

class _EditFormDialogState extends State<_EditFormDialog> {
  _EditFormDialogState(this.form) {
    _titleController.text = form.title!;
    _toAddressController.text = form.toAddress!;
    try {
      if (form.description == null) {
        _descriptionController = FleatherController();
      } else {
        final delta = converter.decode(form.description!);
        final document = ParchmentDocument.fromDelta(delta);
        _descriptionController = FleatherController(document);
      }
      hideEditor = false;
    } catch (ex) {
      hideEditor = true;
    }
  }

  final jinya.Form form;
  late final bool hideEditor;

  final converter = const NotusHtmlCodec();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _toAddressController = TextEditingController();
  late final FleatherController _descriptionController;
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final widgets = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          controller: _titleController,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return l10n.editFormTitleCannotBeEmpty;
            }

            return null;
          },
          decoration: InputDecoration(labelText: l10n.formTitle),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          controller: _toAddressController,
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return l10n.editFormToAddressCannotBeEmpty;
            }
            if (!isEmail(value)) {
              return l10n.editFormToAddressWrongFormat;
            }

            return null;
          },
          decoration: InputDecoration(labelText: l10n.formToAddress),
        ),
      ),
    ];
    if (!hideEditor) {
      widgets.add(FleatherToolbar.basic(controller: _descriptionController));
      widgets.add(FleatherEditor(
        controller: _descriptionController,
        minHeight: 300,
      ));
    }

    return AlertDialog(
      title: Text(l10n.editFormTitle),
      scrollable: true,
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: widgets,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.editFormCancel),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                if (!hideEditor) {
                  form.description = converter.encode(_descriptionController.document.toDelta());
                }

                await apiClient.updateForm(jinya.Form(
                  id: form.id,
                  description: form.description,
                  toAddress: _toAddressController.text,
                  title: _titleController.text,
                ));
                NavigationService.instance.goBack();
              } on jinya.ConflictException {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.formEditConflict),
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
                  content: Text(l10n.formEditGeneric),
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
          child: Text(l10n.editFormSave),
        ),
      ],
    );
  }
}

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  Iterable<jinya.Form> forms = [];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Future<void> loadForms() async {
    final forms = await apiClient.getForms();
    setState(() {
      this.forms = forms;
    });
  }

  @override
  void initState() {
    super.initState();
    loadForms();
  }

  Widget itemBuilder(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    final form = forms.elementAt(index);
    final children = <Widget>[
      ListTile(
        title: Text(form.title!),
        subtitle: Text(form.toAddress!),
      ),
    ];

    if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
      children.add(
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => _EditFormDialog(form),
                );
                await loadForms();
              },
              child: const Icon(Icons.edit),
            ),
            TextButton(
              onPressed: () async {
                // await NavigationService.instance.navigateTo(MaterialPageRoute(
                //   builder: (context) => FormDesigner(page),
                // ));
                // await loadPages();
              },
              child: const Icon(Icons.reorder),
            ),
            TextButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.deleteFormTitle),
                    content: Text(l10n.deleteFormMessage(form.title!)),
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
                            await apiClient.deleteForm(form.id!);
                            NavigationService.instance.goBack();
                            await loadForms();
                          } on jinya.ConflictException {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteFormConflict(form.title!)),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.failedToDeleteFormGeneric(form.title!)),
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
        title: Text(l10n.menuForms),
      ),
      drawer: const JinyaNavigationDrawer(),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadForms();
          },
          child: query.size.width >= 720
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: query.size.width >= 1080 ? 4 : 2,
                    childAspectRatio: query.size.width >= 1080
                        ? MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height)
                        : MediaQuery.of(context).size.height / (MediaQuery.of(context).size.width),
                  ),
                  itemCount: forms.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                )
              : ListView.builder(
                  itemCount: forms.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                ),
        ),
      ),
      floatingActionButton: SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                final dialog = _AddFormDialog();
                await showDialog(
                  context: context,
                  builder: (context) => dialog,
                );
                await loadForms();
              },
            )
          : null,
    );
  }
}
