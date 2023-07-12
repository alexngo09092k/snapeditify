import 'package:flutter/material.dart';
import 'package:qr_scanner/models/home_navigation.dart';
import 'package:qr_scanner/pages/generate/generate_page.dart';
import 'package:qr_scanner/pages/history/history_page.dart';
import 'package:qr_scanner/pages/home/widgets/home_bottom_navigation.dart';
import 'package:qr_scanner/pages/scanner/scanner_page.dart';
import 'package:qr_scanner/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeNavigation _navigation = HomeNavigation.scan;
  static const Map<HomeNavigation, Widget> _pages = {
    HomeNavigation.scan: ScannerPage(),
    HomeNavigation.generate: GeneratePage(),
    HomeNavigation.history: HistoryPage(),
    HomeNavigation.settings: SettingsPage(),
  };

  void _onItemTapped(HomeNavigation _) {
    setState(() {
      _navigation = _;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_navigation],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeBottomNavigation(
        navigation: _navigation,
        onChange: _onItemTapped,
      ),
    );
  }
}
