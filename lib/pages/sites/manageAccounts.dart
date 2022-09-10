import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_android_app/l10n/localizations.dart';
import 'package:jinya_cms_android_app/pages/sites/newAccount.dart';
import 'package:jinya_cms_android_app/data/accountDatabase.dart';
import 'package:jinya_cms_android_app/shared/navDrawer.dart';

class ManageAccountsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageAccountsPageState();
  }
}

class ManageAccountsPageState extends State<ManageAccountsPage> {
  Iterable<Account> accounts = <Account>[];

  void loadAccounts() async {
    final accs = await getAccounts();
    setState(() {
      accounts = accs;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.manageAccountsTitle),
      ),
      drawer: accounts.isEmpty ? null : JinyaNavigationDrawer(),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: accounts.length,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemBuilder: (context, index) => Dismissible(
            background: Container(
              color: Theme.of(context).errorColor,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            key: Key(accounts.elementAt(index).url),
            onDismissed: (direction) {
              final account = accounts.elementAt(index);
              deleteAccount(account.url).then((val) => loadAccounts());
              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(l10n.manageAccountsDeleteSuccess(account.name)),
                action: SnackBarAction(
                  textColor: Theme.of(context).primaryColor,
                  label: l10n.actionUndo,
                  onPressed: () {
                    createAccount(account).then((val) => loadAccounts());
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            direction: DismissDirection.endToStart,
            child: ListTile(
              title: Text(accounts.elementAt(index).name),
              subtitle: Text(
                '${accounts.elementAt(index).email}\n${Uri.parse(accounts.elementAt(index).url).host}',
              ),
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    '${accounts.elementAt(index).url}${accounts.elementAt(index).profilePicture}',
                    headers: {'JinyaApiKey': accounts.elementAt(index).apiKey}),
              ),
              isThreeLine: true,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NewAccountPage(),
            ),
          );
        },
      ),
    );
  }
}
