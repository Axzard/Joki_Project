import 'package:app_merchandise/admin/laporanpenjualan.dart';
import 'package:app_merchandise/admin/daftarmerchendasi.dart';
import 'package:app_merchandise/admin/statuspesanan.dart';
import 'package:flutter/material.dart';


class HomeAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
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
            SizedBox(height: 100),
            // Menu
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 70,left: 5,right: 35),
                decoration: BoxDecoration(
                  color: Colors.red[800],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // Baris 1 Menu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(padding: EdgeInsets.only(right: 10)),
                        _buildMenuItem(
                          icon: Icons.shopping_bag_outlined,
                          label: 'Merchandise',
                          onTap: () {
                            Navigator.push(context,
                             MaterialPageRoute(builder: (context) => Manajemenbelanja()),
                            );
                          },
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        _buildMenuItem(
                          icon: Icons.payments,
                          label: 'Pesanan',
                          onTap: () {
                            Navigator.push(context,
                             MaterialPageRoute(builder: (context) => Statuspesanan(product: {},)),
                            );
                          },
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        _buildMenuItem(
                          icon: Icons.receipt_long,
                          label: 'Laporan',
                          onTap: () {
                           Navigator.push(context,
                             MaterialPageRoute(builder: (context) => GrafikPenjualan()),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
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