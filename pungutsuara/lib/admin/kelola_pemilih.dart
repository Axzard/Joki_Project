import 'package:flutter/material.dart';
import 'package:pungutsuara/admin/edit_data_pemilih.dart';
import 'package:pungutsuara/admin/tambah_data_pemilih.dart';

class KelolaPemilihPage extends StatefulWidget {
  const KelolaPemilihPage({super.key});

  @override
  _KelolaPemilihPageState createState() => _KelolaPemilihPageState();
}

class _KelolaPemilihPageState extends State<KelolaPemilihPage> {
  List<Map<String, String>> pemilihData = List.generate(
    5,
    (index) => {
      'nik': '1234567890${index + 1}',
      'ttl': '01-01-200${index + 1}',
      'nama': 'Nama Pemilih ${index + 1}',
      'noTlp': '08123456789${index + 1}',
      'alamat': 'Alamat ${index + 1}, Kota ABC',
    },
  );

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus pemilih ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  pemilihData.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data berhasil dihapus!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF001A6E),
        title: const Text(
          'Kelola Pemilih',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            const Text(
              'DATA',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001A6E),
              ),
            ),
            const Text(
              'PEMILIH',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001A6E),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20,
                  headingRowColor: WidgetStateProperty.resolveWith(
                    (states) => const Color(0xFF001A6E),
                  ),
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  columns: const [
                    DataColumn(label: Text('NIK')),
                    DataColumn(label: Text('TTL')),
                    DataColumn(label: Text('Nama Lengkap')),
                    DataColumn(label: Text('No. Tlp')),
                    DataColumn(label: Text('Alamat Lengkap')),
                    DataColumn(label: Text('Aksi')),
                  ],
                  rows: List.generate(pemilihData.length, (index) {
                    final data = pemilihData[index];
                    return DataRow(
                      cells: [
                        DataCell(Text(data['nik']!)),
                        DataCell(Text(data['ttl']!)),
                        DataCell(Text(data['nama']!)),
                        DataCell(Text(data['noTlp']!)),
                        DataCell(Text(data['alamat']!)),
                        DataCell(
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    final updatedData = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditDataPemilih(
                                          index: index,
                                          existingData: pemilihData[index],
                                        ),
                                      ),
                                    );

                                    if (updatedData != null) {
                                      setState(() {
                                        pemilihData[index] = updatedData; // Update the list with new data
                                      });
                                    }
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => _showDeleteConfirmationDialog(
                                    context, index),
                                child: const Text(
                                  'Hapus',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newPemilih = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TambahDataPemilih(),
                  ),
                );
                if (newPemilih != null) {
                  setState(() {
                    pemilihData.add(newPemilih);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001A6E),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Tambah Data Pemilih',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
