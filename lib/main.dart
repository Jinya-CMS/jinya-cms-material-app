import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/color_scheme.g.dart';
import 'package:jinya_cms_material_app/data/accountDatabase.dart';
import 'package:jinya_cms_material_app/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
        primaryIconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
        toggleableActiveColor: darkColorScheme.primary,
        inputDecorationTheme: const InputDecorationTheme(border: UnderlineInputBorder()),
      ),
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          iconTheme: Theme.of(context).iconTheme.copyWith(
                color: Colors.black,
              ),
          primaryIconTheme: Theme.of(context).iconTheme.copyWith(
                color: Colors.white,
              ),
          toggleableActiveColor: lightColorScheme.primary,
          inputDecorationTheme: const InputDecorationTheme(border: UnderlineInputBorder())),
      home: HomePage(),
    );
  }
}
