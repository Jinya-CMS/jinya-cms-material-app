import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
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
  void dispose() {
    _titleController.dispose();
    _toAddressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
  const _EditFormDialog(this.form);

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

  @override
  void dispose() {
    _titleController.dispose();
    _toAddressController.dispose();
    if (!hideEditor) {
      _descriptionController.dispose();
    }
    super.dispose();
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
                  form.description = converter
                      .encode(_descriptionController.document.toDelta());
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

enum _FormItemType {
  text,
  email,
  multiline,
  dropdown,
  checkbox,
}

class _EditTextItem extends StatefulWidget {
  final jinya.FormItem item;
  final bool newItem;
  final jinya.Form form;

  const _EditTextItem(this.item, this.newItem, this.form, {super.key});

  @override
  State<StatefulWidget> createState() =>
      _EditTextItemState(item, newItem, form);
}

class _EditTextItemState extends State<_EditTextItem> {
  final jinya.Form form;
  final jinya.FormItem item;
  final bool newItem;
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _placeholderController = TextEditingController();
  final _helpTextController = TextEditingController();
  final _spamFilterController = TextEditingController();
  bool isSubject = false;
  bool isRequired = false;

  @override
  void dispose() {
    _labelController.dispose();
    _placeholderController.dispose();
    _helpTextController.dispose();
    _spamFilterController.dispose();
  }

  _EditTextItemState(this.item, this.newItem, this.form) {
    isSubject = item.isSubject ?? false;
    isRequired = item.isRequired ?? false;
    _labelController.text = item.label ?? '';
    _helpTextController.text = item.helpText ?? '';
    _placeholderController.text = item.placeholder ?? '';
    _spamFilterController.text = item.spamFilter?.join('\n') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.formItemTypeText),
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
                      return l10n.editFormItemLabelCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _labelController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemLabel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _placeholderController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemPlaceholder),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _helpTextController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemHelpText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _spamFilterController,
                  maxLines: 5,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemSpamFilter),
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: isSubject,
                    onChanged: (value) {
                      setState(() {
                        isSubject = value;
                      });
                    },
                  ),
                  Text(l10n.editFormItemIsSubject),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: isRequired,
                    onChanged: (value) {
                      setState(() {
                        isRequired = value;
                      });
                    },
                  ),
                  Text(l10n.editFormItemIsRequired),
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
          child: Text(l10n.editItemDiscard),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final apiClient = SettingsDatabase.getClientForCurrentAccount();
              if (newItem) {
                await apiClient.createFormItem(
                  form.id!,
                  'text',
                  0,
                  _labelController.text,
                  placeholder: _placeholderController.text,
                  isRequired: isRequired,
                  isSubject: isSubject,
                  spamFilter: _spamFilterController.text.split('\n'),
                  helpText: _helpTextController.text,
                );
              } else {
                await apiClient.updateFormItem(
                    form.id!,
                    jinya.FormItem(
                      label: _labelController.text,
                      placeholder: _placeholderController.text,
                      isRequired: isRequired,
                      isSubject: isSubject,
                      spamFilter: _spamFilterController.text.split('\n'),
                      helpText: _helpTextController.text,
                      position: item.position,
                    ));
              }
              NavigationService.instance.goBack();
            }
          },
          child: Text(l10n.editItemSave),
        ),
      ],
    );
  }
}

class _EditMultilineItem extends StatefulWidget {
  final jinya.FormItem item;
  final bool newItem;
  final jinya.Form form;

  const _EditMultilineItem(this.item, this.newItem, this.form, {super.key});

  @override
  State<StatefulWidget> createState() =>
      _EditMultilineItemState(item, newItem, form);
}

class _EditMultilineItemState extends State<_EditMultilineItem> {
  final jinya.Form form;
  final jinya.FormItem item;
  final bool newItem;
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _placeholderController = TextEditingController();
  final _helpTextController = TextEditingController();
  final _spamFilterController = TextEditingController();
  bool isRequired = false;

  @override
  void dispose() {
    _labelController.dispose();
    _placeholderController.dispose();
    _helpTextController.dispose();
    _spamFilterController.dispose();
  }

