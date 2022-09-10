import 'package:flutter/material.dart';
import 'package:jinya_cms_android_app/l10n/localizations.dart';
import 'package:jinya_cms_android_app/network/errors/ConflictException.dart';
import 'package:jinya_cms_android_app/shared/navigator_service.dart';
import 'package:jinya_cms_android_app/network/media/galleries.dart' as media;

class AddGalleryDialog extends StatefulWidget {
  const AddGalleryDialog({super.key});

  @override
  _AddGalleryDialogState createState() => _AddGalleryDialogState();
}

class _AddGalleryDialogState extends State<AddGalleryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  var _orientation = media.Orientation.vertical;
  var _type = media.Type.sequence;

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
                value: media.Orientation.vertical,
                items: [
                  DropdownMenuItem(
                    value: media.Orientation.vertical,
                    child: Text(l10n.galleryOrientationVertical),
                  ),
                  DropdownMenuItem(
                    value: media.Orientation.horizontal,
                    child: Text(l10n.galleryOrientationHorizontal),
                  ),
                ],
                onChanged: (media.Orientation? value) {
                  _orientation = value!;
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: l10n.galleryType),
                value: media.Type.sequence,
                items: [
                  DropdownMenuItem(
                    value: media.Type.masonry,
                    child: Text(l10n.galleryTypeGrid),
                  ),
                  DropdownMenuItem(
                    value: media.Type.sequence,
                    child: Text(l10n.galleryTypeList),
                  ),
                ],
                onChanged: (media.Type? value) {
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
                await media.createGallery(
                  _nameController.text,
                  description: _descriptionController.text,
                  orientation: _orientation,
                  type: _type,
                );
                NavigationService.instance.goBack();
              } on ConflictException {
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
