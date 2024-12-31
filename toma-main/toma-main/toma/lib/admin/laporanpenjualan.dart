import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GrafikPenjualan extends StatefulWidget {
  @override
  _GrafikPenjualanState createState() => _GrafikPenjualanState();
}

class _GrafikPenjualanState extends State<GrafikPenjualan> {
  // Variabel untuk menyimpan jumlah pesanan produk
  Map<String, int> produkPesanan = {
    'Jersey': 0,
    'Syal': 0,
    'Aksesoris': 0,
  };

  @override
  void initState() {
    super.initState();
    _fetchData(); // Ambil data pesanan saat halaman dimuat
  }

  // Mengambil data dari Firebase Realtime Database
 Future<void> _fetchData() async {
  final url = 'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk/pesanan.json';

  try {
    // Meminta data dari Firebase
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Mengubah data JSON menjadi Map
      final data = json.decode(response.body);

      print('Data yang diterima: $data');  // Menambahkan log untuk melihat data yang diterima

      // Pastikan data tidak null atau kosong
      if (data != null && data is Map) {
        // Hitung jumlah pesanan berdasarkan kategori
        final Map<String, int> pesananBaru = {
          'Jersey': 0,
          'Syal': 0,
          'Aksesoris': 0,
        };

        // Menyaring dan menghitung jumlah pesanan berdasarkan kategori
        data.forEach((key, value) {
          final nama = value['category'];  // Mengambil kategori dari data pesanan
          final jumlah = value['quantity'];  // Mengambil jumlah pesanan produk

          if (nama != null && jumlah != null && pesananBaru.containsKey(nama)) {
            pesananBaru[nama] = pesananBaru[nama]! + (jumlah as int);  // Menambahkan jumlah pesanan sesuai kategori
          }
        });

        // Perbarui data pesanan di UI
        setState(() {
          produkPesanan = pesananBaru;
        });
      } else {
        print('Data tidak dalam format yang diharapkan: $data');
        throw Exception('Data tidak valid');
      }
    } else {
      print('Gagal memuat data: ${response.statusCode}');
      throw Exception('Gagal memuat data');
    }
  } catch (error) {
    print('Error: $error');
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/logomalut.jpg',
                  height: screenHeight * 0.3,
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Merchandise',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800],
                      ),
                    ),
                    Text(
                      'Malut',
                      style: TextStyle(
                        fontSize: screenWidth * 0.09,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800],
                      ),
                    ),
                    Text(
                      'United',
                      style: TextStyle(
                        fontSize: screenWidth * 0.09,
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
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Grafik laporan penjualan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildGrafikContainer(
                      child: _buildGrafikItem(
                        icon: Icons.sports_soccer,
                        percentage: produkPesanan['Jersey'] ?? 0,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildGrafikContainer(
                      child: _buildGrafikItem(
                        icon: Icons.shopping_bag,
                        percentage: produkPesanan['Syal'] ?? 0,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildGrafikContainer(
                      child: _buildGrafikItem(
                        icon: Icons.star_border,
                        percentage: produkPesanan['Aksesoris'] ?? 0,
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
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
        Icon(icon, size: 80, color: Colors.black),
        SizedBox(width: 25),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Stack(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: percentage.toDouble() * 2, // Mengubah ukuran berdasarkan persentase
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        '$percentage', // Menampilkan jumlah pesanan
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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
