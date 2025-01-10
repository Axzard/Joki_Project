import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';  // Untuk menggunakan FileImage

// Model untuk pesanan
class Order {
  final String id;
  final String name;
  final String image; // path file image lokal
  final String price;
  final String size;
  final int quantity;
  final String description;

  Order({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.size,
    required this.quantity,
    required this.description,
  });

  // Fungsi untuk membuat instansi Order dari JSON
  factory Order.fromJson(Map<String, dynamic> json, String id) {
    return Order(
      id: id,
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: json['price'] != null ? json['price'].toString() : '0',
      size: json['size']?.toString() ?? '',
      quantity: json['quantity'] is int ? json['quantity'] : (json['quantity'] is double ? json['quantity'].toInt() : 0),
      description: json['description']?.toString() ?? '',
    );
  }
}

class KeranjangPage extends StatelessWidget {
  final String firebaseUrl =
      'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk/pesanan.json';

  // Fungsi untuk mengambil daftar pesanan dari Firebase
  Future<List<Order>> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse(firebaseUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = jsonDecode(response.body);

        // Cek apakah data kosong atau null
        if (data == null || data.isEmpty) {
          return [];
        }

        final List<Order> orders = [];
        // Periksa apakah data berupa map yang valid dan bukan null
        data.forEach((key, orderData) {
          if (orderData != null) {
            orders.add(Order.fromJson(orderData, key));
          }
        });
        return orders;
      } else {
        throw Exception('Gagal memuat pesanan');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }

  // Fungsi untuk menghapus pesanan
  Future<void> deleteOrder(String id) async {
    final url =
        'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk/pesanan/$id.json';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Gagal menghapus pesanan');
      }
    } catch (e) {
      throw Exception('Error deleting order: $e');
    }
  }

  // Fungsi untuk memperbarui status pembayaran pesanan
  Future<void> updatePaymentStatus(String orderId) async {
    final url =
        'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk/pesanan/$orderId.json';

    try {
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode({
          'pembayaran': 'telah dibayar', // Menambahkan status pembayaran
        }),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Gagal memperbarui status pembayaran');
      }
    } catch (e) {
      throw Exception('Error updating payment status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Keranjang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Order>>(
        future: fetchOrders(), // Ambil data pesanan dari Firebase
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada pesanan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
          }

          final List<Order> orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Order order = orders[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: order.image.isNotEmpty
                                      ? FileImage(File(order.image)) // Gambar dari file lokal
                                      : AssetImage('assets/placeholder.jpg') as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.name,
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Rp. ${order.price}',
                                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Detail: ${order.description}',
                          style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Ukuran: ${order.size}',
                          style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Jumlah: ${order.quantity}', style: TextStyle(fontSize: 20)),
                            IconButton(
                              onPressed: () async {
                                bool confirm = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Konfirmasi'),
                                      content: Text('Apakah Anda yakin ingin menghapus pesanan ini?'),
                                      actions: [
                                        TextButton(
                                          child: Text('Batal'),
                                          onPressed: () => Navigator.of(context).pop(false),
                                        ),
                                        TextButton(
                                          child: Text('Hapus'),
                                          onPressed: () => Navigator.of(context).pop(true),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm) {
                                  try {
                                    await deleteOrder(order.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Pesanan berhasil dihapus')),
                                    );
                                    // ignore: invalid_use_of_protected_member
                                    (context as Element).reassemble();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Gagal menghapus pesanan: $e')),
                                    );
                                  }
                                }
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[800], minimumSize: Size(50, 50)),
                          onPressed: () async {
                            try {
                              await updatePaymentStatus(order.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Pembayaran berhasil dilakukan')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Gagal memperbarui status pembayaran: $e')),
                              );
                            }
                          },
                          child: Text(
                            'Bayar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
