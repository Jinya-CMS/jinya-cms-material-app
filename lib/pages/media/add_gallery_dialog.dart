import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;

class AddGalleryDialog extends StatefulWidget {
  const AddGalleryDialog({super.key});

  @override
  _AddGalleryDialogState createState() => _AddGalleryDialogState();
}

class _AddGalleryDialogState extends State<AddGalleryDialog> {
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
