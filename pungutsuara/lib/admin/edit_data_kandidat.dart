import 'package:flutter/material.dart';

class EditDataKandidat extends StatefulWidget {
  final int index;
  final Map<String, String> kandidatData;
  final Function(int, Map<String, String>) onUpdate;

  const EditDataKandidat({
    super.key,
    required this.index,
    required this.kandidatData,
    required this.onUpdate,
  });

  @override
  State<EditDataKandidat> createState() => _EditDataKandidatState();
}

class _EditDataKandidatState extends State<EditDataKandidat> {
  late TextEditingController _noUrutController;
  late TextEditingController _namaKetuaController;
  late TextEditingController _namaWakilController;
  late TextEditingController _namaPartaiController;
  late TextEditingController _visiMisiController;

  @override
  void initState() {
    super.initState();

    
    _noUrutController = TextEditingController(text: widget.kandidatData['noUrut']);
    _namaKetuaController = TextEditingController(text: widget.kandidatData['namaKetua']);
    _namaWakilController = TextEditingController(text: widget.kandidatData['namaWakil']);
    _namaPartaiController = TextEditingController(text: widget.kandidatData['namaPartai']);
    _visiMisiController = TextEditingController(text: widget.kandidatData['visiMisi']);
  }

  @override
  void dispose() {
    
    _noUrutController.dispose();
    _namaKetuaController.dispose();
    _namaWakilController.dispose();
    _namaPartaiController.dispose();
    _visiMisiController.dispose();
    super.dispose();
  }

  void _updateData() {
    
    widget.onUpdate(
      widget.index,
      {
        'noUrut': _noUrutController.text,
        'namaKetua': _namaKetuaController.text,
        'namaWakil': _namaWakilController.text,
        'namaPartai': _namaPartaiController.text,
        'visiMisi': _visiMisiController.text,
      },
    );

    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil diperbarui!'),
        backgroundColor: Colors.green,
      ),
    );

    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF001A6E),
        title: const Text(
          'Edit Data Kandidat',
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
            CustomTextField(
              controller: _noUrutController,
              hintText: 'No Urut',
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: _namaKetuaController,
              hintText: 'Nama Ketua Kandidat',
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: _namaWakilController,
              hintText: 'Nama Wakil Kandidat',
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: _namaPartaiController,
              hintText: 'Nama Partai',
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: _visiMisiController,
              hintText: 'Visi & Misi',
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _updateData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001A6E),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Perbarui',
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
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

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
