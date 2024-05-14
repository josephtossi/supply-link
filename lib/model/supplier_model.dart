import 'package:supply_link/model/distributor_model.dart';

class Supplier {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final Distributor distributor;

  Supplier({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.distributor,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      distributor: Distributor.fromJson(json['distributor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'distributor': distributor.toJson(),
    };
  }
}
