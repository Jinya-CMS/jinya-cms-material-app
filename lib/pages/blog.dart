import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/blog_categories.dart';
import 'package:jinya_cms_material_app/pages/blog_posts.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Blog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.menuBlog),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: const Icon(MdiIcons.tag),
                text: l10n.menuManageBlogCategories,
              ),
              Tab(
                icon: const Icon(MdiIcons.noteEdit),
                text: l10n.menuManageBlogPosts,
              ),
            ],
          ),
        ),
        drawer: const JinyaNavigationDrawer(),
        body: const TabBarView(
          children: [ListBlogCategories(), ListBlogPosts()],
        ),
      ),
    );
  }
}
