
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_merchandise/model/model.dart';

class KeranjangPage extends StatelessWidget {
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
      body: Consumer<CartModel>(
        builder: (context, cartModel, child) {
          final cartItems = cartModel.cartItems;

          return cartItems.isEmpty
              ? Center(
                  child: Text(
                    'Keranjang kosong',
                    style: TextStyle(fontSize: 24),
                  ),
                )
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    var product = cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
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
                                        image: AssetImage(product.image),
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
                                          product.name,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          product.price as String,
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Detail: ${product.description}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DropdownButton<String>(
                                    value: product.selectedSize,
                                    hint: Text(
                                      'Pilih ukuran',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    items: product.availableSizes.map((size) {
                                      return DropdownMenuItem(
                                        value: size,
                                        child: Text(size),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      cartModel.updateSize(index, value!);
                                    },
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            cartModel.decrementQuantity(index),
                                        icon: Icon(Icons.remove),
                                      ),
                                      Text(
                                        product.quantity.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            cartModel.incrementQuantity(index),
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Hapus Produk'),
                                            content: Text(
                                                'Apakah Anda yakin ingin menghapus produk ini dari keranjang?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Menutup dialog
                                                },
                                                child: Text('Batal'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  cartModel.removeItem(index); // Menghapus item dari keranjang
                                                  Navigator.of(context).pop(); // Menutup dialog
                                                },
                                                child: Text(
                                                  'Hapus',
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[800],
                                    minimumSize: Size(50, 50)),
                                onPressed: () {
                                  // Menampilkan pesan pesanan telah dibuat
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Pesanan Dibuat'),
                                        content: Text('Pesanan Anda telah berhasil dibuat!'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Menutup dialog tanpa mengarahkan ke StatusPage
                                              Navigator.of(context).pop(); // Menutup dialog
                                            },
                                            child: Text('Tutup'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
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
