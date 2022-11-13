import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:notustohtml/notustohtml.dart';

class _EditGallerySegment extends StatefulWidget {
  const _EditGallerySegment(this.segment, this.page, this.galleries, this.newSegment, {super.key});

  final jinya.Segment segment;
  final jinya.SegmentPage page;
  final Iterable<jinya.Gallery> galleries;
  final bool newSegment;

  @override
  State<StatefulWidget> createState() => _EditGallerySegmentState(segment, page, galleries, newSegment);
}

class _EditGallerySegmentState extends State<_EditGallerySegment> {
  _EditGallerySegmentState(jinya.Segment segment, this.page, Iterable<jinya.Gallery> galleries, this.newSegment) {
    selectedGalleryId = segment.gallery?.id ?? galleries.first.id;
    this.galleries = galleries;
    this.segment = segment;
  }

  late final jinya.Segment segment;
  final jinya.SegmentPage page;
  late final Iterable<jinya.Gallery> galleries;
  final bool newSegment;
  int? selectedGalleryId;

  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.segmentTypeGallery),
      content: Scrollbar(
        child: DropdownButton(
          items: galleries
              .map((gal) => DropdownMenuItem(
                    value: gal.id,
                    child: Text(gal.name!),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedGalleryId = value;
            });
          },
          value: selectedGalleryId,
          // value: gallery,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.editSegmentDiscard),
        ),
        TextButton(
          onPressed: () async {
            segment.gallery = galleries.singleWhere((element) => element.id == selectedGalleryId);

            if (newSegment) {
              await apiClient.createSegment(page.id!, jinya.SegmentType.gallery, segment);
            } else {
              await apiClient.updateSegment(page.id!, segment.position!, segment);
            }

            NavigationService.instance.goBack();
          },
          child: Text(l10n.editSegmentSave),
        ),
      ],
    );
  }
}

class _EditFileSegment extends StatefulWidget {
  const _EditFileSegment(this.segment, this.page, this.files, this.newSegment, {super.key});

  final jinya.Segment segment;
  final jinya.SegmentPage page;
  final Iterable<jinya.File> files;
  final bool newSegment;

  @override
  State<StatefulWidget> createState() => _EditFileSegmentState(segment, page, files, newSegment);
}

class _EditFileSegmentState extends State<_EditFileSegment> {
  _EditFileSegmentState(jinya.Segment segment, this.page, Iterable<jinya.File> files, this.newSegment) {
    selectedFileId = segment.file?.id ?? files.first.id;
    hasLink = segment.action == 'link';
    linkController = TextEditingController(text: segment.target ?? '');
    this.segment = segment;
    this.files = files;
  }

  late final jinya.Segment segment;
  final jinya.SegmentPage page;
  late final Iterable<jinya.File> files;
  final bool newSegment;
  int? selectedFileId;
  bool hasLink = false;

  late final linkController;

  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = <Widget>[
      DropdownButton(
        items: files
            .map((gal) => DropdownMenuItem(
                  value: gal.id,
                  child: Text(gal.name!),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedFileId = value;
          });
        },
        value: selectedFileId,
        // value: file,
      ),
      Row(
        children: [
          Switch(
            value: hasLink,
            onChanged: (value) {
              setState(() {
                hasLink = value;
              });
            },
          ),
          Text(l10n.editSegmentFileHasLink),
        ],
      ),
    ];
    if (hasLink) {
      items.add(
        TextFormField(
          decoration: InputDecoration(labelText: l10n.editSegmentFileLink),
          controller: linkController,
        ),
      );
    }

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.segmentTypeFile),
      content: Column(
        children: items,
      ),
      actions: [
        TextButton(
          onPressed: () {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.editSegmentDiscard),
        ),
        TextButton(
          onPressed: () async {
            segment.file = files.singleWhere((element) => element.id == selectedFileId);
            if (hasLink) {
              segment.target = linkController.text;
              segment.action = 'link';
            } else {
              segment.target = null;
              segment.action = 'none';
            }

            if (newSegment) {
              await apiClient.createSegment(page.id!, jinya.SegmentType.file, segment);
            } else {
              await apiClient.updateSegment(page.id!, segment.position!, segment);
            }

            NavigationService.instance.goBack();
          },
          child: Text(l10n.editSegmentSave),
        ),
      ],
    );
  }
}

class SegmentPageDesigner extends StatefulWidget {
  const SegmentPageDesigner(this.page, {super.key});

  final jinya.SegmentPage page;

  @override
  _SegmentPageDesignerState createState() => _SegmentPageDesignerState(page);
}

class _SegmentPageDesignerState extends State<SegmentPageDesigner> {
  final jinya.SegmentPage page;
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  Iterable<jinya.Segment> segments = [];
  Iterable<jinya.File> files = [];
  Iterable<jinya.Gallery> galleries = [];
  final converter = const NotusHtmlCodec();
  jinya.Gallery? gallery;
  int? selectedGalleryId;

  _SegmentPageDesignerState(this.page);

