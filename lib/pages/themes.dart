import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Themes extends StatefulWidget {
  const Themes({super.key});

  @override
  State<Themes> createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
  Iterable<jinya.Theme> themes = [];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Future<void> loadThemes() async {
    final themes = await apiClient.getThemes();
    setState(() {
      this.themes = themes;
    });
  }

  @override
  void initState() {
    super.initState();
    loadThemes();
  }

  Widget itemBuilder(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final messenger = ScaffoldMessenger.of(context);

    final item = themes.elementAt(index);
    var description = '';
    if (item.description!.containsKey(locale)) {
      description = item.description![locale] ?? '';
    } else if (item.description!.containsKey('en')) {
      description = item.description!['en']!;
    } else {
      description = item.description![item.description!.keys.first]!;
    }

    final children = [
      ListTile(
        title: Text(item.displayName!),
        subtitle: Text(description),
        isThreeLine: true,
      ),
      CachedNetworkImage(
        imageUrl:
            '${SettingsDatabase.selectedAccount!.url}/api/theme/${item.id}/preview',
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
    ];

    if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
      children.add(
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                final dialog = AlertDialog(
                  content: Text(l10n.activateThemeContent(item.displayName!)),
                  title: Text(l10n.activateThemeTitle),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l10n.activateThemeCancel),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          await apiClient.activateTheme(item.id!);
                          messenger.showSnackBar(SnackBar(
                            content: Text(l10n.activateThemeSuccess),
                            behavior: SnackBarBehavior.floating,
                          ));
                          NavigationService.instance.goBack();
                        } catch (ex) {
                          messenger.showSnackBar(SnackBar(
                            content: Text(l10n.activateThemeFailure),
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      },
                      child: Text(l10n.activateThemeActivate),
                    ),
                  ],
                );
                await showDialog(
                    context: context, builder: (context) => dialog);
                await loadThemes();
              },
              icon: const Icon(MdiIcons.check),
              tooltip: l10n.themeActivate,
            ),
            IconButton(
              onPressed: () async {
                final dialog = AlertDialog(
                  content: Text(l10n.compileThemeContent(item.displayName!)),
                  title: Text(l10n.compileThemeTitle),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l10n.compileThemeCancel),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          await apiClient.compileTheme(item.id!);
                          messenger.showSnackBar(SnackBar(
                            content: Text(l10n.compileThemeSuccess),
                            behavior: SnackBarBehavior.floating,
                          ));
                          NavigationService.instance.goBack();
                        } catch (ex) {
                          messenger.showSnackBar(SnackBar(
                            content: Text(l10n.compileThemeFailure),
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      },
                      child: Text(l10n.compileThemeActivate),
                    ),
                  ],
                );
                await showDialog(
                    context: context, builder: (context) => dialog);
                await loadThemes();
              },
              icon: const Icon(MdiIcons.shape),
              tooltip: l10n.themeAssets,
            ),
            IconButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      _ThemeDetailsPage(_ThemeDetailsPage.tabSettings, item),
                ));
                await loadThemes();
              },
              icon: const Icon(MdiIcons.cog),
              tooltip: l10n.themeSettings,
            ),
            IconButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      _ThemeDetailsPage(_ThemeDetailsPage.tabLinks, item),
                ));
                await loadThemes();
              },
              icon: const Icon(MdiIcons.linkVariant),
              tooltip: l10n.themeLinks,
            ),
            IconButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      _ThemeDetailsPage(_ThemeDetailsPage.tabVariables, item),
                ));
                await loadThemes();
              },
              icon: const Icon(MdiIcons.sass),
              tooltip: l10n.themeVariables,
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.menuTheme),
      ),
      drawer: const JinyaNavigationDrawer(),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadThemes();
          },
          child: query.size.width >= 720
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: query.size.width >= 1080 ? 4 : 2,
                    childAspectRatio: query.size.width >= 1080 ? 9 / 12 : 9 / 9,
                  ),
                  itemCount: themes.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                )
              : ListView.builder(
                  itemCount: themes.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                ),
        ),
      ),
    );
  }
}

