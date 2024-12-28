import 'package:flutter/material.dart';
import 'package:app_merchandise/user/belanja.dart';
import 'package:app_merchandise/user/keranjang.dart';
import 'package:app_merchandise/user/status.dart';

import '../login/login.dart';

class HomeUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Membuka Drawer
            },
          ),
        ),
        title: Text(
          'User Dashboard',
          style: TextStyle(fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold,color: Colors.white), // Responsif
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red[800],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: screenWidth * 0.15, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'User Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_outlined, color: Colors.red[800]),
              title: Text('Belanja', style: TextStyle(fontSize: screenWidth * 0.04)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BelanjaPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart_checkout, color: Colors.red[800]),
              title: Text('Keranjang', style: TextStyle(fontSize: screenWidth * 0.04)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KeranjangPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt_long, color: Colors.red[800]),
              title: Text('Status Pesanan', style: TextStyle(fontSize: screenWidth * 0.04)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatusPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red[800]),
              title: Text('Keluar', style: TextStyle(fontSize: screenWidth * 0.04)),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.05),
            // Header dengan Logo di Leading dan Teks di Kanan
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                children: [
                  // Logo
                  Image.asset(
                    'assets/logomalut.jpg',
                    height: screenHeight * 0.2, // Responsif
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  // Teks Header
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang di Home',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045, // Responsif
                          fontWeight: FontWeight.w500,
                          color: Colors.red[800],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Merchandise',
                            style: TextStyle(
                              fontSize: screenWidth * 0.08, // Responsif
                              fontWeight: FontWeight.bold,
                              color: Colors.red[800],
                            ),
                          ),
                          Text(
                            'Malut',
                            style: TextStyle(
                              fontSize: screenWidth * 0.09, // Responsif
                              fontWeight: FontWeight.bold,
                              color: Colors.red[800],
                            ),
                          ),
                          Text(
                            'United',
                            style: TextStyle(
                              fontSize: screenWidth * 0.1, // Responsif
                              fontWeight: FontWeight.bold,
                              color: Colors.red[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            // Menu
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                decoration: BoxDecoration(
                  color: Colors.red[800],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(screenWidth * 0.05), // Responsif
                  ),
                ),
                child: Column(
                  children: [
                    // Baris 1 Menu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMenuItem(
                          icon: Icons.shopping_bag_outlined,
                          label: 'Belanja',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BelanjaPage()),
                            );
                          },
                          screenWidth: screenWidth,
                        ),
                        _buildMenuItem(
                          icon: Icons.shopping_cart_checkout,
                          label: 'Keranjang',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => KeranjangPage()),
                            );
                          },
                          screenWidth: screenWidth,
                        ),
                        _buildMenuItem(
                          icon: Icons.receipt_long,
                          label: 'Status Pesanan',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StatusPage()),
                            );
                          },
                          screenWidth: screenWidth,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              icon,
              color: Colors.red[800],
              size: screenWidth * 0.1,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.04,
            ),
          ),
        ],
      ),
    );
  }
}
