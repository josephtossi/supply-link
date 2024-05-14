import 'package:sqlite3/sqlite3.dart';

class DatabaseHelper {
  late Database _db;

  DatabaseHelper() {
    _db = sqlite3.open('supply_link.db');
    _createTables();
  }

  void _createTables() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS suppliers (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        phoneNumber TEXT,
        distributorId INTEGER,
        FOREIGN KEY (distributorId) REFERENCES distributors(id)
      )
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS distributors (
        id INTEGER PRIMARY KEY,
        name TEXT,
        location TEXT,
        contactNumber TEXT
      )
    ''');
  }

  void insertSupplier(Map<String, dynamic> supplier) {
    _db.execute('''
      INSERT INTO suppliers (name, email, phoneNumber, distributorId)
      VALUES (?, ?, ?, ?)
    ''', [
      supplier['name'],
      supplier['email'],
      supplier['phoneNumber'],
      supplier['distributorId']
    ]);
  }

  void insertDistributor(Map<String, dynamic> distributor) {
    _db.execute('''
      INSERT INTO distributors (name, location, contactNumber)
      VALUES (?, ?, ?)
    ''', [
      distributor['name'],
      distributor['location'],
      distributor['contactNumber']
    ]);
  }

  Future<List<Map<String, dynamic>>> getSuppliers() async {
    final List<Map<String, dynamic>> suppliers = [];
    final results = _db.select('SELECT * FROM suppliers');
    for (final result in results) {
      suppliers.add(result);
    }
    return suppliers;
  }

  Future<List<Map<String, dynamic>>> getDistributors() async {
    final List<Map<String, dynamic>> distributors = [];
    final results = _db.select('SELECT * FROM distributors');
    for (final result in results) {
      distributors.add(result);
    }
    return distributors;
  }

  void close() {
    _db.dispose();
  }
}
