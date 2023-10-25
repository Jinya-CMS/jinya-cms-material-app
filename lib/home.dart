import 'package:flutter/material.dart';
import 'package:jinya_cms_api/client/jinya_client.dart';
import 'package:jinya_cms_material_app/data/account_database.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/login.dart';
import 'package:jinya_cms_material_app/pages/accounts.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';

const String homePageSmallBackground = 'assets/home/background-small.png';
const String homePageBackground = 'assets/home/background.png';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> checkApiKey() async {
    if (!(await JinyaClient(SettingsDatabase.selectedAccount!.url,
            apiKey: SettingsDatabase.selectedAccount!.apiKey)
        .validateApiKey(SettingsDatabase.selectedAccount!.apiKey))) {
      NavigationService.instance.navigateToReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
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
    final query = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
      ),
      drawer: const JinyaNavigationDrawer(),
      body: Image.asset(
        query.size.width >= 720 ? homePageBackground : homePageSmallBackground,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
