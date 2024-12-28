import 'package:app_merchandise/admin/statuspesanan.dart';
import 'package:flutter/material.dart';
import 'editproduk.dart';  // Import halaman Edit Produk
import 'tambahproduk.dart'; // Import halaman Tambah Produk

class Jersey extends StatefulWidget {
  @override
  _JerseyState createState() => _JerseyState();
}

class _JerseyState extends State<Jersey> {
  List<Map<String, dynamic>> products = []; // Daftar produk

  // Fungsi untuk menambah produk
  void addProduct(Map<String, dynamic> newProduct) {
    setState(() {
      products.add(newProduct); // Menambahkan produk baru ke list
    });
  }

  // Fungsi untuk mengedit produk
  void editProduct(Map<String, dynamic> updatedProduct, int index) {
    setState(() {
      products[index] = updatedProduct; // Memperbarui produk pada index yang sesuai
    });
  }

  // Fungsi untuk menghapus produk
  void deleteProduct(Map<String, dynamic> product) {
    setState(() {
      products.removeWhere((prod) => prod['name'] == product['name']); // Menghapus produk berdasarkan nama
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Keleolah Baju Jersy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/logomalut.jpg',
                      height: 230,
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Merchandise', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color:Colors.red)),
                        Text('Malut', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color:Colors.red)),
                        Text('United', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color:Colors.red)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Daftar produk
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red[800],
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: products.isEmpty
                      ? Center(child: Text('Belum ada produk.', style: TextStyle(color: Colors.white,fontSize: 16)))
                      : ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: ProductCard(
                                product: products[index],
                                onDelete: deleteProduct,
                                onEdit: () async {
                                  // Mengedit produk dan mengembalikan produk yang sudah diperbarui
                                  final updatedProduct = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProdukPage(product: products[index]),
                                    ),
                                  );

                                  if (updatedProduct != null) {
                                    // Update produk jika ada perubahan
                                    editProduct(updatedProduct, index);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                final newProduct = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TambahProdukPage(kategori: 'Jersey'),
                  ),
                );

                if (newProduct != null) {
                  addProduct(newProduct); // Menambahkan produk baru
                }
              },
              label: Text('Tambah Produk', style: TextStyle(color: Colors.red)),
              icon: Icon(Icons.add, color: Colors.red),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onDelete;
  final Function() onEdit;

  ProductCard({
    required this.product,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red.shade200, width: 2),
                  color: Colors.red.shade50,
                ),
                child: product['image'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(product['image'], 
                        height: 250,
                        width: 200,
                        fit: BoxFit.cover),
                      )
                    : Icon(Icons.image, size: 50, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                product['name'] ?? 'Nama Produk',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
              ),
              SizedBox(height: 4),
              Text(
                'Rp. ${product['price'].toStringAsFixed(2)}', // Menampilkan harga sebagai double
                style: TextStyle(fontSize: 12, color: Colors.grey[800]),
              ),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail: ${product['details'] ?? 'Detail produk tidak tersedia'}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                SizedBox(height: 8),
                Text(
                  'Ukuran: ${product['size'] ?? 'M, L, XL'}',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart, color: Colors.white, size: 16),
                            SizedBox(width: 8),
                            Flexible(
                              child: TextButton(
                                onPressed: () {
                                  // Navigate to Statuspesanan and pass the product data
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Statuspesanan(
                                        product: product, // Passing the product data
                                      ),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  textStyle: TextStyle(fontSize: 14),
                                ),
                                child: Text(
                                  'Masukkan keranjang',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.grey, size: 20),
                          onPressed: onEdit,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 20),
                          onPressed: () {
                            onDelete(product);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
