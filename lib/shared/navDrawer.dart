import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_app/data/accountDatabase.dart';
import 'package:jinya_cms_app/home.dart';
import 'package:jinya_cms_app/l10n/localizations.dart';
import 'package:jinya_cms_app/pages/sites/manageAccounts.dart';
import 'package:jinya_cms_app/pages/sites/newAccount.dart';
import 'package:jinya_cms_app/shared/currentUser.dart';

class JinyaNavigationDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return JinyaNavigationDrawerState();
  }
}

class JinyaNavigationDrawerState extends State<JinyaNavigationDrawer>
    with TickerProviderStateMixin {
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
        (account) => account.id != SettingsDatabase.selectedAccount!.id,
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
    final l10n = AppLocalizations.of(context);
    final List<String> _drawerContents = <String>[];

    return Row(
      children: [
        Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(currentUser!.name),
                accountEmail: Text(currentUser!.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${currentUser?.url}/api/user/${currentUser?.jinyaId}/profilepicture'),
                ),
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
                          label: l10n!.menuSwitchAccount,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              '${account.url}/api/user/${account.jinyaId}/profilepicture',
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
                          ListTile(
                            leading: const Icon(Icons.add),
                            title: Text(l10n!.menuAddAccount),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NewAccountPage(),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: Text(l10n.menuManageAccounts),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManageAccountsPage(),
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
