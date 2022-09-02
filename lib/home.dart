import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_cms_app/data/accountDatabase.dart';
import 'package:jinya_cms_app/l10n/localizations.dart';
import 'package:jinya_cms_app/login.dart';
import 'package:jinya_cms_app/pages/sites/manageAccounts.dart';
import 'package:jinya_cms_app/shared/currentUser.dart';
import 'package:jinya_cms_app/shared/navDrawer.dart';
import 'package:jinya_cms_app/network/authentication/login.dart';

const String homePageBackground = 'assets/home/background.jpg';

class HomePage extends StatelessWidget {
  void checkAuth(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (SettingsDatabase.selectedAccount == null) {
      final accounts = await getAccounts();
      if (accounts.isNotEmpty) {
        SettingsDatabase.selectedAccount = accounts.first;
      } else {
        navigator.pushReplacement(
          MaterialPageRoute(
            builder: (context) => ManageAccountsPage(),
          ),
        );
      }
    }

    if (!(await checkApiKey(SettingsDatabase.selectedAccount!.apiKey))) {
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    checkAuth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
      ),
      drawer: JinyaNavigationDrawer(),
      body: Image.asset(
        homePageBackground,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
