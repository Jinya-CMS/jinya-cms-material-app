import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/segment_pages.dart';
import 'package:jinya_cms_material_app/pages/simple_pages.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.menuPages),
          bottom: TabBar(
            tabs: [
              Tab(
                text: l10n.menuManageSimplePages,
              ),
              Tab(
                text: l10n.menuManageSegmentPages,
              ),
            ],
          ),
        ),
        drawer: const JinyaNavigationDrawer(),
        body: const TabBarView(
          children: [ListSimplePages(), ListSegmentPages()],
        ),
      ),
    );
  }
}
