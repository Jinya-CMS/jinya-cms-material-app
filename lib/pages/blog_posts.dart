import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:notustohtml/notustohtml.dart';
import 'package:slugify/slugify.dart';
import 'package:uuid/uuid.dart';

class _AddBlogPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBlogPostState();
}

class _AddBlogPostState extends State<_AddBlogPost> {
  final _formKey = GlobalKey<FormState>();
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  final _titleController = TextEditingController();
  final _slugController = TextEditingController();
  int? _headerImageId;
  int? _categoryId;
  bool manualSlugChange = false;
  bool _public = true;

  Iterable<jinya.BlogCategory> categories = [];
  Iterable<jinya.File?> files = [];

  @override
  void dispose() {
    _titleController.dispose();
    _slugController.dispose();
    super.dispose();
  }

  Future<void> loadCategories() async {
    final cats = await apiClient.getBlogCategories();
    setState(() {
      categories = cats;
      _categoryId = categories.first.id!;
    });
  }

  Future<void> loadFiles() async {
    final files = await apiClient.getFiles();
    setState(() {
      this.files = [null, ...files];
    });
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
    loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.addBlogPost),
      scrollable: true,
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.addPostTitleCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _titleController,
                  decoration: InputDecoration(label: Text(l10n.postTitle)),
                  onChanged: (value) {
                    if (!manualSlugChange) {
                      _slugController.text = slugify(value);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.addPostSlugCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _slugController,
                  decoration: InputDecoration(label: Text(l10n.postSlug)),
                  onChanged: (value) {
                    manualSlugChange = true;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField(
                  onChanged: (value) {
                    _headerImageId = value;
                  },
                  items: files.map((file) {
                    if (file == null) {
                      return DropdownMenuItem(
                        value: null,
                        child: Text(l10n.postNoHeaderImage),
                      );
                    }

                    return DropdownMenuItem(
                      value: file.id,
                      child: Text(file.name!),
                    );
                  }).toList(),
                  decoration: InputDecoration(label: Text(l10n.postImage)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField(
                  value: _categoryId,
                  onChanged: (value) {
                    _categoryId = value!;
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category.id!,
                      child: Text(category.name!),
                    );
                  }).toList(),
                  decoration: InputDecoration(label: Text(l10n.postCategory)),
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: _public,
                    onChanged: (value) {
                      setState(() {
                        _public = value;
                      });
                    },
                  ),
                  Text(l10n.postPublic),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.discardPost),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                await apiClient.createBlogPost(
                  _titleController.text,
                  _slugController.text,
                  _headerImageId,
                  _categoryId!,
                  _public,
                );

                NavigationService.instance.goBack();
              } on jinya.ConflictException {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.postAddConflict),
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
                  content: Text(l10n.postAddGeneric),
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
          child: Text(l10n.savePost),
        ),
      ],
    );
  }
}

class _EditBlogPost extends StatefulWidget {
  final jinya.BlogPost post;

  const _EditBlogPost(this.post);

  @override
  State<StatefulWidget> createState() => _EditBlogPostState(post);
}

class _EditBlogPostState extends State<_EditBlogPost> {
  final jinya.BlogPost post;
  final _formKey = GlobalKey<FormState>();
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  final _titleController = TextEditingController();
  final _slugController = TextEditingController();
  int? _headerImageId;
  int? _categoryId;
  bool _public = true;

  Iterable<jinya.BlogCategory> categories = [];
  Iterable<jinya.File?> files = [];

  @override
  void dispose() {
    _titleController.dispose();
    _slugController.dispose();
    super.dispose();
  }

  _EditBlogPostState(this.post) {
    _titleController.text = post.title!;
    _slugController.text = post.slug!;
    _headerImageId = post.headerImage?.id;
    _categoryId = post.category?.id;
    _public = post.public ?? false;
  }

  Future<void> loadCategories() async {
    final cats = await apiClient.getBlogCategories();
    setState(() {
      categories = cats;
      _categoryId = categories.first.id!;
    });
  }

  Future<void> loadFiles() async {
    final files = await apiClient.getFiles();
    setState(() {
      this.files = [null, ...files];
    });
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
    loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.editBlogPost),
      scrollable: true,
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.editPostTitleCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _titleController,
                  decoration: InputDecoration(label: Text(l10n.postTitle)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.editPostSlugCannotBeEmpty;
                    }