class _ThemeDetailsPage extends StatefulWidget {
  static const tabSettings = 0;
  static const tabLinks = 1;
  static const tabVariables = 2;

  final int initialIndex;
  final jinya.Theme theme;

  const _ThemeDetailsPage(this.initialIndex, this.theme, {super.key});

  @override
  State<_ThemeDetailsPage> createState() =>
      _ThemeDetailsPageState(initialIndex, theme);
}

class _ThemeDetailsPageState extends State<_ThemeDetailsPage> {
  final int initialIndex;
  final jinya.Theme theme;

  _ThemeDetailsPageState(this.initialIndex, this.theme);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text(theme.displayName!),
          bottom: TabBar(
            tabs: [
              Tab(
                text: l10n.menuThemeSettings,
              ),
              Tab(
                text: l10n.menuThemeLinks,
              ),
              Tab(
                text: l10n.menuThemeVariables,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ThemeSettingsPage(theme),
            _ThemeLinksPage(theme),
            _ThemeVariablesPage(theme)
          ],
        ),
      ),
    );
  }
}

class _ThemeSettingsPage extends StatefulWidget {
  const _ThemeSettingsPage(this.theme, {super.key});

  final jinya.Theme theme;

  @override
  State<_ThemeSettingsPage> createState() => _ThemeSettingsPageState(theme);
}

class _ThemeSettingsPageState extends State<_ThemeSettingsPage> {
  final jinya.Theme theme;
  final Map<String, Map<String, TextEditingController>> editors = {};
  final Map<String, Map<String, bool>> booleans = {};
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  jinya.ThemeConfigurationStructure? structure;
  Map<String, Map<String, dynamic>> defaultConfiguration = {};
  var loadingFailed = false;

  _ThemeSettingsPageState(this.theme);

  Future<void> loadThemeConfiguration() async {
    try {
      final structure =
          await apiClient.getThemeConfigurationStructure(theme.id!);
      final defaultConfiguration =
          await apiClient.getThemeDefaultConfiguration(theme.id!);
      setState(() {
        this.structure = structure;
        this.defaultConfiguration = defaultConfiguration;
        for (var group in structure.groups!) {
          editors[group.name!] = {};
          booleans[group.name!] = {};
          for (var field in group.fields!) {
            if (field.type == 'string') {
              editors[group.name!]![field.name!] = TextEditingController(
                  text: theme.configuration?[group.name!]?[field.name!] ?? '');
            }
            if (field.type == 'boolean') {
              booleans[group.name!]![field.name!] =
                  theme.configuration?[group.name!]?[field.name!] == true;
            }
          }
        }
      });
    } catch (ex) {
      setState(() {
        loadingFailed = true;
      });
    }
  }

  @override
  void initState() {
    loadThemeConfiguration();
    super.initState();
  }

