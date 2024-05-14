import 'package:supply_link/model/supplier_model.dart';

class Distributor {
  final String id;
  final String name;
  final String location;
  final String contactNumber;
  final List<Supplier> suppliers;

  Distributor({
    required this.id,
    required this.name,
    required this.location,
    required this.contactNumber,
    required this.suppliers,
  });

  factory Distributor.fromJson(Map<String, dynamic> json) {
    return Distributor(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      contactNumber: json['contactNumber'],
      suppliers: List<Supplier>.from((json['suppliers'] ?? [])
          .map((element) => Supplier.fromJson(element))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'contactNumber': contactNumber,
      'suppliers': suppliers.map((supplier) => supplier.toJson()).toList(),
    };
  }
}
