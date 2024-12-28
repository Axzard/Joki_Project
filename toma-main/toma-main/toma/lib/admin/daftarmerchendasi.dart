import 'package:app_merchandise/admin/aksesoris.dart';
import 'package:app_merchandise/admin/jersey.dart';
import 'package:app_merchandise/admin/syal.dart';
import 'package:flutter/material.dart';

class Manajemenbelanja extends StatelessWidget {
  get allProducts => null;

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Manajemen belanja',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          // Header dengan Logo di Leading dan Teks di Kanan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Sejajarkan ke atas
              children: [
                // Logo dengan ukuran responsif
                Image.asset(
                  'assets/logomalut.jpg',
                  height: screenHeight * 0.3, // Ukuran logo disesuaikan
                ),
                SizedBox(width: 15),
                // Teks Header
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Merchandise',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06, // Ukuran font responsif
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800],
                      ),
                    ),
                    Text(
                      'Malut',
                      style: TextStyle(
                        fontSize: screenWidth * 0.09, // Ukuran font responsif
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800],
                      ),
                    ),
                    Text(
                      'United',
                      style: TextStyle(
                        fontSize: screenWidth * 0.09, // Ukuran font responsif
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          // Menu
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView( // Menambahkan scroll agar tidak overflow
                child: Column(
                  children: [
                    // Baris 1 Menu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMenuItem(
                          icon: Icons.sports_soccer, // Icon jersey atau baju
                          label: 'Jersey',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Jersey()),
                            );
                          },
                        ),
                        _buildMenuItem(
                          icon: Icons.emoji_objects, // Icon syal
                          label: 'Syal',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Syal()),
                            );
                          },
                        ),
                        _buildMenuItem(
                          icon: Icons.star_border, // Icon aksesoris
                          label: 'Aksesoris',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Aksesoris()),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Admin dapat manajemen belanja',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05, // Ukuran font responsif
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Malut United',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.1, // Ukuran font responsif
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              icon,
              color: Colors.red[800],
              size: 40,
            ),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
