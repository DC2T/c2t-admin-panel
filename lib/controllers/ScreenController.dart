import 'package:admin/screens/catalog/catalog_page.dart';
import 'package:admin/screens/default/default.dart';
import 'package:admin/screens/form/modifier_page.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class ScreenController extends ChangeNotifier {
  StatefulWidget _screen = DashboardScreen();
  StatefulWidget get screen => _screen;

  void controlScreen({screenName = 'Dashboard', modifier: 'Movie', data}) {
    print(screenName);
    switch (screenName) {
      case 'Dashboard':
        _screen = DashboardScreen();
        break;
      case 'Modifier':
        _screen = ModifierPage(tabName: modifier, data: data,);
        break;
      case 'Catalog':
        _screen = CatalogPage();
        break;
      default:
        _screen = DefaultPage();
        break;
    }
    notifyListeners();
  }
}