  _EditMultilineItemState(this.item, this.newItem, this.form) {
    isRequired = item.isRequired ?? false;
    _labelController.text = item.label ?? '';
    _helpTextController.text = item.helpText ?? '';
    _placeholderController.text = item.placeholder ?? '';
    _spamFilterController.text = item.spamFilter?.join('\n') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.formItemTypeText),
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
                      return l10n.editFormItemLabelCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _labelController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemLabel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _placeholderController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemPlaceholder),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _helpTextController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemHelpText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _spamFilterController,
                  maxLines: 5,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemSpamFilter),
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: isRequired,
                    onChanged: (value) {
                      setState(() {
                        isRequired = value;
                      });
                    },
                  ),
                  Text(l10n.editFormItemIsRequired),
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
          child: Text(l10n.editItemDiscard),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final apiClient = SettingsDatabase.getClientForCurrentAccount();
              if (newItem) {
                await apiClient.createFormItem(
                  form.id!,
                  'textarea',
                  0,
                  _labelController.text,
                  placeholder: _placeholderController.text,
                  isRequired: isRequired,
                  spamFilter: _spamFilterController.text.split('\n'),
                  helpText: _helpTextController.text,
                );
              } else {
                await apiClient.updateFormItem(
                    form.id!,
                    jinya.FormItem(
                      label: _labelController.text,
                      placeholder: _placeholderController.text,
                      isRequired: isRequired,
                      spamFilter: _spamFilterController.text.split('\n'),
                      helpText: _helpTextController.text,
                      position: item.position,
                    ));
              }
              NavigationService.instance.goBack();
            }
          },
          child: Text(l10n.editItemSave),
        ),
      ],
    );
  }
}

class _EditDropdownItem extends StatefulWidget {
  final jinya.FormItem item;
  final bool newItem;
  final jinya.Form form;

  const _EditDropdownItem(this.item, this.newItem, this.form, {super.key});

  @override
  State<StatefulWidget> createState() =>
      _EditDropdownItemState(item, newItem, form);
}

class _EditDropdownItemState extends State<_EditDropdownItem> {
  final jinya.Form form;
  final jinya.FormItem item;
  final bool newItem;
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _placeholderController = TextEditingController();
  final _helpTextController = TextEditingController();
  final _optionsController = TextEditingController();
  bool isRequired = false;

  @override
  void dispose() {
    _labelController.dispose();
    _placeholderController.dispose();
    _helpTextController.dispose();
    _optionsController.dispose();
  }

  _EditDropdownItemState(this.item, this.newItem, this.form) {
    isRequired = item.isRequired ?? false;
    _labelController.text = item.label ?? '';
    _helpTextController.text = item.helpText ?? '';
    _placeholderController.text = item.placeholder ?? '';
    _optionsController.text = item.options?.join('\n') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.formItemTypeText),
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
                      return l10n.editFormItemLabelCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _labelController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemLabel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _placeholderController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemPlaceholder),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _helpTextController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemHelpText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _optionsController,
                  maxLines: 5,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemOptions),
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: isRequired,
                    onChanged: (value) {
                      setState(() {
                        isRequired = value;
                      });
                    },
                  ),
                  Text(l10n.editFormItemIsRequired),
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
          child: Text(l10n.editItemDiscard),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final apiClient = SettingsDatabase.getClientForCurrentAccount();
              if (newItem) {
                await apiClient.createFormItem(
                  form.id!,
                  'select',
                  0,
                  _labelController.text,
                  placeholder: _placeholderController.text,
                  isRequired: isRequired,
                  options: _optionsController.text.split('\n'),
                  helpText: _helpTextController.text,
                );
              } else {
                await apiClient.updateFormItem(
                    form.id!,
                    jinya.FormItem(
                      label: _labelController.text,
                      placeholder: _placeholderController.text,
                      isRequired: isRequired,
                      options: _optionsController.text.split('\n'),
                      helpText: _helpTextController.text,
                      position: item.position,
                    ));
              }
              NavigationService.instance.goBack();
            }
          },
          child: Text(l10n.editItemSave),
        ),
      ],
    );
  }
}

class _EditEmailItem extends StatefulWidget {
  final jinya.FormItem item;
  final bool newItem;
  final jinya.Form form;

  const _EditEmailItem(this.item, this.newItem, this.form, {super.key});

  @override
  State<StatefulWidget> createState() =>
      _EditEmailItemState(item, newItem, form);
}

class _EditEmailItemState extends State<_EditEmailItem> {
  final jinya.Form form;
  final jinya.FormItem item;
  final bool newItem;
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _placeholderController = TextEditingController();
  final _helpTextController = TextEditingController();
  final _spamFilterController = TextEditingController();
  bool isFromAddress = false;
  bool isRequired = false;

  @override
  void dispose() {
    _labelController.dispose();
    _placeholderController.dispose();
    _helpTextController.dispose();
    _spamFilterController.dispose();
    super.dispose();
  }

