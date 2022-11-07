import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;

class EditGalleryDialog extends StatefulWidget {
  jinya.Gallery gallery;

  EditGalleryDialog(this.gallery, {super.key});

  @override
  _EditGalleryDialogState createState() => _EditGalleryDialogState(gallery);
}

class _EditGalleryDialogState extends State<EditGalleryDialog> {
  jinya.Gallery gallery;

  _EditGalleryDialogState(this.gallery) {
    _nameController.text = gallery.name!;
    _descriptionController.text = gallery.description!;
  }

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  var _orientation = jinya.Orientation.vertical;
  var _type = jinya.Type.sequence;

  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    return AlertDialog(
      scrollable: true,
      title: Text(l10n!.createGalleryTitle),
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
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
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(labelText: l10n.galleryDescription),
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: l10n.galleryOrientation),
                value: gallery.orientation,
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
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: l10n.galleryType),
                value: gallery.type,
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
                await apiClient.updateGallery(jinya.Gallery(
                  name: _nameController.text,
                  description: _descriptionController.text,
                  orientation: _orientation,
                  type: _type,
                  id: gallery.id,
                ));
                NavigationService.instance.goBack();
              } on jinya.ConflictException {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.galleryEditConflict),
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
                  content: Text(l10n.galleryEditGeneric),
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
