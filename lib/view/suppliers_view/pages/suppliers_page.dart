// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supply_link/model/distributor_model.dart';
import 'package:supply_link/model/supplier_model.dart';
import 'package:supply_link/services/supply_service.dart';
import 'package:supply_link/theme/constants.dart';
import 'package:supply_link/view/suppliers_view/widgets/animated_view_container.dart';
import 'package:supply_link/view_model/app_viewmodel.dart';
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

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _initData();
    });
  }

  initSuppliersAndDistributors(AppViewModel appViewModel) {
    // set the supplier list
    appViewModel.setSuppliersList(SupplyService.suppliers.map((data) {
      return Supplier(
        id: '${SupplyService.suppliers.indexOf(data)}',
        name: data['name'],
        email: data['email'],
        phoneNumber: data['phoneNumber'],
        distributor: Distributor(
          id: data['distributorId'].toString(),
          name: '',
          location: '',
          contactNumber: '',
          suppliers: [],
        ),
      );
    }).toList());
    // set the distributors list
    appViewModel.setDistributorList(SupplyService.distributors.map((data) {
      return Distributor(
        id: '${SupplyService.distributors.indexOf(data)}',
        name: data['name'],
        location: data['location'],
        contactNumber: data['contactNumber'],
        suppliers: [],
      );
    }).toList());
  }

  void _initData() async {
    final appViewModel = ref.read(appStateProvider);
    initSuppliersAndDistributors(appViewModel);

    for (Map<String, dynamic> supplier in SupplyService.suppliers) {
      appViewModel.insertSupplier(supplier);
    }

    for (Map<String, dynamic> distributor in SupplyService.distributors) {
      appViewModel.insertDistributor(distributor);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(gradient: Constant.whiteLinearGradient),
              child: Center(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: ref.read(appStateProvider).getDistributors(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        style: Constant.headline1,
                      );
                    } else {
                      final distributors = snapshot.data!;
                      return ListView.builder(
                        itemCount: distributors.length,
                        itemBuilder: (context, index) {
                          final distributor = distributors[index];
                          return AnimatedViewContainer(
                              viewElement: distributor);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          )),
    );
  }
}
