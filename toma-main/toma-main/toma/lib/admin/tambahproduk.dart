import 'package:flutter/material.dart';
import 'dart:io'; // Import untuk File
import 'package:image_picker/image_picker.dart'; // Import untuk ImagePicker

class TambahProdukPage extends StatefulWidget {
  final String kategori; // Menerima kategori sebagai parameter
  TambahProdukPage({required this.kategori}); // Constructor untuk menerima kategori

  @override
  _TambahProdukPageState createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _price;
  late String _details;
  String? _selectedSize;
  File? _image;
  late String _kategori; // Menyimpan kategori yang dipilih

  @override
  void initState() {
    super.initState();
    _kategori = widget.kategori; // Mengambil kategori dari halaman sebelumnya
  }

  // Fungsi untuk memilih gambar menggunakan ImagePicker
  Future<void> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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

  // Fungsi untuk menyimpan data produk
  void saveProduct() {
    if (_formKey.currentState!.validate() && _selectedSize != null && _image != null) {
      final newProduct = {
        'name': _name,
        'price': _price,
        'details': _details,
        'size': _selectedSize!,
        'image': _image,  // Menambahkan gambar produk
        'kategori': _kategori,  // Menyimpan kategori produk
      };
      Navigator.pop(context, newProduct);  // Mengirimkan data produk kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua bidang dan pilih gambar serta ukuran')),
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
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
                validator: (value) => value!.isEmpty ? 'Nama produk tidak boleh kosong' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Harga Produk'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Harga produk tidak boleh kosong' : null,
                onSaved: (value) => _price = double.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Detail Produk'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Detail produk tidak boleh kosong' : null,
                onSaved: (value) => _details = value!,
              ),
              DropdownButtonFormField<String>(
                hint: Text('Pilih Ukuran'),
                items: ['M', 'L', 'XL']
                    .map((size) => DropdownMenuItem(
                          value: size,
                          child: Text(size),
                        ))
                    .toList(),
                onChanged: (value) => _selectedSize = value,
                validator: (value) => value == null ? 'Ukuran harus dipilih' : null,
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
                        fit: BoxFit.cover, // Menyesuaikan gambar agar sesuai tanpa terpotong
                      ),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    saveProduct();
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
