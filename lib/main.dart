import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supply_link/view/suppliers_view/pages/list_page.dart';

void main() => runApp(
      ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ListPage(
            innerElements: const [],
          ),
        ),
      ),
    );