  @override
  void dispose() {
    for (var item in editors.keys) {
      final group = editors[item]!;
      for (var field in group.keys) {
        group[field]!.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    if (structure == null || loadingFailed) {
      return Container();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: structure!.groups!.map((group) {
              var groupTitle = '';
              if (group.title!.containsKey(locale)) {
                groupTitle = group.title![locale] ?? '';
              } else if (group.title!.containsKey('en')) {
                groupTitle = group.title!['en']!;
              } else {
                groupTitle = group.title![group.title!.keys.first]!;
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      textAlign: TextAlign.start,
                      groupTitle,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  ...group.fields!.map((field) {
                    var fieldTitle = '';
                    if (field.label!.containsKey(locale)) {
                      fieldTitle = field.label![locale] ?? '';
                    } else if (field.label!.containsKey('en')) {
                      fieldTitle = field.label!['en']!;
                    } else {
                      fieldTitle = field.label![field.label!.keys.first]!;
                    }

                    if (field.type == 'string') {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller: editors[group.name]![field.name],
                          decoration: InputDecoration(
                            labelText: fieldTitle,
                            hintText:
                                defaultConfiguration[group.name]![field.name],
                          ),
                        ),
                      );
                    } else if (field.type == 'boolean') {
                      return Row(
                        children: [
                          Switch(
                            value: booleans[group.name]![field.name] ??
                                defaultConfiguration[group.name]![field.name],
                            onChanged: (value) {
                              setState(() {
                                booleans[group.name]![field.name!] = value;
                              });
                            },
                          ),
                          Text(fieldTitle),
                        ],
                      );
                    }

                    return Container();
                  }),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final config = <String, Map<String, dynamic>>{};
          for (var group in structure!.groups!) {
            config[group.name!] = {};
            for (var field in group.fields!) {
              if (field.type == 'string') {
                config[group.name!]![field.name!] =
                    editors[group.name!]![field.name!]?.text ?? '';
              }
              if (field.type == 'boolean') {
                config[group.name!]![field.name!] =
                    booleans[group.name!]![field.name!];
              }
            }
          }
          try {
            await apiClient.updateConfiguration(theme.id!, config);
            messenger.showSnackBar(SnackBar(
              content: Text(l10n.themeConfigurationSaved),
              behavior: SnackBarBehavior.floating,
            ));
          } catch (ex) {
            messenger.showSnackBar(SnackBar(
              content: Text(l10n.themeConfigurationSaveError),
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        tooltip: l10n.themeSettingsSave,
        child: const Icon(Icons.save),
      ),
    );
  }
}

class _ThemeLinksPage extends StatefulWidget {
  const _ThemeLinksPage(this.theme, {super.key});

  final jinya.Theme theme;

  @override
  State<_ThemeLinksPage> createState() => _ThemeLinksPageState(theme);
}

class _ThemeLinksPageState extends State<_ThemeLinksPage> {
  final jinya.Theme theme;
  final apiClient = SettingsDatabase.getClientForCurrentAccount();
  jinya.ThemeConfigurationLinks? links;
  Iterable<jinya.ThemeFile> themeFiles = [];
  Iterable<jinya.ThemePage> themeSimplePages = [];
  Iterable<jinya.ThemeMenu> themeMenus = [];
  Iterable<jinya.ThemeForm> themeForms = [];
  Iterable<jinya.ThemeGallery> themeGalleries = [];
  Iterable<jinya.ThemeSegmentPage> themeSegmentPages = [];
  Iterable<jinya.ThemeBlogCategory> themeBlogCategories = [];

  Iterable<jinya.File> files = [];
  Iterable<jinya.SimplePage> pages = [];
  Iterable<jinya.Menu> menus = [];
  Iterable<jinya.Form> forms = [];
  Iterable<jinya.Gallery> galleries = [];
  Iterable<jinya.SegmentPage> segmentPages = [];
  Iterable<jinya.BlogCategory> blogCategories = [];

  Map<String, int> selectedFiles = {};
  Map<String, int> selectedPages = {};
  Map<String, int> selectedMenus = {};
  Map<String, int> selectedForms = {};
  Map<String, int> selectedGalleries = {};
  Map<String, int> selectedSegmentPages = {};
  Map<String, int> selectedBlogCategories = {};

  _ThemeLinksPageState(this.theme);

  Future<void> loadThemeConfiguration() async {
    final structure = await apiClient.getThemeConfigurationStructure(theme.id!);
    setState(() {
      links = structure.links;
    });
    loadThemeFiles();
    loadThemeSimplePages();
    loadThemeMenus();
    loadThemeForms();
    loadThemeGalleries();
    loadThemeSegmentPages();
    loadThemeBlogCategories();
  }

  Future<void> loadThemeFiles() async {
    final themeFiles = await apiClient.getThemeFiles(theme.id!);
    final files = await apiClient.getFiles();
    final selectedFiles = <String, int>{};
    for (var file in links!.files!.keys) {
      final themeFile = themeFiles.where((element) => element.name == file);
      if (themeFile.isNotEmpty) {
        final tf = themeFile.first;
        final selectedFile =
            files.where((element) => element.id == tf.file!.id);
        if (selectedFile.isNotEmpty) {
          selectedFiles[file] = selectedFile.first.id!;
        } else {
          selectedFiles[file] = files.first.id!;
        }
      } else {
        selectedFiles[file] = files.first.id!;
      }
    }
    setState(() {
      this.files = files;
      this.themeFiles = themeFiles;
      this.selectedFiles = selectedFiles;
    });
  }

  Future<void> loadThemeSimplePages() async {
    final themePages = await apiClient.getThemeSimplePages(theme.id!);
    final pages = await apiClient.getSimplePages();
    final selectedPages = <String, int>{};
    for (var cat in links!.pages!.keys) {
      final themePage = themePages.where((element) => element.name == cat);
      if (themePage.isNotEmpty) {
        final tf = themePage.first;
        final selectedPage =
            pages.where((element) => element.id == tf.page!.id);
        if (selectedPage.isNotEmpty) {
          selectedPages[cat] = selectedPage.first.id!;
        } else {
          selectedPages[cat] = pages.first.id!;
        }
      } else {
        selectedPages[cat] = pages.first.id!;
      }
    }
    setState(() {
      this.pages = pages;
      themeSimplePages = themePages;
      this.selectedPages = selectedPages;
    });
  }

  Future<void> loadThemeMenus() async {
    final themeMenus = await apiClient.getThemeMenus(theme.id!);
    final menus = await apiClient.getMenus();
    final selectedMenus = <String, int>{};
    for (var cat in links!.menus!.keys) {
      final themeMenu = themeMenus.where((element) => element.name == cat);
      if (themeMenu.isNotEmpty) {
        final tf = themeMenu.first;
        final selectedMenu =
            menus.where((element) => element.id == tf.menu!.id);
        if (selectedMenu.isNotEmpty) {
          selectedMenus[cat] = selectedMenu.first.id!;
        } else {
          selectedMenus[cat] = menus.first.id!;
        }
      } else {
        selectedMenus[cat] = menus.first.id!;
      }
    }
    setState(() {
      this.menus = menus;
      this.themeMenus = themeMenus;
      this.selectedMenus = selectedMenus;
    });
  }

  Future<void> loadThemeForms() async {
    final themeForms = await apiClient.getThemeForms(theme.id!);
    final forms = await apiClient.getForms();
    final selectedForms = <String, int>{};
    for (var cat in links!.forms!.keys) {
      final themeForm = themeForms.where((element) => element.name == cat);
      if (themeForm.isNotEmpty) {
        final tf = themeForm.first;
        final selectedForm =
            forms.where((element) => element.id == tf.form!.id);
        if (selectedForm.isNotEmpty) {
          selectedForms[cat] = selectedForm.first.id!;
        } else {
          selectedForms[cat] = forms.first.id!;
        }
      } else {
        selectedForms[cat] = forms.first.id!;
      }
    }
    setState(() {
      this.forms = forms;
      this.themeForms = themeForms;
      this.selectedForms = selectedForms;
    });
  }

  Future<void> loadThemeGalleries() async {
    final themeGalleries = await apiClient.getThemeGalleries(theme.id!);
    final galleries = await apiClient.getGalleries();
    final selectedGalleries = <String, int>{};
    for (var cat in links!.galleries!.keys) {
      final themeGallery =
          themeGalleries.where((element) => element.name == cat);
      if (themeGallery.isNotEmpty) {
        final tf = themeGallery.first;
        final selectedGallery =
            galleries.where((element) => element.id == tf.gallery!.id);
        if (selectedGallery.isNotEmpty) {
          selectedGalleries[cat] = selectedGallery.first.id!;
        } else {
          selectedGalleries[cat] = galleries.first.id!;
        }
      } else {
        selectedGalleries[cat] = galleries.first.id!;
      }
    }
    setState(() {
      this.galleries = galleries;
      this.themeGalleries = themeGalleries;
      this.selectedGalleries = selectedGalleries;
    });
  }

  Future<void> loadThemeSegmentPages() async {
    final themeSegmentPages = await apiClient.getThemeSegmentPages(theme.id!);
    final segmentPages = await apiClient.getSegmentPages();
    final selectedSegmentPages = <String, int>{};
    for (var cat in links!.segmentPages!.keys) {
      final themeSegmentPage =
          themeSegmentPages.where((element) => element.name == cat);
      if (themeSegmentPage.isNotEmpty) {
        final tf = themeSegmentPage.first;
        final selectedSegmentPage =
            segmentPages.where((element) => element.id == tf.segmentPage!.id);
        if (selectedSegmentPage.isNotEmpty) {
          selectedSegmentPages[cat] = selectedSegmentPage.first.id!;
        } else {
          selectedSegmentPages[cat] = segmentPages.first.id!;
        }
      } else {
        selectedSegmentPages[cat] = segmentPages.first.id!;
      }
    }
    setState(() {
      this.segmentPages = segmentPages;
      this.themeSegmentPages = themeSegmentPages;
      this.selectedSegmentPages = selectedSegmentPages;
    });
  }

  Future<void> loadThemeBlogCategories() async {
    final themeCategories = await apiClient.getThemeCategories(theme.id!);
    final categories = await apiClient.getBlogCategories();
    final selectedCategories = <String, int>{};
    for (var cat in links!.blogCategories!.keys) {
      final themeCategory =
          themeCategories.where((element) => element.name == cat);
      if (themeCategory.isNotEmpty) {
        final tf = themeCategory.first;
        final selectedCategory =
            categories.where((element) => element.id == tf.blogCategory!.id);
        if (selectedCategory.isNotEmpty) {
          selectedCategories[cat] = selectedCategory.first.id!;
        } else {
          selectedCategories[cat] = categories.first.id!;
        }
      } else {
        selectedCategories[cat] = categories.first.id!;
      }
    }
    setState(() {
      blogCategories = categories;
      themeBlogCategories = themeCategories;
      selectedBlogCategories = selectedCategories;
    });
  }

  @override
  void initState() {
    super.initState();
    loadThemeConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final messenger = ScaffoldMessenger.of(context);
    final children = <Widget>[];

    if (links?.files?.isNotEmpty == true) {
      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          l10n.themeLinksFiles,
          style: Theme.of(context).textTheme.headline5,
        ),
      ));
      children.addAll(
        links!.files!.keys.map(
          (fileKey) {
            var fieldTitle = '';
            final file = links!.files![fileKey]!;
            if (file.containsKey(locale)) {
              fieldTitle = file[locale] ?? '';
            } else if (file.containsKey('en')) {
              fieldTitle = file['en']!;
            } else {
              fieldTitle = file[file.keys.first]!;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: DropdownButtonFormField(
                value: selectedFiles[fileKey],
                items: files
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id!,
                        child: Text(e.name!),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedFiles[fileKey] = value!;
                },
                decoration: InputDecoration(labelText: fieldTitle),
              ),
            );
          },
        ),
      );
    }
    if (links?.pages?.isNotEmpty == true) {
      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          l10n.themeLinksSimplePages,
          style: Theme.of(context).textTheme.headline5,
        ),
      ));
      children.addAll(
        links!.pages!.keys.map(
          (pageKey) {
            var fieldTitle = '';
            final page = links!.pages![pageKey]!;
            if (page.containsKey(locale)) {
              fieldTitle = page[locale] ?? '';
            } else if (page.containsKey('en')) {
              fieldTitle = page['en']!;
            } else {
              fieldTitle = page[page.keys.first]!;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: DropdownButtonFormField(
                value: selectedPages[pageKey],
                items: pages
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id!,
                        child: Text(e.title!),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedPages[pageKey] = value!;
                },
                decoration: InputDecoration(labelText: fieldTitle),
              ),
            );
          },
        ),
      );
    }
    if (links?.menus?.isNotEmpty == true) {
      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          l10n.themeLinksMenus,
          style: Theme.of(context).textTheme.headline5,
        ),
      ));
      children.addAll(
        links!.menus!.keys.map(
          (menuKey) {
            var fieldTitle = '';
            final menu = links!.menus![menuKey]!;
            if (menu.containsKey(locale)) {
              fieldTitle = menu[locale] ?? '';
            } else if (menu.containsKey('en')) {
              fieldTitle = menu['en']!;
            } else {
              fieldTitle = menu[menu.keys.first]!;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: DropdownButtonFormField(
                value: selectedMenus[menuKey],
                items: menus
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id!,
                        child: Text(e.name!),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedMenus[menuKey] = value!;
                },
                decoration: InputDecoration(labelText: fieldTitle),
              ),
            );
          },
        ),
      );
    }
    if (links?.galleries?.isNotEmpty == true) {
      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          l10n.themeLinksGalleries,
          style: Theme.of(context).textTheme.headline5,
        ),
      ));
      children.addAll(
        links!.galleries!.keys.map(
          (galleryKey) {
            var fieldTitle = '';
            final gallery = links!.galleries![galleryKey]!;
            if (gallery.containsKey(locale)) {
              fieldTitle = gallery[locale] ?? '';
            } else if (gallery.containsKey('en')) {
              fieldTitle = gallery['en']!;
            } else {
              fieldTitle = gallery[gallery.keys.first]!;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: DropdownButtonFormField(
                value: selectedGalleries[galleryKey],
                items: galleries
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id!,
                        child: Text(e.name!),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedGalleries[galleryKey] = value!;
                },
                decoration: InputDecoration(labelText: fieldTitle),
              ),
            );
          },
        ),
      );
    }
    if (links?.segmentPages?.isNotEmpty == true) {
      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          l10n.themeLinksSegmentPages,
          style: Theme.of(context).textTheme.headline5,
        ),
      ));
      children.addAll(
        links!.segmentPages!.keys.map(
          (segmentPageKey) {
            var fieldTitle = '';
            final segmentPage = links!.segmentPages![segmentPageKey]!;
            if (segmentPage.containsKey(locale)) {
              fieldTitle = segmentPage[locale] ?? '';
            } else if (segmentPage.containsKey('en')) {
              fieldTitle = segmentPage['en']!;
            } else {
              fieldTitle = segmentPage[segmentPage.keys.first]!;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: DropdownButtonFormField(
                value: selectedSegmentPages[segmentPageKey],
                items: segmentPages
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id!,
                        child: Text(e.name!),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedSegmentPages[segmentPageKey] = value!;
                },
                decoration: InputDecoration(labelText: fieldTitle),
              ),
            );
          },
        ),
      );
    }
    if (links?.forms?.isNotEmpty == true) {
      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          l10n.themeLinksForms,
          style: Theme.of(context).textTheme.headline5,
        ),
      ));
      children.addAll(
        links!.forms!.keys.map(
          (formKey) {
            var fieldTitle = '';
            final form = links!.forms![formKey]!;
            if (form.containsKey(locale)) {
              fieldTitle = form[locale] ?? '';
            } else if (form.containsKey('en')) {
              fieldTitle = form['en']!;
            } else {
              fieldTitle = form[form.keys.first]!;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: DropdownButtonFormField(
                value: selectedForms[formKey],
                items: forms
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id!,
                        child: Text(e.title!),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedForms[formKey] = value!;
                },
                decoration: InputDecoration(labelText: fieldTitle),
              ),
            );
          },
        ),
      );
    }
    if (links?.blogCategories?.isNotEmpty == true) {
      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          l10n.themeLinksBlogCategories,
          style: Theme.of(context).textTheme.headline5,
        ),
      ));
      children.addAll(
        links!.blogCategories!.keys.map(
          (categoryKey) {
            var fieldTitle = '';
            final category = links!.blogCategories![categoryKey]!;
            if (category.containsKey(locale)) {
              fieldTitle = category[locale] ?? '';
            } else if (category.containsKey('en')) {
              fieldTitle = category['en']!;
            } else {
              fieldTitle = category[category.keys.first]!;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: DropdownButtonFormField(
                value: selectedBlogCategories[categoryKey],
                items: blogCategories
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id!,
                        child: Text(e.name!),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedBlogCategories[categoryKey] = value!;
                },
                decoration: InputDecoration(labelText: fieldTitle),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final futures = <Future<void>>[];
          if (links!.blogCategories != null) {
            for (var item in links!.blogCategories!.keys) {
              futures.add(apiClient.updateThemeCategory(
                  theme.id!, item, selectedBlogCategories[item]!));
            }
          }
          if (links!.pages != null) {
            for (var item in links!.pages!.keys) {
              futures.add(apiClient.updateThemeSimplePage(
                  theme.id!, item, selectedPages[item]!));
            }
          }
          if (links!.galleries != null) {
            for (var item in links!.galleries!.keys) {
              futures.add(apiClient.updateThemeGallery(
                  theme.id!, item, selectedGalleries[item]!));
            }
          }
          if (links!.segmentPages != null) {
            for (var item in links!.segmentPages!.keys) {
              futures.add(apiClient.updateThemeSegmentPage(
                  theme.id!, item, selectedSegmentPages[item]!));
            }
          }
          if (links!.forms != null) {
            for (var item in links!.files!.keys) {
              futures.add(apiClient.updateThemeFile(
                  theme.id!, item, selectedFiles[item]!));
            }
          }
          if (links!.forms != null) {
            for (var item in links!.forms!.keys) {
              futures.add(apiClient.updateThemeForm(
                  theme.id!, item, selectedForms[item]!));
            }
          }
          if (links!.menus != null) {
            for (var item in links!.menus!.keys) {
              futures.add(apiClient.updateThemeMenu(
                  theme.id!, item, selectedMenus[item]!));
            }
          }

          try {
            await Future.wait(futures);

            messenger.showSnackBar(SnackBar(
              content: Text(l10n.themeLinksSaved),
              behavior: SnackBarBehavior.floating,
            ));
          } catch (ex) {
            messenger.showSnackBar(SnackBar(
              content: Text(l10n.themeLinksSaveError),
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        tooltip: l10n.themeLinksSave,
        child: const Icon(Icons.save),
      ),
    );
  }
}

class _ThemeVariablesPage extends StatefulWidget {
  final jinya.Theme theme;

  const _ThemeVariablesPage(this.theme, {super.key});

  @override
  State<_ThemeVariablesPage> createState() => _ThemeVariablesPageState(theme);
}

class _ThemeVariablesPageState extends State<_ThemeVariablesPage> {
  final jinya.Theme theme;
  final Map<String, TextEditingController> editors = {};
  Map<String, String> variables = {};
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  _ThemeVariablesPageState(this.theme);

  Future<void> loadThemeConfiguration() async {
    final variables = await apiClient.getStyleVariables(theme.id!);
    setState(() {
      this.variables = variables;
      for (var item in variables.keys) {
        editors[item] =
            TextEditingController(text: theme.scssVariables?[item] ?? '');
      }
    });
  }

  @override
  void dispose() {
    for (var item in editors.keys) {
      editors[item]!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadThemeConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: editors.keys
                .map(
                  (e) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextFormField(
                      controller: editors[e],
                      decoration:
                          InputDecoration(labelText: e, hintText: variables[e]),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Map<String, String> data = Map<String, String>.from(variables);
          for (var item in editors.keys) {
            final editor = editors[item]!;
            if (editor.text.isNotEmpty) {
              data[item] = editor.text;
            }
          }

          try {
            await apiClient.updateStyleVariables(theme.id!, data);
            messenger.showSnackBar(SnackBar(
              content: Text(l10n.themeVariablesSaved),
              behavior: SnackBarBehavior.floating,
            ));
          } catch (ex) {
            messenger.showSnackBar(SnackBar(
              content: Text(l10n.themeVariablesSaveError),
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        tooltip: l10n.themeVariablesSave,
        child: const Icon(Icons.save),
      ),
    );
  }
}
