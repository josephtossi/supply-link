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

class ListPage extends ConsumerStatefulWidget {
  List innerElements = [];

  ListPage({
    super.key,
    required this.innerElements,
  });

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.innerElements.isEmpty) {
        _initData();
      }
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

    await Future.forEach(SupplyService.suppliers,
        (Map<String, dynamic> supplier) async {
      int supplierId = await appViewModel.insertSupplier(supplier);
      for (int distributorId in supplier['distributorIds']) {
        appViewModel.linkSupplierToDistributor(supplierId, distributorId);
      }
    });

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
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(gradient: Constant.whiteLinearGradient),
            child: Center(
              child: widget.innerElements.isEmpty
                  ? FutureBuilder<List<Map<String, dynamic>>>(
                      future: ref.read(appStateProvider).getSuppliers(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            style: Constant.headline1,
                          );
                        } else {
                          final suppliers = snapshot.data!;
                          return ListView.builder(
                            itemCount: suppliers.length,
                            itemBuilder: (context, index) {
                              final supplier = suppliers[index];
                              return GestureDetector(
                                onTap: () async {
                                  ref
                                      .read(appStateProvider)
                                      .getDistributorsForSupplier(
                                          supplierId: supplier['id'])
                                      .then((distributors) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListPage(
                                              innerElements: distributors)),
                                    );
                                  });
                                },
                                child: AnimatedViewContainer(
                                    viewElement: supplier),
                              );
                            },
                          );
                        }
                      },
                    )
                  : ListView.builder(
                      itemCount: widget.innerElements.length,
                      itemBuilder: (context, index) {
                        final innerElement = widget.innerElements[index];
                        return AnimatedViewContainer(viewElement: innerElement);
                      },
                    ),
            ),
          ),
        ));
  }
}
