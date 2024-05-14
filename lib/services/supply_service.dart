class SupplyService {
  static List<Map<String, dynamic>> suppliers = [
    {
      'name': 'Supplier 1',
      'email': 'supplier1@email.com',
      'phoneNumber': '1234567890',
      'distributorId': 1,
    },
    {
      'name': 'Supplier 2',
      'email': 'supplier2@email.com',
      'phoneNumber': '0987654321',
      'distributorId': 2,
    }
  ];
  static List<Map<String, dynamic>> distributors = [
    {
      'name': 'Distributor 1',
      'location': 'Location 1',
      'contactNumber': '111222333',
    },
    {
      'name': 'Distributor 2',
      'location': 'Location 2',
      'contactNumber': '444555666',
    }
  ];
}
