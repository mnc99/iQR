import 'package:flutter/material.dart';
import 'package:iqr/screens/scan_qr_screen.dart';
import 'package:iqr/screens/screens.dart';
import 'package:iqr/themes/iqr_themes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Index of the selected item in the bottom navigation bar
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Screens to be displayed in the body of the scaffold
  final List<Widget> _screenOptions = const <Widget>[
    ScanQRScreen(),
    CreateQRScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use IndexedStack to keep the state of the screens
      // Otherwise, the state of the screens will be reset when switching between them
      body: IndexedStack(
        index: _selectedIndex,
        children: _screenOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppThemes.accentColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_rounded),
            label: 'Create',
          ),
        ],
        onTap: _onItemTapped,
      )
    );
  }
}