  _EditEmailItemState(this.item, this.newItem, this.form) {
    isFromAddress = item.isFromAddress ?? false;
    isRequired = item.isRequired ?? false;
    _labelController.text = item.label ?? '';
    _helpTextController.text = item.helpText ?? '';
    _placeholderController.text = item.placeholder ?? '';
    _spamFilterController.text = item.spamFilter?.join('\n') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.formItemTypeText),
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
                      return l10n.editFormItemLabelCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _labelController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemLabel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _placeholderController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemPlaceholder),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _helpTextController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemHelpText),
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: isFromAddress,
                    onChanged: (value) {
                      setState(() {
                        isFromAddress = value;
                      });
                    },
                  ),
                  Text(l10n.editFormItemIsFromAddress),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: isRequired,
                    onChanged: (value) {
                      setState(() {
                        isRequired = value;
                      });
                    },
                  ),
                  Text(l10n.editFormItemIsRequired),
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
          child: Text(l10n.editItemDiscard),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final apiClient = SettingsDatabase.getClientForCurrentAccount();
              if (newItem) {
                await apiClient.createFormItem(
                  form.id!,
                  'email',
                  0,
                  _labelController.text,
                  placeholder: _placeholderController.text,
                  isRequired: isRequired,
                  isFromAddress: isFromAddress,
                  helpText: _helpTextController.text,
                );
              } else {
                await apiClient.updateFormItem(
                    form.id!,
                    jinya.FormItem(
                      label: _labelController.text,
                      placeholder: _placeholderController.text,
                      isRequired: isRequired,
                      isFromAddress: isFromAddress,
                      helpText: _helpTextController.text,
                      position: item.position,
                    ));
              }
              NavigationService.instance.goBack();
            }
          },
          child: Text(l10n.editItemSave),
        ),
      ],
    );
  }
}

class _EditCheckboxItem extends StatefulWidget {
  final jinya.FormItem item;
  final bool newItem;
  final jinya.Form form;

  const _EditCheckboxItem(this.item, this.newItem, this.form, {super.key});

  @override
  State<StatefulWidget> createState() =>
      _EditCheckboxItemState(item, newItem, form);
}

class _EditCheckboxItemState extends State<_EditCheckboxItem> {
  final jinya.Form form;
  final jinya.FormItem item;
  final bool newItem;
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _placeholderController = TextEditingController();
  final _helpTextController = TextEditingController();
  bool isRequired = false;

  @override
  void dispose() {
    _labelController.dispose();
    _placeholderController.dispose();
    _helpTextController.dispose();
    super.dispose();
  }

  _EditCheckboxItemState(this.item, this.newItem, this.form) {
    isRequired = item.isRequired ?? false;
    _labelController.text = item.label ?? '';
    _helpTextController.text = item.helpText ?? '';
    _placeholderController.text = item.placeholder ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.formItemTypeText),
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
                      return l10n.editFormItemLabelCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _labelController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemLabel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _placeholderController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemPlaceholder),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _helpTextController,
                  maxLines: 1,
                  decoration:
                      InputDecoration(labelText: l10n.editFormItemHelpText),
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: isRequired,
                    onChanged: (value) {
                      setState(() {
                        isRequired = value;
                      });
                    },
                  ),
                  Text(l10n.editFormItemIsRequired),
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
          child: Text(l10n.editItemDiscard),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final apiClient = SettingsDatabase.getClientForCurrentAccount();
              if (newItem) {
                await apiClient.createFormItem(
                  form.id!,
                  'checkbox',
                  0,
                  _labelController.text,
                  placeholder: _placeholderController.text,
                  isRequired: isRequired,
                  helpText: _helpTextController.text,
                );
              } else {
                await apiClient.updateFormItem(
                    form.id!,
                    jinya.FormItem(
                      label: _labelController.text,
                      placeholder: _placeholderController.text,
                      isRequired: isRequired,
                      helpText: _helpTextController.text,
                      position: item.position,
                    ));
              }
              NavigationService.instance.goBack();
            }
          },
          child: Text(l10n.editItemSave),
        ),
      ],
    );
  }
}

class _FormDesigner extends StatefulWidget {
  final jinya.Form form;

  const _FormDesigner(this.form, {super.key});

  @override
  State<StatefulWidget> createState() => _FormDesignerState(form);
}

class _FormDesignerState extends State<_FormDesigner> {
  final jinya.Form form;
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  Iterable<jinya.FormItem> items = [];

  _FormDesignerState(this.form);

  loadItems() async {
    final items = await apiClient.getFormItems(form.id!);
    setState(() {
      this.items = items;
    });
  }

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  void resetPositions() {
    setState(() {
      for (var i = 0; i < items.length; i++) {
        items.elementAt(i).position = i;
      }
    });
  }

  Future<void> removeItem(jinya.FormItem item) async {
    await apiClient.deleteFormItem(form.id!, item.position!);
  }

