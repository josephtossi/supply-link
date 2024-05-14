import 'package:flutter/material.dart';
import 'package:supply_link/helpers/database_helper.dart';

class AppViewModel extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;

  AppViewModel() {
    _databaseHelper = DatabaseHelper();
  }

  void insertSupplier(Map<String, dynamic> supplier) {
    _databaseHelper.insertSupplier(supplier);
  }

  void insertDistributor(Map<String, dynamic> distributor) {
    _databaseHelper.insertDistributor(distributor);
  }

  Future<List<Map<String, dynamic>>> getSuppliers() async {
    return await _databaseHelper.getSuppliers();
  }

  Future<List<Map<String, dynamic>>> getDistributors() async {
    return await _databaseHelper.getDistributors();
  }

  @override
  void dispose() {
    _databaseHelper.close();
    super.dispose();
  }
}
