import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:notustohtml/notustohtml.dart';

class EditSimplePage extends StatefulWidget {
  EditSimplePage(this.page, {super.key, required this.onSave});

  Function onSave;
  final jinya.SimplePage page;

  @override
  _EditSimplePageState createState() => _EditSimplePageState(page, onSave);
}

class _EditSimplePageState extends State<EditSimplePage> {
  _EditSimplePageState(this.page, this.onSave) {
    _titleController.text = page.title!;
    try {
      final delta = converter.decode(page.content!);
      final document = ParchmentDocument.fromDelta(delta);
      _contentController = FleatherController(document);
    } catch (ex) {
      hideEditor = true;
    }
  }

  Function onSave;
  bool hideEditor = false;
  final converter = const NotusHtmlCodec();
  final jinya.SimplePage page;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  FleatherController _contentController = FleatherController();

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
                  onSave();
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
