import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Model untuk pesanan
class Order {
  final String id;
  final String name;
  final String image; // path file image lokal
  final String price;
  final String size;
  final int quantity;
  final String description;
  final String status; // Status pengiriman
  final String pembayaran; // Status pembayaran

  Order({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.size,
    required this.quantity,
    required this.description,
    required this.status,
    required this.pembayaran,
  });

  // Fungsi untuk membuat instansi Order dari JSON
  factory Order.fromJson(Map<String, dynamic> json, String id) {
    return Order(
      id: id,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] is double
          ? json['price'].toString()
          : json['price'] ?? '0',
      size: json['size'] ?? '',
      quantity: json['quantity'] is double
          ? json['quantity'].toInt()
          : json['quantity'] ?? 0,
      description: json['description'] ?? '',
      status: json['status'] ?? 'belum di antar', // Default status
      pembayaran: json['pembayaran'] ?? 'belum dibayar', // Default pembayaran
    );
  }
}

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<Order> orders = [];

  final String firebaseUrl =
      'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk/pesanan.json';

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  // Fungsi untuk mengambil data pesanan dari Firebase
  Future<void> _fetchOrders() async {
    try {
      final response = await http.get(Uri.parse(firebaseUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data != null) {
          setState(() {
            orders = [];
            data.forEach((key, orderData) {
              orders.add(Order.fromJson(orderData, key));
            });
          });
        }
      } else {
        throw Exception('Gagal memuat pesanan');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Status Pembayaran',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(
                'Tidak ada pesanan',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 4,
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
                                        ? FileImage(File(order
                                            .image)) // Gambar dari file lokal
                                        : AssetImage('assets/placeholder.jpg')
                                            as ImageProvider,
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
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Rp. ${order.price}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Status Pengiriman: ${order.status}',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Pembayaran: ${order.pembayaran}',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
