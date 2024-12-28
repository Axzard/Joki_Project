import 'package:flutter/material.dart';

class GrafikPenjualan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Laporan Penjualan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with logo and text
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
          SizedBox(height: 20),
          // Sales report graph
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView( // Menambahkan scroll view untuk menghindari overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text "Sales Report Graph"
                    Center(
                      child: Text(
                        'Grafik laporan penjualan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.07, // Ukuran font responsif
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildGrafikContainer(
                      child: _buildGrafikItem(
                        icon: Icons.sports_soccer,
                        percentage: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildGrafikContainer(
                      child: _buildGrafikItem(
                        icon: Icons.shopping_bag,
                        percentage: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildGrafikContainer(
                      child: _buildGrafikItem(
                        icon: Icons.star_border,
                        percentage: 70,
                      ),
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

  Widget _buildGrafikContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(25), // Padding for larger container
      margin: EdgeInsets.symmetric(vertical: 10), // Add vertical margin for spacing
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18), // More rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildGrafikItem({required IconData icon, required int percentage}) {
    return Row(
      children: [
        Icon(icon, size: 80, color: Colors.black), // Increased icon size for better visibility
        SizedBox(width: 25), // Increased space between icon and the progress bar
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Stack(
                children: [
                  // Background of the progress bar
                  Container(
                    height: 50, // Increased height of the bar for better visibility
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  // Progress of the bar
                  Container(
                    height: 50,
                    width: percentage.toDouble() * 2, // Scaling the progress width
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  // Percentage text inside the progress bar, aligned to the left
                  Positioned(
                    left: 8, // Align to the left inside the progress bar
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        '$percentage%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16, // Reduced font size for better fit
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
