import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jinya_cms_material_app/color_schemes.g.dart';
import 'package:jinya_cms_material_app/data/account_database.dart';
import 'package:jinya_cms_material_app/home.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';

void main() async {
  Hive.registerAdapter(AccountAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Account>('accounts');
  runApp(const JinyaCmsApp());
}

class JinyaCmsApp extends StatelessWidget {
  const JinyaCmsApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigationKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      title: 'Jinya CMS App',
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(),
          filled: true,
        ),
      ),
      theme: ThemeData(
        useMaterial3: true,
        tabBarTheme: TabBarTheme.of(context).copyWith(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black45,
        ),
        colorScheme: lightColorScheme,
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(),
          filled: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}