                    return null;
                  },
                  controller: _slugController,
                  decoration: InputDecoration(label: Text(l10n.postSlug)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField(
                  value: _headerImageId,
                  onChanged: (value) {
                    _headerImageId = value;
                  },
                  items: files.map((file) {
                    if (file == null) {
                      return DropdownMenuItem(
                        value: null,
                        child: Text(l10n.postNoHeaderImage),
                      );
                    }

                    return DropdownMenuItem(
                      value: file.id,
                      child: Text(file.name!),
                    );
                  }).toList(),
                  decoration: InputDecoration(label: Text(l10n.postImage)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DropdownButtonFormField(
                  value: _categoryId,
                  onChanged: (value) {
                    _categoryId = value!;
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category.id!,
                      child: Text(category.name!),
                    );
                  }).toList(),
                  decoration: InputDecoration(label: Text(l10n.postCategory)),
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: _public,
                    onChanged: (value) {
                      setState(() {
                        _public = value;
                      });
                    },
                  ),
                  Text(l10n.postPublic),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            NavigationService.instance.goBack();
          },
          child: Text(l10n.discardPost),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                await apiClient.updateBlogPost(
                  jinya.BlogPost(
                    title: _titleController.text,
                    slug: _slugController.text,
                    headerImage: files
                        .firstWhere((element) => element?.id == _headerImageId),
                    category: categories
                        .firstWhere((element) => element.id == _categoryId!),
                    id: post.id,
                    public: _public,
                  ),
                );

                NavigationService.instance.goBack();
              } on jinya.ConflictException {
                final dialog = AlertDialog(
                  title: Text(l10n.saveFailed),
                  content: Text(l10n.categoryAddConflict),
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
                  content: Text(l10n.categoryAddGeneric),
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
          child: Text(l10n.savePost),
        ),
      ],
    );
  }
}

class _EditGallerySegment extends StatefulWidget {
  const _EditGallerySegment(
      this.segment, this.post, this.galleries, this.newSegment);

  final jinya.BlogPostSegment segment;
  final jinya.BlogPost post;
  final Iterable<jinya.Gallery> galleries;
  final bool newSegment;

  @override
  State<StatefulWidget> createState() =>
      _EditGallerySegmentState(segment, post, galleries, newSegment);
}

class _EditGallerySegmentState extends State<_EditGallerySegment> {
  _EditGallerySegmentState(jinya.BlogPostSegment segment, this.post,
      Iterable<jinya.Gallery> galleries, this.newSegment) {
    selectedGalleryId = segment.gallery?.id ?? galleries.first.id;
    this.galleries = galleries;
    this.segment = segment;
  }

  late final jinya.BlogPostSegment segment;
  final jinya.BlogPost post;
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
            segment.gallery = galleries
                .singleWhere((element) => element.id == selectedGalleryId);

            NavigationService.instance.goBack(result: segment);
          },
          child: Text(l10n.editSegmentSave),
        ),
      ],
    );
  }
}

class _EditFileSegment extends StatefulWidget {
  const _EditFileSegment(this.segment, this.post, this.files, this.newSegment);

  final jinya.BlogPostSegment segment;
  final jinya.BlogPost post;
  final Iterable<jinya.File> files;
  final bool newSegment;

  @override
  State<StatefulWidget> createState() =>
      _EditFileSegmentState(segment, post, files, newSegment);
}

class _EditFileSegmentState extends State<_EditFileSegment> {
  _EditFileSegmentState(jinya.BlogPostSegment segment, this.post,
      Iterable<jinya.File> files, this.newSegment) {
    selectedFileId = segment.file?.id ?? files.first.id;
    hasLink = segment.link != '' && segment.link != null;
    linkController = TextEditingController(text: segment.link ?? '');
    this.segment = segment;
    this.files = files;
  }

  @override
  void dispose() {
    linkController.dispose();
    super.dispose();
  }

  late final jinya.BlogPostSegment segment;
  final jinya.BlogPost post;
  late final Iterable<jinya.File> files;
  final bool newSegment;
  int? selectedFileId;
  bool hasLink = false;

  late final TextEditingController linkController;

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
            segment.file =
                files.singleWhere((element) => element.id == selectedFileId);
            if (hasLink) {
              segment.link = linkController.text;
            } else {
              segment.link = null;
            }

