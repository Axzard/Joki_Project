import 'package:flutter/material.dart';
import 'package:app_merchandise/user/jersy.dart';
import 'package:app_merchandise/user/syal.dart';
import 'package:app_merchandise/user/aksesoris.dart';

class BelanjaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Belanja',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.06, // Responsif
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: screenWidth * 0.07), // Responsif
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Bagian Logo dan Header
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.02,
              left: screenWidth * 0.05,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Image.asset(
                  'assets/logomalut.jpg',
                  height: screenHeight * 0.2, // Responsif
                ),
                SizedBox(width: screenWidth * 0.04), // Responsif
                // Teks Merchandise
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
          ),
          SizedBox(height: screenHeight * 0.05), // Responsif
          // Bagian Konten
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(screenWidth * 0.05), // Responsif
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05), // Responsif
              child: Column(
                children: [
                  // Baris Ikon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCategoryItem(
                        context: context,
                        icon: Icons.dry_cleaning,
                        label: 'Jersey',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JerseyPage()),
                          );
                        },
                        screenWidth: screenWidth,
                      ),
                      _buildCategoryItem(
                        context: context,
                        icon: Icons.all_inclusive,
                        label: 'Syal',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SyalPage()),
                          );
                        },
                        screenWidth: screenWidth,
                      ),
                      _buildCategoryItem(
                        context: context,
                        icon: Icons.shopping_bag,
                        label: 'Aksesoris',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AksesorisPage()),
                          );
                        },
                        screenWidth: screenWidth,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03), // Responsif
                  // Teks Penjelasan
                  Text(
                    'Temukan dan belanja merchandise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05, // Responsif
                    ),
                  ),
                  Text(
                    'Malut United',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.07, // Responsif
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required BuildContext context,
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
            padding: EdgeInsets.all(screenWidth * 0.04), // Responsif
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              icon,
              color: Colors.red[800],
              size: screenWidth * 0.1, // Responsif
            ),
          ),
          SizedBox(height: screenWidth * 0.02), // Responsif
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.04, // Responsif
            ),
          ),
        ],
      ),
    );
  }
}
