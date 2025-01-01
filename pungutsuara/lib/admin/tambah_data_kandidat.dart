import 'package:flutter/material.dart';

class TambahDataKandidat extends StatelessWidget {
  final Function(Map<String, String>) onAddKandidat;

  TambahDataKandidat({super.key, required this.onAddKandidat});

  final TextEditingController noUrutController = TextEditingController();
  final TextEditingController namaKetuaController = TextEditingController();
  final TextEditingController namaWakilController = TextEditingController();
  final TextEditingController namaPartaiController = TextEditingController();
  final TextEditingController visiMisiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF001A6E),
        title: const Text(
          'Tambah Data Kandidat',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            CustomTextField(controller: noUrutController, hintText: 'No Urut'),
            const SizedBox(height: 15),
            CustomTextField(controller: namaKetuaController, hintText: 'Nama Ketua Kandidat'),
            const SizedBox(height: 15),
            CustomTextField(controller: namaWakilController, hintText: 'Nama Wakil Kandidat'),
            const SizedBox(height: 15),
            CustomTextField(controller: namaPartaiController, hintText: 'Nama Partai'),
            const SizedBox(height: 15),
            CustomTextField(controller: visiMisiController, hintText: 'Visi & Misi'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final newKandidat = {
                  'noUrut': noUrutController.text,
                  'namaKetua': namaKetuaController.text,
                  'namaWakil': namaWakilController.text,
                  'namaPartai': namaPartaiController.text,
                  'visiMisi': visiMisiController.text,
                };
                onAddKandidat(newKandidat);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001A6E),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Tambah',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF001A6E)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
