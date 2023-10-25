import 'package:flutter/material.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/blog_categories.dart';
import 'package:jinya_cms_material_app/pages/blog_posts.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';

class Blog extends StatelessWidget {
  const Blog({super.key});

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
                text: l10n.menuManageBlogCategories,
              ),
              Tab(
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
