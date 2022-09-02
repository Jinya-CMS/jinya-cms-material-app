import 'package:flutter/material.dart';
import 'package:jinya_cms_app/l10n/localizations.dart';
import 'package:jinya_cms_app/pages/sites/newAccount.dart';
import 'package:jinya_cms_app/data/accountDatabase.dart';
import 'package:jinya_cms_app/shared/navDrawer.dart';

class ManageAccountsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageAccountsPageState();
  }
}

class ManageAccountsPageState extends State<ManageAccountsPage> {
  var accounts = <Account>[];

  void loadAccounts() async {
    final accs = await getAccounts();
    setState(() {
      accounts = accs;
    });
  }

  @override
  void initState() {
    loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.manageAccountsTitle),
      ),
      drawer: JinyaNavigationDrawer(),
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
            key: Key(accounts[index].id.toString()),
            onDismissed: (direction) {
              final account = accounts[index];
              deleteAccount(account.id).then((val) => loadAccounts());
              final snackBar = SnackBar(
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
              title: Text(accounts[index].name),
              subtitle: Text(
                '${accounts[index].email}\n${Uri.parse(accounts[index].url).host}',
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    '${accounts[index].url}/api/user/${accounts[index].jinyaId}/profilepicture',
                    headers: {'JinyaApiKey': accounts[index].apiKey}),
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
              builder: (context) => NewAccountPage(),
            ),
          );
        },
      ),
    );
  }
}
