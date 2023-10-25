import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/files.dart';
import 'package:jinya_cms_material_app/pages/galleries.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';

class Media extends StatelessWidget {
  const Media({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.menuMedia),
          bottom: TabBar(
            tabs: [
              Tab(
                text: l10n.menuManageFiles,
              ),
              Tab(
                text: l10n.menuManageGalleries,
              ),
            ],
          ),
        ),
        drawer: const JinyaNavigationDrawer(),
        body: const TabBarView(
          children: [ListFiles(), ListGalleries()],
        ),
      ),
    );
  }
}
