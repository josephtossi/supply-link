import 'package:flutter/material.dart';
import 'package:supply_link/helpers/database_helper.dart';
import 'package:supply_link/model/distributor_model.dart';
import 'package:supply_link/model/supplier_model.dart';

class AppViewModel extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;
  List<Supplier> suppliers = [];
  List<Distributor> distributors = [];

  AppViewModel() {
    _databaseHelper = DatabaseHelper();
  }

  void setSuppliersList(List<Supplier> suppliers) {
    this.suppliers = suppliers;
  }

  void setDistributorList(List<Distributor> distributors) {
    this.distributors = distributors;
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
