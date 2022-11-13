import 'package:jinya_cms_api/client/jinya_client.dart';
import 'package:jinya_cms_material_app/data/account_database.dart';

class SettingsDatabase {
  static Account? selectedAccount;

  static JinyaClient getClientForCurrentAccount() {
    return JinyaClient(selectedAccount!.url, apiKey: selectedAccount!.apiKey);
  }
}