  Widget getEntryByType(jinya.FormItem item) {
    final l10n = AppLocalizations.of(context)!;
    var subtitle = '';
    switch (item.type) {
      case 'text':
        subtitle = l10n.addFormItemText;
        break;
      case 'email':
        subtitle = l10n.addFormItemEmail;
        break;
      case 'textarea':
        subtitle = l10n.addFormItemMultiline;
        break;
      case 'select':
        subtitle = l10n.addFormItemDropdown;
        break;
      case 'checkbox':
        subtitle = l10n.addFormItemCheckbox;
        break;
    }

    return ListTile(
      title: Text(item.label!),
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          switch (item.type) {
            case 'text':
              final dialog = _EditTextItem(item, false, form);
              await showDialog(context: context, builder: (context) => dialog);
              await loadItems();
              break;
            case 'email':
              final dialog = _EditEmailItem(item, false, form);
              await showDialog(context: context, builder: (context) => dialog);
              await loadItems();
              break;
            case 'textarea':
              final dialog = _EditMultilineItem(item, false, form);
              await showDialog(context: context, builder: (context) => dialog);
              await loadItems();
              break;
            case 'select':
              final dialog = _EditDropdownItem(item, false, form);
              await showDialog(context: context, builder: (context) => dialog);
              await loadItems();
              break;
            case 'checkbox':
              final dialog = _EditCheckboxItem(item, false, form);
              await showDialog(context: context, builder: (context) => dialog);
              await loadItems();
              break;
          }
        },
        tooltip: l10n.editFormItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.formDesigner(form.title!)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.instance.goBack();
          },
        ),
        actions: [
          PopupMenuButton(
            tooltip: l10n.formDesignerAddItem,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: _FormItemType.text,
                  child: Text(l10n.addFormItemText),
                ),
                PopupMenuItem(
                  value: _FormItemType.email,
                  child: Text(l10n.addFormItemEmail),
                ),
                PopupMenuItem(
                  value: _FormItemType.multiline,
                  child: Text(l10n.addFormItemMultiline),
                ),
                PopupMenuItem(
                  value: _FormItemType.dropdown,
                  child: Text(l10n.addFormItemDropdown),
                ),
                PopupMenuItem(
                  value: _FormItemType.checkbox,
                  child: Text(l10n.addFormItemCheckbox),
                ),
              ];
            },
            onSelected: (value) async {
              switch (value) {
                case _FormItemType.text:
                  final dialog = _EditTextItem(jinya.FormItem(), true, form);
                  await showDialog(
                    context: context,
                    builder: (context) => dialog,
                  );
                  await loadItems();
                  break;
                case _FormItemType.multiline:
                  final dialog =
                      _EditMultilineItem(jinya.FormItem(), true, form);
                  await showDialog(
                    context: context,
                    builder: (context) => dialog,
                  );
                  await loadItems();
                  break;
                case _FormItemType.email:
                  final dialog = _EditEmailItem(jinya.FormItem(), true, form);
                  await showDialog(
                    context: context,
                    builder: (context) => dialog,
                  );
                  await loadItems();
                  break;
                case _FormItemType.dropdown:
                  final dialog =
                      _EditDropdownItem(jinya.FormItem(), true, form);
                  await showDialog(
                    context: context,
                    builder: (context) => dialog,
                  );
                  await loadItems();
                  break;
                case _FormItemType.checkbox:
                  final dialog =
                      _EditCheckboxItem(jinya.FormItem(), true, form);
                  await showDialog(
                    context: context,
                    builder: (context) => dialog,
                  );
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
          onReorder: (int oldIndex, int newIndex) {
            final pos = items.toList();
            final oldPos = pos.elementAt(oldIndex);
            if (oldIndex > newIndex) {
              pos.removeAt(oldIndex);
              pos.insert(newIndex, oldPos);
            } else {
              pos.insert(newIndex, oldPos);
              pos.removeAt(oldIndex);
            }
            setState(() {
              items = pos;
              resetPositions();
              apiClient.moveFormItem(form.id!, oldIndex, newIndex);
            });
          },
          children: items
              .map(
                (item) => Dismissible(
                  key: Key(item.id.toString()),
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
                    final filtered =
                        items.where((element) => element.id != item.id);
                    setState(() {
                      items = filtered;
                      resetPositions();
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

class Forms extends StatefulWidget {
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
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => _EditFormDialog(form),
                );
                await loadForms();
              },
              icon: const Icon(Icons.edit),
              tooltip: l10n.editFormTitle,
            ),
            IconButton(
              onPressed: () async {
                await NavigationService.instance.navigateTo(MaterialPageRoute(
                  builder: (context) => _FormDesigner(form),
                ));
                await loadForms();
              },
              icon: const Icon(Icons.reorder),
              tooltip: l10n.formDesigner(form.title!),
            ),
            IconButton(
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
                              content: Text(
                                  l10n.failedToDeleteFormConflict(form.title!)),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  l10n.failedToDeleteFormGeneric(form.title!)),
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
              tooltip: l10n.deleteForm,
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
                        ? MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height)
                        : MediaQuery.of(context).size.height /
                            (MediaQuery.of(context).size.width),
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
      floatingActionButton:
          SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
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
                  tooltip: l10n.addFormTitle,
                )
              : null,
    );
  }
}
