// ignore_for_file: camel_case_types

import 'package:app/QR/QRscreen.dart';
import 'package:app/mainscreen.dart/home.dart';
import 'package:app/profile/profile.dart';
import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => dashboardState();
}

class dashboardState extends State<dashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Profile(
      name: '',
      email: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: _currentIndex == 2
          ? FloatingActionButton(
              elevation: 10,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => QRScanScreen()));
              },
              child: const Icon(Icons.qr_code_scanner),
            )
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => QRScanScreen()));
              },
              child: const Icon(Icons.qr_code_scanner),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
