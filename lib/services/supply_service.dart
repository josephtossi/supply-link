class SupplyService {
  static List<Map<String, dynamic>> suppliers = [
    {
      'name': 'Alibaba',
      'email': 'supplier1@email.com',
      'phoneNumber': '1234567890',
      'distributorIds': [1, 2],
    },
    {
      'name': 'Amazon Business',
      'email': 'supplier2@email.com',
      'phoneNumber': '0987654321',
      'distributorIds': [2, 3],
    },
    {
      'name': 'Costco Wholesale',
      'email': 'supplier3@email.com',
      'phoneNumber': '098763111',
      'distributorIds': [1, 3],
    }
  ];

  static List<Map<String, dynamic>> distributors = [
    {
      'id': 1,
      'name': 'Tiajin 1',
      'location': 'Location 1',
      'contactNumber': '111222333',
    },
    {
      'id': 2,
      'name': 'Ningbo 2',
      'location': 'Location 2',
      'contactNumber': '444555666',
    },
    {
      'id': 3,
      'name': 'Liaocheng 2',
      'location': 'Location 3',
      'contactNumber': '32313141',
    },
  ];
}
