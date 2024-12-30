import 'package:flutter/material.dart';
import 'dart:io'; // Import untuk File
import 'package:image_picker/image_picker.dart'; // Import untuk ImagePicker
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk encoding data JSON

// Definisi enum untuk kategori produk
enum KategoriProduk { Jersey, Syal, Aksesoris }

extension KategoriProdukExtension on KategoriProduk {
  String get name {
    switch (this) {
      case KategoriProduk.Jersey:
        return 'Jersey';
      case KategoriProduk.Syal:
        return 'Syal';
      case KategoriProduk.Aksesoris:
        return 'Aksesoris';
    }
  }
}

class TambahProdukPage extends StatefulWidget {
  TambahProdukPage(String s);

  @override
  _TambahProdukPageState createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _price;
  late String _details;
  List<String> _sizes = []; // Menyimpan daftar ukuran
  File? _image;
  KategoriProduk? _selectedCategory;
  final String firebaseUrl =
      'https://merchendaise-84b8d-default-rtdb.firebaseio.com/admin/pengguna/produk';
  final TextEditingController _sizeController = TextEditingController();

  // Fungsi untuk memilih gambar menggunakan ImagePicker
  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tidak ada gambar yang dipilih')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memilih gambar: $e')),
      );
    }
  }

  // Fungsi untuk menambahkan ukuran baru
  void addSize() {
    if (_sizeController.text.isNotEmpty) {
      setState(() {
        _sizes.add(_sizeController.text);
      });
      _sizeController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ukuran tidak boleh kosong')),
      );
    }
  }

  // Fungsi untuk menyimpan data produk ke Firebase
  Future<void> saveProductToFirebase(Map<String, dynamic> productData) async {
    try {
      final url = Uri.parse('$firebaseUrl/${_selectedCategory!.name}.json');
      final response = await http.post(
        url,
        body: jsonEncode(productData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produk berhasil disimpan!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan produk: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  void saveProduct() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      _formKey.currentState!.save();

      final newProduct = {
        'name': _name,
        'price': _price,
        'details': _details,
        'sizes': _sizes, // Daftar ukuran
        'image': _image?.path ?? '', // Simpan path gambar lokal untuk contoh
        'kategori': _selectedCategory!.name,
      };

      saveProductToFirebase(newProduct); // Kirim data ke Firebase
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Harap isi semua bidang, pilih gambar, dan kategori')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Belanja',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Produk'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama produk tidak boleh kosong' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Harga Produk'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Harga produk tidak boleh kosong' : null,
                onSaved: (value) => _price = double.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Detail Produk'),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Detail produk tidak boleh kosong' : null,
                onSaved: (value) => _details = value!,
              ),
              TextFormField(
                controller: _sizeController,
                decoration: InputDecoration(
                  labelText: 'Tambahkan Ukuran',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: addSize,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: _sizes
                    .map((size) => Chip(
                          label: Text(size),
                          onDeleted: () {
                            setState(() {
                              _sizes.remove(size);
                            });
                          },
                        ))
                    .toList(),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<KategoriProduk>(
                hint: Text('Pilih Kategori'),
                items: KategoriProduk.values
                    .map((kategori) => DropdownMenuItem(
                          value: kategori,
                          child: Text(kategori.name),
                        ))
                    .toList(),
                onChanged: (value) => _selectedCategory = value,
                validator: (value) =>
                    value == null ? 'Kategori harus dipilih' : null,
              ),
              SizedBox(height: 10),
              _image == null
                  ? TextButton.icon(
                      onPressed: pickImage,
                      icon: Icon(Icons.image),
                      label: Text('Pilih Gambar'),
                    )
                  : Center(
                      child: Image.file(
                        _image!,
                        height: 250,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveProduct,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