            NavigationService.instance.goBack(result: segment);
          },
          child: Text(l10n.editSegmentSave),
        ),
      ],
    );
  }
}

enum _SegmentType {
  file,
  gallery,
  html,
}

class _BlogPostDesigner extends StatefulWidget {
  const _BlogPostDesigner(this.post);

  final jinya.BlogPost post;

  @override
  _BlogPostDesignerState createState() => _BlogPostDesignerState(post);
}

class _BlogPostDesignerState extends State<_BlogPostDesigner> {
  final jinya.BlogPost post;
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  Iterable<jinya.BlogPostSegment> segments = [];
  Iterable<jinya.File> files = [];
  Iterable<jinya.Gallery> galleries = [];
  final converter = const NotusHtmlCodec();
  jinya.Gallery? gallery;
  int? selectedGalleryId;

  _BlogPostDesignerState(this.post);

  Future<void> displayHtmlSegmentEditor(
      jinya.BlogPostSegment segment, bool newSegment) async {
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

            NavigationService.instance.goBack(result: segment);
          },
          child: Text(l10n.editSegmentSave),
        ),
      ],
    );
    final updatedSegment = await showDialog(
      context: context,
      builder: (context) => dialog,
    );
    setState(() {
      if (newSegment) {
        updatedSegment.position = segments.length;
        segments = [...segments, updatedSegment];
        resetPositions();
      } else {
        segments.singleWhere((element) => element.id == segment.id).html =
            updatedSegment.html;
      }
    });
  }

  Future<void> displayGallerySegmentEditor(
      jinya.BlogPostSegment segment, bool newSegment) async {
    final updatedSegment = await showDialog(
      context: context,
      builder: (context) =>
          _EditGallerySegment(segment, post, galleries, newSegment),
    );
    setState(() {
      if (newSegment) {
        updatedSegment.position = segments.length;
        segments = [...segments, updatedSegment];
        resetPositions();
      } else {
        segments.singleWhere((element) => element.id == segment.id).gallery =
            updatedSegment.gallery;
      }
    });
  }

  Future<void> displayFileSegmentEditor(
      jinya.BlogPostSegment segment, bool newSegment) async {
    final updatedSegment = await showDialog(
      context: context,
      builder: (context) => _EditFileSegment(segment, post, files, newSegment),
    );
    setState(() {
      if (newSegment) {
        updatedSegment.position = segments.length;
        segments = [...segments, updatedSegment];
        resetPositions();
      } else {
        final foundSegment =
            segments.singleWhere((element) => element.id == segment.id);
        foundSegment.link = updatedSegment.link;
        foundSegment.file = updatedSegment.file;
      }
    });
  }

  loadSegments() async {
    final segments = await apiClient.getBlogPostSegments(post.id!);
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

  Widget getEntryByType(jinya.BlogPostSegment segment) {
    final l10n = AppLocalizations.of(context)!;

    if (segment.file != null) {
      return ListTile(
        title: Text(l10n.segmentTypeFile),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(segment.file!.name!),
            segment.link != null && segment.link!.isNotEmpty
                ? Text(segment.link!)
                : Text(l10n.segmentTypeFileNoLink),
          ],
        ),
        isThreeLine: true,
        leading: CachedNetworkImage(
          imageUrl:
              '${SettingsDatabase.selectedAccount!.url}/${segment.file!.path!}',
          width: 80,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        trailing: IconButton(
          onPressed: () {
            displayFileSegmentEditor(segment, false);
          },
          icon: const Icon(Icons.edit),
          tooltip: l10n.editBlogPostSegment,
        ),
      );
    } else if (segment.gallery != null) {
      return ListTile(
        title: Text(l10n.segmentTypeGallery),
        subtitle: Text(segment.gallery!.name!),
        trailing: IconButton(
          onPressed: () {
            displayGallerySegmentEditor(segment, false);
          },
          icon: const Icon(Icons.edit),
          tooltip: l10n.editBlogPostSegment,
        ),
      );
    } else {
      return Column(
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
              tooltip: l10n.editBlogPostSegment,
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.blogPostDesigner(post.title!)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.instance.goBack();
          },
          tooltip: l10n.addBlogPostSegment,
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: _SegmentType.file,
                  child: Text(l10n.addSegmentTypeFile),
                ),
                PopupMenuItem(
                  value: _SegmentType.gallery,
                  child: Text(l10n.addSegmentTypeGallery),
                ),
                PopupMenuItem(
                  value: _SegmentType.html,
                  child: Text(l10n.addSegmentTypeHtml),
                ),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case _SegmentType.file:
                  displayFileSegmentEditor(
                      jinya.BlogPostSegment(position: 0, file: null), true);
                  break;
                case _SegmentType.gallery:
                  displayGallerySegmentEditor(
                      jinya.BlogPostSegment(position: 0, gallery: null), true);
                  break;
                case _SegmentType.html:
                  displayHtmlSegmentEditor(
                      jinya.BlogPostSegment(position: 0, html: '<p></p>'),
                      true);
                  break;
              }
            },
            icon: const Icon(Icons.add),
          ),
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
            });
          },
          children: segments
              .map(
                (segment) => Dismissible(
                  key: Key(const Uuid().v4()),
                  background: Container(
                    color: Theme.of(context).colorScheme.error,
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
                    final filtered = segments.where(
                        (element) => element.position != segment.position);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await apiClient.batchReplaceBlogPostSegments(post.id!, segments);
            messenger.clearSnackBars();
            messenger.showSnackBar(SnackBar(
              content: Text(l10n.postSegmentsSaved),
              behavior: SnackBarBehavior.floating,
            ));
          } catch (ex) {
            messenger.clearSnackBars();
            messenger.showSnackBar(SnackBar(
              content: Text(l10n.postSegmentsError),
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

class ListBlogPosts extends StatefulWidget {
  const ListBlogPosts({super.key});

  @override
  _ListBlogPostsState createState() => _ListBlogPostsState();
}

class _ListBlogPostsState extends State<ListBlogPosts> {
  Iterable<jinya.BlogPost> posts = <jinya.BlogPost>[];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Future<void> loadPosts() async {
    final posts = await apiClient.getBlogPosts();
    setState(() {
      this.posts = posts;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  Widget itemBuilder(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    final post = posts.elementAt(index);
    final children = <Widget>[
      ListTile(
        title: Text(post.title!),
        subtitle: Text(post.category!.name!),
      ),
    ];
    if (post.headerImage != null) {
      children.add(
        CachedNetworkImage(
          imageUrl: SettingsDatabase.selectedAccount!.url +
              (post.headerImage?.path ?? ''),
          fit: BoxFit.cover,
          height: 240,
          width: double.infinity,
          progressIndicatorBuilder: (context, url, progress) => Container(
            height: 48,
            width: 48,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
      children.add(
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                final dialog = _EditBlogPost(post);
                await showDialog(
                    context: context, builder: (context) => dialog);
                await loadPosts();
              },
              icon: const Icon(Icons.edit),
              tooltip: l10n.editBlogPost,
            ),
            IconButton(
              onPressed: () async {
                await NavigationService.instance.navigateTo(MaterialPageRoute(
                  builder: (context) => _BlogPostDesigner(post),
                ));
                await loadPosts();
              },
              icon: const Icon(Icons.reorder),
              tooltip: l10n.blogPostDesigner(post.title!),
            ),
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.deleteBlogPostTitle),
                    content: Text(l10n.deleteBlogPostMessage(post.title!)),
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
                            await apiClient.deleteBlogPost(post.id!);
                            NavigationService.instance.goBack();
                            await loadPosts();
                          } on jinya.ConflictException {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  l10n.failedToDeletePostConflict(post.title!)),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  l10n.failedToDeletePostGeneric(post.title!)),
                            ));
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: Text(l10n.delete),
                      ),
                    ],
                  ),
                );
              },
              tooltip: l10n.deleteBlogPost,
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
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
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadPosts();
          },
          child: query.size.width >= 720
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: query.size.width >= 1080 ? 4 : 2,
                    childAspectRatio:
                        query.size.width >= 1080 ? 9 / 12 : 9 / 10,
                  ),
                  itemCount: posts.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                )
              : ListView.builder(
                  itemCount: posts.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                ),
        ),
      ),
      floatingActionButton:
          SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
              ? FloatingActionButton(
                  tooltip: l10n.addBlogPost,
                  onPressed: () async {
                    final dialog = _AddBlogPost();
                    await showDialog(
                        context: context, builder: (context) => dialog);
                    await loadPosts();
                  },
                  child: const Icon(Icons.add),
                )
              : null,
    );
  }
}
