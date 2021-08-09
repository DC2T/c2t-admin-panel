import 'package:admin/screens/default/default.dart';
import 'package:admin/screens/form/movie_form_page.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class ScreenController extends ChangeNotifier {
  StatefulWidget _screen = DashboardScreen();
  StatefulWidget get screen => _screen;

  void controlScreen({screenName = 'Dashboard'}) {
    print(screenName);
    switch (screenName) {
      case 'Dashboard':
        _screen = DashboardScreen();
        break;
      case 'Modifier':
        _screen = MovieFormPage();
        break;
      default:
        _screen = DefaultPage();
        break;
    }
    notifyListeners();
  }
}
