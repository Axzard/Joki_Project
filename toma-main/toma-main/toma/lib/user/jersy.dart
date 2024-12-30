import 'package:flutter/material.dart';
import 'package:app_merchandise/model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';  // Import untuk FileImage

class JerseyPage extends StatelessWidget {
  final String firebaseUrl =
      'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk.json';

  // Fungsi untuk mengambil data produk dari Firebase
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(firebaseUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<Product> products = [];

        data.forEach((key, productData) {
          if (key == 'Jersey') { // Menyaring data untuk kategori 'Jersey'
            productData.forEach((id, productDetail) {
              products.add(Product(
                id: id,
                name: productDetail['name'] ?? 'Tidak diketahui',
                image: productDetail['image'] ?? 'path_to_local_image', // Gambar lokal jika ada
                price: productDetail['price'] ?? 'Rp. 0',
                description: productDetail['details'] ?? 'Deskripsi tidak tersedia',
                availableSizes: List<String>.from(productDetail['sizes'] ?? []),
              ));
            });
          }
        });

        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  // Fungsi untuk menyimpan pesanan ke database (POST)
  Future<void> saveToCart(Product product, String size) async {
    try {
      // Membuat data pesanan
      final orderData = {
        'productId': product.id,
        'name': product.name,
        'price': product.price,
        'size': size,
        'quantity': 1, // Anda bisa menambah jumlah produk jika perlu
        'image': product.image,
        'description': product.description,
      };

      // URL Firebase untuk menyimpan pesanan
      final String orderUrl =
          'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk/pesanan.json';  // Pesanan disimpan di bawah kunci 'pesanan'

      // Mengirim data pesanan ke server menggunakan HTTP POST
      final response = await http.post(
        Uri.parse(orderUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(orderData),  // Kirim data pesanan tanpa pembungkus 'order'
      );

      // Cek status response
      if (response.statusCode == 200) {
        print("Pesanan berhasil disimpan.");
      } else {
        throw Exception('Gagal mengirim pesanan.');
      }
    } catch (e) {
      print("Error saving to cart: $e");
      throw Exception('Error saving to cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Menyimpan ukuran yang dipilih
    String? selectedSize;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Belanja Jersey',
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
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada produk tersedia'));
          }

          final List<Product> products = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.05,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logomalut.jpg',
                      height: screenHeight * 0.2, // Responsif
                    ),
                    SizedBox(width: screenWidth * 0.05),
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
                          'Malut United',
                          style: TextStyle(
                            fontSize: screenWidth * 0.09, // Responsif
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.red[800],
                  child: ListView.builder(
                    padding: EdgeInsets.all(screenWidth * 0.04), // Responsif
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      Product product = products[index];

                      return Container(
                        margin: EdgeInsets.only(bottom: screenHeight * 0.02), // Responsif
                        padding: EdgeInsets.all(screenWidth * 0.04), // Responsif
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.03), // Responsif
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Gambar Produk (dengan FileImage atau NetworkImage)
                            Container(
                              width: screenWidth * 0.4, // Responsif
                              height: screenHeight * 0.2, // Responsif
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(screenWidth * 0.02), // Responsif
                                image: DecorationImage(
                                  image: product.image.isNotEmpty
                                      ? FileImage(File(product.image))
                                          as ImageProvider
                                      : AssetImage(
                                          'assets/placeholder.jpg', // Gambar placeholder jika file tidak ada
                                        ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05), // Responsif
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05, // Responsif
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01), // Responsif
                                  Text(
                                    'Rp. ${product.price}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.045, // Responsif
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02), // Responsif
                                  Text(
                                    'Detail:\n${product.description}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035, // Responsif
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02), // Responsif
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.03,
                                        vertical: screenHeight * 0.01,
                                      ), // Responsif
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(screenWidth * 0.02), // Responsif
                                      ),
                                    ),
                                    items: product.availableSizes
                                        .map((size) => DropdownMenuItem(
                                              value: size,
                                              child: Text(size),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      selectedSize = value; // Menyimpan ukuran yang dipilih
                                    },
                                    hint: Text('Pilih ukuran'),
                                  ),
                                  SizedBox(height: screenHeight * 0.02), // Responsif
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      if (selectedSize != null) {
                                        // Menyimpan pesanan langsung ke database menggunakan HTTP POST
                                        saveToCart(product, selectedSize!);

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('${product.name} berhasil dimasukkan ke keranjang!'),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Pilih ukuran terlebih dahulu.'),
                                          ),
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.shopping_cart, size: screenWidth * 0.07, color: Colors.black),
                                    label: Text('Masukkan Keranjang'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[800],
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
