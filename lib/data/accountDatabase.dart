import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'accounts.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE accounts(id INTEGER PRIMARY KEY, jinyaId INT, url TEXT UNIQUE, name TEXT, email TEXT, apiKey TEXT, deviceToken TEXT)',
      );
    },
    version: 1,
  );
}

class Account {
  int id;
  String name;
  String email;
  String apiKey;
  String deviceToken;
  String url;
  int jinyaId;

  Account({
    required this.id,
    required this.name,
    required this.email,
    required this.apiKey,
    required this.deviceToken,
    required this.url,
    required this.jinyaId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'jinyaId': this.jinyaId,
      'name': this.name,
      'email': this.email,
      'url': this.url,
      'apiKey': this.apiKey,
      'deviceToken': this.deviceToken,
    };
  }

  static Account fromMap(Map<String, dynamic> map) {
    return Account(
      email: map['email'],
      apiKey: map['apiKey'],
      id: map['id'],
      jinyaId: map['jinyaId'],
      name: map['name'],
      url: map['url'],
      deviceToken: map['deviceToken'],
    );
  }
}

Future<void> createAccount(Account account) async {
  final db = await getDatabase();
  await db.insert('accounts', account.toMap());
}

Future<void> deleteAccount(int id) async {
  final db = await getDatabase();
  await db.delete(
    'accounts',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> updateAccount(int id, Account account) async {
  final db = await getDatabase();
  await db.update(
    'accounts',
    account.toMap(),
    where: 'id = ?',
    whereArgs: [id],
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<Account?> getAccount(int id) async {
  final db = await getDatabase();
  final data = await db.query(
    'accounts',
    where: 'id = ?',
    whereArgs: [id],
  );

  if (data.isNotEmpty) {
    return Account.fromMap(data.first);
  }

  return null;
}

Future<List<Account>> getAccounts() async {
  final db = await getDatabase();
  final data = await db.query('accounts');

  return List.generate(data.length, (i) => Account.fromMap(data[i]));
}

Future<int> countAccounts() async {
  final db = await getDatabase();
  var x = await db.rawQuery('SELECT COUNT (*) FROM accounts');
  return Sqflite.firstIntValue(x) ?? 0;
}

Future<Account?> getAccountByUrl(String url) async {
  final db = await getDatabase();
  final data = await db.query(
    'accounts',
    where: 'url = ?',
    whereArgs: [url],
  );

  if (data.isNotEmpty) {
    return Account.fromMap(data.first);
  }

  return null;
}
