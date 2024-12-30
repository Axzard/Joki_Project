import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http; // Tambahkan http untuk komunikasi dengan Firebase
import 'dart:convert'; // Untuk encoding data JSON

enum ProductSize { S, M, L, XL, XXL }

extension ProductSizeExtension on ProductSize {
  String get name {
    switch (this) {
      case ProductSize.S:
        return 'S';
      case ProductSize.M:
        return 'M';
      case ProductSize.L:
        return 'L';
      case ProductSize.XL:
        return 'XL';
      case ProductSize.XXL:
        return 'XXL';
    }
  }
}

class EditProdukPage extends StatefulWidget {
  final Map<String, dynamic> product;

  EditProdukPage({required this.product});

  @override
  _EditProdukPageState createState() => _EditProdukPageState();
}

class _EditProdukPageState extends State<EditProdukPage> {
  final String firebaseUrl =
      'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk';
  
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController detailsController;
  late ProductSize selectedSize;
  File? _image;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing product data
    nameController = TextEditingController(text: widget.product['name']);
    priceController = TextEditingController(text: widget.product['price'].toString());
    detailsController = TextEditingController(text: widget.product['details']);
    selectedSize = ProductSize.values.firstWhere(
      (e) => e.name == widget.product['size'],
      orElse: () => ProductSize.M,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> updateProductInFirebase(Map<String, dynamic> updatedProduct) async {
    try {
      final String productId = widget.product['id']; // Gunakan ID produk
      final Uri url = Uri.parse('$firebaseUrl/$productId.json'); // Targetkan produk berdasarkan ID

      final response = await http.patch(
        url,
        body: jsonEncode(updatedProduct),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produk berhasil diperbarui!')),
        );
        Navigator.pop(context, updatedProduct);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui produk: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  void saveProduct() {
    final updatedProduct = {
      'name': nameController.text,
      'price': double.parse(priceController.text),
      'details': detailsController.text,
      'size': selectedSize.name,
      'image': _image?.path ?? widget.product['image'], // Simpan gambar baru atau gunakan yang lama
    };

    updateProductInFirebase(updatedProduct); // Simpan ke Firebase
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Edit Produk',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama Produk'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harga'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: detailsController,
              decoration: InputDecoration(labelText: 'Detail Produk'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Ukuran: ', style: TextStyle(fontSize: 16)),
                Expanded(
                  child: DropdownButton<ProductSize>(
                    isExpanded: true,
                    value: selectedSize,
                    onChanged: (ProductSize? newSize) {
                      if (newSize != null) {
                        setState(() {
                          selectedSize = newSize;
                        });
                      }
                    },
                    items: ProductSize.values.map((ProductSize size) {
                      return DropdownMenuItem<ProductSize>(
                        value: size,
                        child: Text(size.name),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: pickImage,
              child: Container(
                width: double.infinity,
                height: 150,
                color: Colors.grey[200],
                child: _image == null
                    ? Center(child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey))
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveProduct,
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800]),
            ),
          ],
        ),
      ),
    );
  }
}
