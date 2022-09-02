import 'package:flutter/material.dart';
import 'package:jinya_cms_app/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      title: 'Jinya CMS App',
      darkTheme: ThemeData.dark().copyWith(
        primaryTextTheme:
            Typography.material2021(platform: TargetPlatform.android).white,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
        primaryIconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFF504a56),
            primary: const Color(0xFF966554),
            error: const Color(0xFF5C0B0B)),
      ),
      theme: ThemeData(
        canvasColor: Colors.white,
        primaryTextTheme:
            Typography.material2021(platform: TargetPlatform.android).white,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
        primaryIconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFF966554),
            primary: const Color(0xFF504a56),
            error: const Color(0xFF5C0B0B)),
      ),
      home: HomePage(),
    );
  }
}
