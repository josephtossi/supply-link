// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supply_link/theme/constants.dart';
import 'package:supply_link/view_model/provider/app_provider.dart';

class SuppliersPage extends ConsumerStatefulWidget {
  const SuppliersPage({
    super.key,
  });

  @override
  _SuppliersPageState createState() => _SuppliersPageState();
}

class _SuppliersPageState extends ConsumerState<SuppliersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<Map<String, dynamic>> suppliers = [
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
  List<Map<String, dynamic>> distributors = [
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

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _initData();
    });
  }

  void _initData() async {
    final appViewModel = ref.read(appStateProvider);
    suppliers.map((supplier) {
      appViewModel.insertSupplier(supplier);
    });
    distributors.map((distributor) {
      appViewModel.insertDistributor(distributor);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Container(
                decoration:
                    BoxDecoration(gradient: Constant.whiteLinearGradient),
                child: Center(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: ref.read(appStateProvider).getDistributors(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final distributors = snapshot.data!;
                        return ListView.builder(
                          itemCount: distributors.length,
                          itemBuilder: (context, index) {
                            final distributor = distributors[index];
                            return ListTile(
                              title: Text(distributor['name']),
                              subtitle: Text(distributor['location']),
                              // You can customize the ListTile as per your requirement
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
