import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jinya_cms_api/client/jinya_client.dart';
import 'package:jinya_cms_material_app/data/account_database.dart';
import 'package:jinya_cms_material_app/home.dart';
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _localAuth = LocalAuthentication();
  bool canCheckBiometrics = false;

  void login() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (_formKey.currentState!.validate()) {
      try {
        final apiClient = JinyaClient(SettingsDatabase.selectedAccount!.url);
        final loginResult = await apiClient.login(
            SettingsDatabase.selectedAccount!.email, _passwordController.text,
            deviceCode: SettingsDatabase.selectedAccount!.deviceToken);
        SettingsDatabase.selectedAccount!.apiKey = loginResult.apiKey!;
        SettingsDatabase.selectedAccount!.roles =
            loginResult.roles!.toList().cast<String>();
        SettingsDatabase.selectedAccount!.deviceToken = loginResult.deviceCode!;
        final currentUser =
            await SettingsDatabase.getClientForCurrentAccount().getArtistInfo();
        SettingsDatabase.selectedAccount!.profilePicture =
            currentUser.profilePicture!;
        await updateAccount(
            SettingsDatabase.selectedAccount!, _passwordController.text);
        navigator.pushReplacement(MaterialPageRoute(
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

  void checkBiometrics() async {
    final l10n = AppLocalizations.of(context);
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
    if (await storage.containsKey(key: SettingsDatabase.selectedAccount!.url) &&
        await _localAuth.authenticate(
          localizedReason: l10n!.loginBiometric,
          options: const AuthenticationOptions(
            biometricOnly: true,
            sensitiveTransaction: true,
            stickyAuth: true,
          ),
        )) {
      _passwordController.text =
          (await storage.read(key: SettingsDatabase.selectedAccount!.url))!;
      login();
    }
  }

  @override
  void initState() {
    super.initState();
    setCanCheckBiometrics();
  }

  void setCanCheckBiometrics() async {
    setState(() async {
      canCheckBiometrics = await _localAuth.canCheckBiometrics;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final buttons = <Widget>[];

    if (canCheckBiometrics) {
      buttons.add(
        ElevatedButton(
          onPressed: checkBiometrics,
          child: Text(l10n.loginActionBiometric.toUpperCase()),
        ),
      );
    }
    buttons.add(
      ElevatedButton(
        onPressed: login,
        child: Text(l10n.loginActionLogin.toUpperCase()),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(l10n.loginTitle),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  readOnly: true,
                  initialValue: SettingsDatabase.selectedAccount!.url,
                  decoration: InputDecoration(
                    labelText: l10n.loginInstance,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  readOnly: true,
                  initialValue: SettingsDatabase.selectedAccount!.email,
                  decoration: InputDecoration(
                    labelText: l10n.loginEmail,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: l10n.loginPassword,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buttons,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
