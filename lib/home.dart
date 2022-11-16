import 'package:flutter/material.dart';
import 'package:jinya_cms_api/client/jinya_client.dart';
import 'package:jinya_cms_material_app/data/account_database.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/login.dart';
import 'package:jinya_cms_material_app/pages/accounts.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';

const String homePageBackground = 'assets/home/background.jpg';

class HomePage extends StatelessWidget {
  Future<void> checkApiKey() async {
    if (!(await JinyaClient(SettingsDatabase.selectedAccount!.url, apiKey: SettingsDatabase.selectedAccount!.apiKey)
        .validateApiKey(SettingsDatabase.selectedAccount!.apiKey))) {
      NavigationService.instance.navigateToReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  void checkAuth(BuildContext context) async {
    if (SettingsDatabase.selectedAccount == null) {
      final accounts = await getAccounts();
      if (accounts.isNotEmpty) {
        SettingsDatabase.selectedAccount = accounts.first;
        await checkApiKey();
      } else {
        NavigationService.instance.navigateToReplacement(
          MaterialPageRoute(
            builder: (context) => const ManageAccountsPage(),
          ),
        );
      }
    } else {
      await checkApiKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    checkAuth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
      ),
      drawer: const JinyaNavigationDrawer(),
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
