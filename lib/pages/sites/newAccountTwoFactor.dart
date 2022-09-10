import 'package:flutter/material.dart';
import 'package:jinya_cms_android_app/l10n/localizations.dart';
import 'package:jinya_cms_android_app/pages/sites/manageAccounts.dart';
import 'package:jinya_cms_android_app/pages/sites/newAccount.dart';
import 'package:jinya_cms_android_app/data/accountDatabase.dart';
import 'package:jinya_cms_android_app/network/artist/account.dart' as accountClient;
import 'package:jinya_cms_android_app/network/authentication/login.dart' as loginClient;
import 'package:jinya_cms_android_app/shared/currentUser.dart';

class NewAccountTwoFactorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewAccountTwoFactorPageState();

  final NewAccountTransferObject newAccountTransferObject;

  NewAccountTwoFactorPage(this.newAccountTransferObject);
}

class NewAccountTwoFactorPageState extends State<NewAccountTwoFactorPage> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void login() async {
    if (_formKey.currentState!.validate()) {
      final l10n = AppLocalizations.of(context);
      final navigator = Navigator.of(context);
      final scaffoldManager = ScaffoldMessenger.of(context);
      try {
        final result = await loginClient.login(
          widget.newAccountTransferObject.username,
          widget.newAccountTransferObject.password,
          host: widget.newAccountTransferObject.url,
          twoFactorCode: _codeController.text,
        );

        final account = Account(
          url: widget.newAccountTransferObject.url,
          email: widget.newAccountTransferObject.username,
          apiKey: result.apiKey,
          deviceToken: result.deviceCode,
          profilePicture: '',
          jinyaId: -1,
          name: '',
        );
        SettingsDatabase.selectedAccount = account;
        final currentUser = await accountClient.getAccount();
        account.name = currentUser.artistName;
        account.profilePicture = currentUser.profilePicture;
        account.jinyaId = currentUser.id;
        account.roles = currentUser.roles;

        await createAccount(account);
        navigator.push(MaterialPageRoute(
          builder: (context) => ManageAccountsPage(),
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
              builder: (context) => ManageAccountsPage(),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 32.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: login,
                      child: Text(
                          l10n.newAccountTwoFactorActionLogin.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
