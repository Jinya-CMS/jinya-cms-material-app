import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

part 'account_database.g.dart';

@HiveType(typeId: 0)
class Account {
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String apiKey;
  @HiveField(3)
  String deviceToken;
  @HiveField(4)
  String url;
  @HiveField(5)
  String profilePicture;
  @HiveField(6)
  Iterable<String>? roles = [];
  @HiveField(7)
  int jinyaId;

  Account({
    this.roles,
    required this.name,
    required this.email,
    required this.apiKey,
    required this.deviceToken,
    required this.url,
    required this.profilePicture,
    required this.jinyaId,
  });
}

Future<void> createAccount(Account account, {String? password}) async {
  final box = Hive.box<Account>('accounts');
  await box.put(account.url, account);
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  if (password != null) {
    await storage.write(key: account.url, value: password);
  }
}

Future<void> deleteAccount(String url) async {
  final box = Hive.box<Account>('accounts');
  await box.delete(url);
}

Future<void> updateAccount(Account account, String password) async {
  final box = Hive.box<Account>('accounts');
  await box.put(account.url, account);
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  await storage.write(key: account.url, value: password);
}

Future<Account?> getAccount(String url) async {
  final box = Hive.box<Account>('accounts');
  return box.get(url);
}

Future<Iterable<Account>> getAccounts() async {
  final box = Hive.box<Account>('accounts');
  return box.values;
}

Future<int> countAccounts() async {
  final box = Hive.box<Account>('accounts');
  return box.length;
}
