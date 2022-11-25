import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
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
    final locale = Localizations.localeOf(context).languageCode;

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
        imageUrl: '${SettingsDatabase.selectedAccount!.url}/api/theme/${item.id}/preview',
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
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _ThemeDetailsPage(_ThemeDetailsPage.tabSettings, item),
                ));
                await loadThemes();
              },
              icon: const Icon(MdiIcons.cog),
            ),
            IconButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _ThemeDetailsPage(_ThemeDetailsPage.tabLinks, item),
                ));
                await loadThemes();
              },
              icon: const Icon(MdiIcons.linkVariant),
            ),
            IconButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _ThemeDetailsPage(_ThemeDetailsPage.tabVariables, item),
                ));
                await loadThemes();
              },
              icon: const Icon(MdiIcons.sass),
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
  State<_ThemeDetailsPage> createState() => _ThemeDetailsPageState(initialIndex, theme);
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
                icon: const Icon(MdiIcons.cog),
                text: l10n.menuThemeSettings,
              ),
              Tab(
                icon: const Icon(MdiIcons.linkVariant),
                text: l10n.menuThemeLinks,
              ),
              Tab(
                icon: const Icon(MdiIcons.sass),
                text: l10n.menuThemeVariables,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [_ThemeSettingsPage(theme), _ThemeLinksPage(theme), _ThemeVariablesPage(theme)],
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
      final structure = await apiClient.getThemeConfigurationStructure(theme.id!);
      final defaultConfiguration = await apiClient.getThemeDefaultConfiguration(theme.id!);
      setState(() {
        this.structure = structure;
        this.defaultConfiguration = defaultConfiguration;
        for (var group in structure.groups!) {
          editors[group.name!] = {};
          booleans[group.name!] = {};
          for (var field in group.fields!) {
            if (field.type == 'string') {
              editors[group.name!]![field.name!] =
                  TextEditingController(text: theme.configuration?[group.name!]?[field.name!] ?? '');
            }
            if (field.type == 'boolean') {
              booleans[group.name!]![field.name!] = theme.configuration?[group.name!]?[field.name!] == true;
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller: editors[group.name]![field.name],
                          decoration: InputDecoration(
                            labelText: fieldTitle,
                            hintText: defaultConfiguration[group.name]![field.name],
                          ),
                        ),
                      );
                    } else if (field.type == 'boolean') {
                      return Row(
                        children: [
                          Switch(
                            value: booleans[group.name]![field.name] ?? defaultConfiguration[group.name]![field.name],
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
                config[group.name!]![field.name!] = editors[group.name!]![field.name!]?.text ?? '';
              }
              if (field.type == 'boolean') {
                config[group.name!]![field.name!] = booleans[group.name!]![field.name!];
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
  final Map<String, TextEditingController> editors = {};
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  _ThemeLinksPageState(this.theme);

  Future<void> loadThemeConfiguration() async {
    final structure = await apiClient.getThemeConfigurationStructure(theme.id!);
  }

  @override
  void dispose() {
    for (var item in editors.keys) {
      editors[item]!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
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
        editors[item] = TextEditingController(text: theme.scssVariables?[item] ?? '');
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextFormField(
                      controller: editors[e],
                      decoration: InputDecoration(labelText: e, hintText: variables[e]),
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
        child: const Icon(Icons.save),
      ),
    );
  }
}
