import 'package:flutter/material.dart';
import 'package:jinya_cms_api/client/jinya_client.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/pages/sites/manage_accounts.dart';
import 'package:jinya_cms_material_app/pages/sites/new_account.dart';
import 'package:jinya_cms_material_app/data/accountDatabase.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';

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
