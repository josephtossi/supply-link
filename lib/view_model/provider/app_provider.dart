import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supply_link/view_model/app_viewmodel.dart';

final ChangeNotifierProvider<AppViewModel> appStateProvider =
    ChangeNotifierProvider<AppViewModel>(
        (ChangeNotifierProviderRef<AppViewModel> ref) {
  return AppViewModel();
});
