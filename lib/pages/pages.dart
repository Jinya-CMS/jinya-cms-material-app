import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/segment_pages.dart';
import 'package:jinya_cms_material_app/pages/simple_pages.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Pages extends StatelessWidget {
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
                icon: const Icon(MdiIcons.fileDocument),
                text: l10n.menuManageSimplePages,
              ),
              Tab(
                icon: const Icon(MdiIcons.fileDocumentMultiple),
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
