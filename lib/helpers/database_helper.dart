import 'package:sqlite3/sqlite3.dart';

class DatabaseHelper {
  final Database _db = sqlite3.openInMemory();

  DatabaseHelper() {
    try {
      _initializeDatabase();
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  Future<void> _initializeDatabase() async {
    try {
      _createTables();
    } catch (e) {
      rethrow;
    }
  }

  void _createTables() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS suppliers (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        phoneNumber TEXT
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

    _db.execute('''
      CREATE TABLE IF NOT EXISTS supplier_distributor (
        id INTEGER PRIMARY KEY,
        supplierId INTEGER,
        distributorId INTEGER,
        FOREIGN KEY (supplierId) REFERENCES suppliers(id),
        FOREIGN KEY (distributorId) REFERENCES distributors(id)
      )
    ''');
  }

  Future<int> insertSupplier(Map<String, dynamic> supplier) async {
    try {
      _db.execute('''
        INSERT INTO suppliers (name, email, phoneNumber)
        VALUES (?, ?, ?)
      ''', [
        supplier['name'],
        supplier['email'],
        supplier['phoneNumber'],
      ]);

      final result = _db.select('SELECT last_insert_rowid()');
      final insertedId = result.first.values.first as int;
      return insertedId;
    } catch (e) {
      print('Error inserting supplier: $e');
      return -1;
    }
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

  void linkSupplierToDistributor(int supplierId, int distributorId) {
    _db.execute('''
      INSERT INTO supplier_distributor (supplierId, distributorId)
      VALUES (?, ?)
    ''', [supplierId, distributorId]);
  }

  void unlinkSupplierFromDistributor(int supplierId, int distributorId) {
    _db.execute('''
      DELETE FROM supplier_distributor 
      WHERE supplierId = ? AND distributorId = ?
    ''', [supplierId, distributorId]);
  }

  Future<List<Map<String, dynamic>>> getSuppliers() async {
    final List<Map<String, dynamic>> suppliers = [];
    final results = await _db.select('SELECT * FROM suppliers');
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

  Future<List<Map<String, dynamic>>> getDistributorsForSupplier(
      int supplierId) async {
    final List<Map<String, dynamic>> distributors = [];
    final results = _db.select(
      '''
      SELECT d.*
      FROM distributors d
      INNER JOIN supplier_distributor sd ON d.id = sd.distributorId
      WHERE sd.supplierId = ?
      ''',
      [supplierId],
    );
    for (final result in results) {
      distributors.add(result);
    }
    return distributors;
  }

  void close() {
    _db.dispose();
  }
}
