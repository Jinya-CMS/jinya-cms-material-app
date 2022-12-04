import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_api/client/jinya_client.dart';
import 'package:jinya_cms_material_app/data/account_database.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:validators/validators.dart';

class NewAccountTwoFactorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewAccountTwoFactorPageState();

  final NewAccountTransferObject newAccountTransferObject;

  const NewAccountTwoFactorPage(this.newAccountTransferObject);
}

class NewAccountTwoFactorPageState extends State<NewAccountTwoFactorPage> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void login() async {
    if (_formKey.currentState!.validate()) {
      final l10n = AppLocalizations.of(context);
      final navigator = Navigator.of(context);
      final scaffoldManager = ScaffoldMessenger.of(context);
      final apiClient = JinyaClient(widget.newAccountTransferObject.url);
      try {
        final result = await apiClient.login(
          widget.newAccountTransferObject.username,
          widget.newAccountTransferObject.password,
          twoFactorCode: _codeController.text,
        );

        final account = Account(
          url: widget.newAccountTransferObject.url,
          email: widget.newAccountTransferObject.username,
          apiKey: result.apiKey!,
          deviceToken: result.deviceCode!,
          profilePicture: '',
          jinyaId: -1,
          name: '',
        );
        SettingsDatabase.selectedAccount = account;
        final currentUser = await SettingsDatabase.getClientForCurrentAccount().getArtistInfo();
        account.name = currentUser.artistName!;
        account.profilePicture = currentUser.profilePicture!;
        account.jinyaId = currentUser.id!;
        account.roles = currentUser.roles;

        await createAccount(account);
        navigator.push(MaterialPageRoute(
          builder: (context) => const ManageAccountsPage(),
        ));
      } catch (e) {
        final snackbar = SnackBar(
          content: Text(l10n!.newAccountErrorInvalidCredentials),
        );
        scaffoldManager.showSnackBar(snackbar);
      }
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.newAccountTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => const ManageAccountsPage(),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 32.0,
        ),
        child: Scrollbar(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _codeController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: const TextInputType.numberWithOptions(),
                    autocorrect: false,
                    validator: (value) {
                      if (value!.length > 6 || value.length < 6) {
                        return l10n.newAccountTwoFactorErrorInvalidCode;
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.newAccountTwoFactorInputCode,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: login,
                        child: Text(l10n.newAccountTwoFactorActionLogin.toUpperCase()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewAccountPage extends StatefulWidget {
  const NewAccountPage({super.key});

  @override
  State<StatefulWidget> createState() => NewAccountPageState();
}

class NewAccountTransferObject {
  final String username;
  final String password;
  final String url;

  NewAccountTransferObject(this.username, this.password, this.url);
}

class NewAccountPageState extends State<NewAccountPage> {
  final _hostController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ScaffoldMessengerState? scaffoldManager;
  NavigatorState? navigator;

  @override
  void dispose() {
    _hostController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void requestTwoFactorCode() async {
    if (_formKey.currentState!.validate()) {
      final l10n = AppLocalizations.of(context);
      final host = _hostController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      final account = await getAccount(host);
      if (account != null && account.email == email) {
        final snackbar = SnackBar(
          content: Text(l10n!.newAccountErrorExists),
        );
        scaffoldManager!.showSnackBar(snackbar);
      } else {
        final success = await JinyaClient(host).requestTwoFactorCode(email, password);
        if (success) {
          final transferObject = NewAccountTransferObject(
            email,
            password,
            host,
          );
          navigator!.push(MaterialPageRoute(
            builder: (context) => NewAccountTwoFactorPage(transferObject),
          ));
        } else {
          final snackbar = SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(l10n!.newAccountErrorInvalidCredentials),
          );
          scaffoldManager!.showSnackBar(snackbar);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    scaffoldManager = ScaffoldMessenger.of(context);
    navigator = Navigator.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.newAccountTitle),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => const ManageAccountsPage(),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 32.0,
        ),
        child: Scrollbar(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _hostController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.url,
                    autocorrect: false,
                    validator: (value) {
                      if (!isURL(
                        value,
                        protocols: ['http', 'https'],
                        requireProtocol: true,
                      )) {
                        return l10n.newAccountErrorInvalidUrl;
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.newAccountInputJinyaHost,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) {
                      if (!isEmail(value!)) {
                        return l10n.newAccountErrorInvalidEmail;
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.newAccountInputEmail,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return l10n.newAccountErrorInvalidPassword;
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.newAccountInputPassword,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: requestTwoFactorCode,
                        child: Text(l10n.newAccountActionTwoFactorCode.toUpperCase()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ManageAccountsPage extends StatefulWidget {
  const ManageAccountsPage({super.key});

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
      drawer: accounts.isEmpty ? null : const JinyaNavigationDrawer(),
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
        tooltip: l10n.menuAddAccount,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NewAccountPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
