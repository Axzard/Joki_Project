import 'package:flutter/material.dart';

class Statuspesanan extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Header
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
          SizedBox(height: 10),
          // Daftar Produk
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildProdukItem();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProdukItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ikon produk dengan teks di bawahnya
          Row(
            children: [
              Column(
                children: [
                  // Square Container for product icon
                  Container(
                    width: 70, // Width of the square
                    height: 70, // Height of the square
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Background color of the square
                      borderRadius: BorderRadius.circular(10), // Optional, gives rounded corners
                    ),
                    child: Icon(Icons.sports_soccer, size: 40, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Jersey Malut United',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Rp. 200.000',
                    style: TextStyle(
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Kirim',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15),
              // Detail produk
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail:\nJersey di samping merupakan original, tersedia ukuran M, L, dan XL.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    // Input ukuran
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ukuran L',
                        labelStyle: TextStyle(color: Colors.red[800]),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Jumlah produk
                    Row(
                      children: [
                        Icon(Icons.add, size: 18, color: Colors.black),
                        SizedBox(width: 5),
                        Text(
                          'Jumlah 1',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