  Future<void> displayHtmlSegmentEditor(jinya.Segment segment, bool newSegment) async {
    final l10n = AppLocalizations.of(context)!;
    final delta = converter.decode(segment.html ?? '');
    final document = ParchmentDocument.fromDelta(delta);
    final htmlController = FleatherController(document);

    final dialog = AlertDialog(
      title: Text(l10n.segmentTypeHtml),
      content: Scrollbar(
        child: Column(
          children: [
            FleatherToolbar.basic(controller: htmlController),
            Expanded(
              child: FleatherEditor(controller: htmlController),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.editSegmentDiscard),
        ),
        TextButton(
          onPressed: () async {
            final html = converter.encode(htmlController.document.toDelta());
            segment.html = html;

            if (newSegment) {
              await apiClient.createSegment(page.id!, jinya.SegmentType.html, segment);
            } else {
              await apiClient.updateSegment(page.id!, segment.position!, segment);
            }

            await loadSegments();
            NavigationService.instance.goBack();
          },
          child: Text(l10n.editSegmentSave),
        ),
      ],
    );
    await showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  Future<void> displayGallerySegmentEditor(jinya.Segment segment, bool newSegment) async {
    await showDialog(
      context: context,
      builder: (context) => _EditGallerySegment(segment, page, galleries, newSegment),
    );
    await loadSegments();
  }

  Future<void> displayFileSegmentEditor(jinya.Segment segment, bool newSegment) async {
    await showDialog(
      context: context,
      builder: (context) => _EditFileSegment(segment, page, files, newSegment),
    );
    await loadSegments();
  }

  loadSegments() async {
    final segments = await apiClient.getSegmentsByPage(page.id!);
    setState(() {
      this.segments = segments;
    });
  }

  loadFiles() async {
    final files = await apiClient.getFiles();
    setState(() {
      this.files = files;
    });
  }

  loadGalleries() async {
    final galleries = await apiClient.getGalleries();
    setState(() {
      this.galleries = galleries;
    });
  }

  @override
  void initState() {
    super.initState();
    loadSegments();
    loadFiles();
    loadGalleries();
  }

  Widget getEntryByType(jinya.Segment segment) {
    final l10n = AppLocalizations.of(context)!;

    if (segment.file != null) {
      return ListTile(
        key: Key('tile${segment.id}'),
        title: Text(l10n.segmentTypeFile),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(segment.file!.name!),
            segment.target != null && segment.target!.isNotEmpty
                ? Text(segment.target!)
                : Text(l10n.segmentTypeFileNoLink),
          ],
        ),
        isThreeLine: true,
        leading: CachedNetworkImage(
          imageUrl: '${SettingsDatabase.selectedAccount!.url}/${segment.file!.path!}',
          width: 80,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        trailing: IconButton(
          onPressed: () {
            displayFileSegmentEditor(segment, false);
          },
          icon: const Icon(Icons.edit),
        ),
      );
    } else if (segment.gallery != null) {
      return ListTile(
        key: Key('tile${segment.id}'),
        title: Text(l10n.segmentTypeGallery),
        subtitle: Text(segment.gallery!.name!),
        trailing: IconButton(
          onPressed: () {
            displayGallerySegmentEditor(segment, false);
          },
          icon: const Icon(Icons.edit),
        ),
      );
    } else {
      return Column(
        key: Key('tile${segment.id}'),
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(l10n.segmentTypeHtml),
            trailing: IconButton(
              onPressed: () {
                displayHtmlSegmentEditor(segment, false);
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: HtmlWidget(segment.html!),
          ),
        ],
      );
    }
  }

  void resetPositions() {
    setState(() {
      for (var i = 0; i < segments.length; i++) {
        segments.elementAt(i).position = i;
      }
    });
  }

  Future<void> removeSegment(jinya.Segment segment) async {
    await apiClient.deleteSegment(page.id!, segment.position!);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.segmentPageDesigner(page.name!)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.instance.goBack();
          },
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'file',
                  child: Text(l10n.addSegmentTypeFile),
                ),
                PopupMenuItem(
                  value: 'gallery',
                  child: Text(l10n.addSegmentTypeGallery),
                ),
                PopupMenuItem(
                  value: 'html',
                  child: Text(l10n.addSegmentTypeHtml),
                ),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 'file':
                  displayFileSegmentEditor(jinya.Segment(position: 0, file: null), true);
                  break;
                case 'gallery':
                  displayGallerySegmentEditor(jinya.Segment(position: 0, gallery: null), true);
                  break;
                case 'html':
                  displayHtmlSegmentEditor(jinya.Segment(position: 0, html: '<p></p>'), true);
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
            final pos = segments.toList();
            final oldPos = pos.elementAt(oldIndex);
            if (oldIndex > newIndex) {
              pos.removeAt(oldIndex);
              pos.insert(newIndex, oldPos);
            } else {
              pos.insert(newIndex, oldPos);
              pos.removeAt(oldIndex);
            }
            setState(() {
              segments = pos;
              resetPositions();
              apiClient.moveSegment(page.id!, oldIndex, newIndex);
            });
          },
          children: segments
              .map(
                (segment) => Dismissible(
                  key: Key(segment.id.toString()),
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
                    removeSegment(segment);
                    final filtered = segments.where((element) => element.id != segment.id);
                    setState(() {
                      segments = filtered;
                      resetPositions();
                    });
                  },
                  direction: DismissDirection.endToStart,
                  child: getEntryByType(segment),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
