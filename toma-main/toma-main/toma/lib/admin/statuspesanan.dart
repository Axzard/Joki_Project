import 'dart:convert';
import 'dart:io'; // Untuk Image.file
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Statuspesanan extends StatefulWidget {
  final String userId; // ID pengguna yang pesannya ingin kita tampilkan

  Statuspesanan({required this.userId, required Map product}); // Konstruktor untuk ID pengguna

  @override
  _StatuspesananState createState() => _StatuspesananState();
}

class _StatuspesananState extends State<Statuspesanan> {
  List<Map<String, dynamic>> productList = []; // List untuk menyimpan data produk
  bool isLoading = true; // Status untuk menunggu data
  Map<String, int> productQuantity = {}; // Menyimpan jumlah produk yang dipesan

  @override
  void initState() {
    super.initState();
    _fetchOrders(); // Ambil data pesanan ketika halaman dimuat
  }

  Future<void> _fetchOrders() async {
    try {
      final url = 'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk/pesanan.json';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Mengambil produk dari response
        List<Map<String, dynamic>> loadedProducts = [];
        data.forEach((key, value) {
          loadedProducts.add({
            'id': key,
            'name': value['name'],
            'price': value['price'],
            'details': value['details'],
            'sizes': value['sizes'],
            'image': value['image'],  // Path gambar tetap diterima
          });
        });

        setState(() {
          productList = loadedProducts;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        // Menangani error jika gagal mendapatkan data
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat data pesanan!')),
        );
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    }
  }

  void _incrementQuantity(String productId) {
    setState(() {
      productQuantity[productId] = (productQuantity[productId] ?? 1) + 1;
    });
  }

  void _decrementQuantity(String productId) {
    setState(() {
      if ((productQuantity[productId] ?? 1) > 1) {
        productQuantity[productId] = (productQuantity[productId] ?? 1) - 1;
      }
    });
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
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Menampilkan loading spinner
          : Column(
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
                    child: ListView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: productList.length,
                      itemBuilder: (ctx, index) {
                        return _buildProdukItem(productList[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProdukItem(Map<String, dynamic> product) {
    String productId = product['id'];
    int quantity = productQuantity[productId] ?? 1;

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
                      File(product['image']), // Ganti Image.network dengan Image.file
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    product['name'] ?? 'Nama Produk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Rp. ${product['price']}',
                    style: TextStyle(
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () async {
                      // Ketika tombol "Kirim" ditekan, kirim data ke Firebase dengan status "dikirim"
                      await _updateStatusToSent(productId);
                    },
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
                      'Detail: ${product['details'] ?? 'Detail produk tidak tersedia'}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    // Input ukuran
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ukuran ${product['sizes']?.first ?? 'L'}',
                        labelStyle: TextStyle(color: Colors.red[800]),
                        isDense: true,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Menampilkan jumlah produk dalam format tetap
                    Text(
                      'Jumlah: 1', // Mengganti dengan jumlah statis "1"
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    // Harga total
                    Text(
                      'Total: Rp. ${product['price']}', // Menghitung total harga
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

  // Fungsi untuk memperbarui status produk menjadi "dikirim" di Firebase
  Future<void> _updateStatusToSent(String productId) async {
    final url = 'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk/pesanan/$productId.json';

    try {
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode({
          'status': 'dikirim', // Menambahkan status "dikirim"
        }),
      );

      if (response.statusCode == 200) {
        // Jika berhasil, tampilkan snackbar atau beri feedback pada user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pesanan berhasil dikirim!')),
        );
      } else {
        // Jika gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui status pesanan!')),
        );
      }
    } catch (error) {
      // Menangani kesalahan saat koneksi atau permintaan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    }
  }
}
