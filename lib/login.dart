import 'package:flutter/material.dart';
import 'package:jinya_cms_api/client/jinya_client.dart';
import 'package:jinya_cms_material_app/data/accountDatabase.dart';
import 'package:jinya_cms_material_app/home.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  void login() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (_formKey.currentState!.validate()) {
      try {
        final apiClient = JinyaClient(SettingsDatabase.selectedAccount!.url);
        final loginResult = await apiClient.login(SettingsDatabase.selectedAccount!.email, _passwordController.text);
        SettingsDatabase.selectedAccount!.apiKey = loginResult.apiKey!;
        SettingsDatabase.selectedAccount!.roles = loginResult.roles!;
        SettingsDatabase.selectedAccount!.deviceToken = loginResult.deviceCode!;
        final currentUser = await apiClient.getArtistInfo();
        SettingsDatabase.selectedAccount!.profilePicture = currentUser.profilePicture!;
        await updateAccount(SettingsDatabase.selectedAccount!);
        navigator.push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      } catch (e) {
        final snackbar = SnackBar(
          content: Text(l10n!.loginInvalidCredentials),
        );
        scaffoldMessenger.showSnackBar(snackbar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(l10n!.loginTitle),
      ),
      drawer: const JinyaNavigationDrawer(),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                readOnly: true,
                initialValue: SettingsDatabase.selectedAccount!.url,
                decoration: InputDecoration(
                  labelText: l10n.loginInstance,
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                readOnly: true,
                initialValue: SettingsDatabase.selectedAccount!.email,
                decoration: InputDecoration(
                  labelText: l10n.loginEmail,
                ),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: l10n.loginPassword,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: login,
                      child: Text(l10n.loginActionLogin.toUpperCase()),
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
