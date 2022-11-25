import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/data/account_database.dart';
import 'package:jinya_cms_material_app/home.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/blog.dart';
import 'package:jinya_cms_material_app/pages/forms.dart';
import 'package:jinya_cms_material_app/pages/media.dart';
import 'package:jinya_cms_material_app/pages/menus.dart';
import 'package:jinya_cms_material_app/pages/pages.dart';
import 'package:jinya_cms_material_app/pages/accounts.dart';
import 'package:jinya_cms_material_app/pages/themes.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class JinyaNavigationDrawer extends StatefulWidget {
  const JinyaNavigationDrawer({super.key});

  @override
  State<StatefulWidget> createState() {
    return JinyaNavigationDrawerState();
  }
}

class JinyaNavigationDrawerState extends State<JinyaNavigationDrawer> with TickerProviderStateMixin {
  static final Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  AnimationController? _animationController;
  Animation<double>? _drawerContentsOpacity;
  Animation<Offset>? _drawerDetailsPosition;
  var _showDrawerContents = true;
  var currentUser = SettingsDatabase.selectedAccount;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_animationController!),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = _animationController!.drive(_drawerDetailsTween);
    loadAccounts();
  }

  var accounts = <Account>[];

  void loadAccounts() async {
    var values = await getAccounts();
    var accs = <Account>[];
    Account currUser;
    if (values.isNotEmpty) {
      if (currentUser == null && values.isNotEmpty) {
        currUser = values.first;
        SettingsDatabase.selectedAccount = currUser;
        setState(() {
          currentUser = values.first;
        });
      }

      var otherAccounts = values.where(
        (account) => account.url != SettingsDatabase.selectedAccount!.url,
      );
      if (otherAccounts.isNotEmpty) {
        accs.addAll(otherAccounts);
      }
      setState(() {
        accounts = accs;
      });
    } else {
      _animationController!.forward();
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final frontStageItems = <ListTile>[];
    if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_READER') ||
        SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
      frontStageItems.add(
        ListTile(
          title: Text(l10n.menuMedia),
          leading: const Icon(MdiIcons.imageMultiple),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Media(),
              ),
            );
          },
        ),
      );
      frontStageItems.add(
        ListTile(
          title: Text(l10n.menuPages),
          leading: const Icon(Icons.menu_book),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Pages(),
              ),
            );
          },
        ),
      );
      frontStageItems.add(
        ListTile(
          title: Text(l10n.menuForms),
          leading: const Icon(MdiIcons.formTextbox),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Forms(),
              ),
            );
          },
        ),
      );
      frontStageItems.add(
        ListTile(
          title: Text(l10n.menuBlog),
          leading: const Icon(MdiIcons.post),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Blog(),
              ),
            );
          },
        ),
      );
      frontStageItems.add(
        ListTile(
          title: Text(l10n.menuMenu),
          leading: const Icon(Icons.menu),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Menus(),
              ),
            );
          },
        ),
      );
      frontStageItems.add(
        ListTile(
          title: Text(l10n.menuTheme),
          leading: const Icon(MdiIcons.pencilRuler),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Themes(),
              ),
            );
          },
        ),
      );
    }

    return Row(
      children: [
        Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('${currentUser!.name} (${currentUser!.email})'),
                accountEmail: Text(currentUser!.url),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: CachedNetworkImageProvider('${currentUser!.url}${currentUser!.profilePicture}')),
                otherAccountsPictures: accounts
                    .map(
                      (account) => GestureDetector(
                        dragStartBehavior: DragStartBehavior.down,
                        onTap: () {
                          SettingsDatabase.selectedAccount = account;
                          setState(() {
                            currentUser = account;
                            loadAccounts();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          });
                        },
                        child: Semantics(
                          label: l10n.menuSwitchAccount,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            backgroundImage: CachedNetworkImageProvider(
                              '${account.url}${account.profilePicture}',
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onDetailsPressed: () {
                  _showDrawerContents = !_showDrawerContents;
                  if (_showDrawerContents) {
                    _animationController!.reverse();
                  } else {
                    _animationController!.forward();
                  }
                },
              ),
              Stack(
                children: <Widget>[
                  // The initial contents of the drawer.
                  FadeTransition(
                    opacity: _drawerContentsOpacity!,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: frontStageItems,
                    ),
                  ),
                  SlideTransition(
                    position: _drawerDetailsPosition!,
                    child: FadeTransition(
                      opacity: ReverseAnimation(_drawerContentsOpacity!),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ...accounts.map((account) => ListTile(
                                title: Text('${account.name} (${account.email})'),
                                subtitle: Text(account.url),
                                onTap: () {
                                  SettingsDatabase.selectedAccount = account;
                                  setState(() {
                                    currentUser = account;
                                    loadAccounts();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  });
                                },
                              )),
                          ListTile(
                            leading: const Icon(Icons.add),
                            title: Text(l10n.menuAddAccount),
                            iconColor: Theme.of(context).iconTheme.color,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const NewAccountPage(),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: Text(l10n.menuManageAccounts),
                            iconColor: Theme.of(context).iconTheme.color,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ManageAccountsPage(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
