import 'package:flutter/material.dart';

class Statuspesanan extends StatefulWidget {
  final Map<String, dynamic> product; // Menerima data produk sebagai parameter

  Statuspesanan({required this.product}); // Konstruktor menerima produk

  @override
  _StatuspesananState createState() => _StatuspesananState();
}

class _StatuspesananState extends State<Statuspesanan> {
  int productQuantity = 1; // Variabel untuk menyimpan jumlah produk
  late double totalPrice; // Variabel untuk menyimpan harga total

  @override
  void initState() {
    super.initState();
    // Inisialisasi harga total jika produk tersedia
    if (widget.product.isNotEmpty) {
      totalPrice = widget.product['price'] * productQuantity.toDouble();
    }
  }

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
          'Kelola Pesanan',
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
          // Daftar Produk atau Pesanan
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  // Periksa apakah ada produk, jika tidak tampilkan pesan "Belum ada pesanan"
                  widget.product.isEmpty
                      ? Center(
                          child: Text(
                            'Belum ada pesanan.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : _buildProdukItem(), // Jika ada produk, tampilkan item
                ],
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
                    child: Image.file(
                      widget.product['image'], 
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.product['name'] ?? 'Nama Produk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Rp. ${widget.product['price']}',
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
                      'Detail: ${widget.product['details'] ?? 'Detail produk tidak tersedia'}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    // Input ukuran
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ukuran ${widget.product['size'] ?? 'L'}',
                        labelStyle: TextStyle(color: Colors.red[800]),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Jumlah produk dan tombol tambah
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, size: 18, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              if (productQuantity > 1) {
                                productQuantity--;
                                totalPrice = widget.product['price'] * productQuantity.toDouble();
                              }
                            });
                          },
                        ),
                        Text(
                          'Jumlah $productQuantity',
                          style: TextStyle(fontSize: 14),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, size: 18, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              productQuantity++;
                              totalPrice = widget.product['price'] * productQuantity.toDouble();
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Harga total
                    Text(
                      'Total: Rp. ${totalPrice.toStringAsFixed(2)}', // Menampilkan harga total
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red[800],
                      ),
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
