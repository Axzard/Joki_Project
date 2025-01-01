import 'package:flutter/material.dart';
import 'edit_data_kandidat.dart';
import 'tambah_data_kandidat.dart';

class KelolaKandidatPage extends StatefulWidget {
  const KelolaKandidatPage({super.key});

  @override
  _KelolaKandidatPageState createState() => _KelolaKandidatPageState();
}

class _KelolaKandidatPageState extends State<KelolaKandidatPage> {
  // Daftar kandidat
  List<Map<String, String>> kandidatData = List.generate(
    5,
    (index) => {
      'noUrut': '${index + 1}',
      'namaKetua': 'Ketua ${index + 1}',
      'namaWakil': 'Wakil ${index + 1}',
      'namaPartai': 'Partai ${index + 1}',
      'visiMisi': 'Visi & Misi ${index + 1}',
    },
  );

  // Menambah data kandidat
  void _tambahKandidat(Map<String, String> kandidat) {
    setState(() {
      kandidatData.add(kandidat);
    });
  }

  // Mengupdate data kandidat
  void _updateKandidat(int index, Map<String, String> updatedData) {
    setState(() {
      kandidatData[index] = updatedData;
    });
  }

  // Menghapus kandidat
  void _deleteKandidat(int index) {
    setState(() {
      kandidatData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF001A6E),
        title: const Text(
          'Kelola Kandidat',
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'DATA',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001A6E),
              ),
            ),
            Text(
              'KANDIDAT',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001A6E),
              ),
            ),
            const SizedBox(height: 40),
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
                    DataColumn(label: Text('No Urut')),
                    DataColumn(label: Text('Nama Ketua\nKandidat')),
                    DataColumn(label: Text('Nama Wakil\nKandidat')),
                    DataColumn(label: Text('Nama Partai')),
                    DataColumn(label: Text('Visi & Misi')),
                    DataColumn(label: Text('Aksi')),
                  ],
                  rows: List.generate(kandidatData.length, (index) {
                    return DataRow(cells: [
                      DataCell(Text(kandidatData[index]['noUrut']!)),
                      DataCell(Text(kandidatData[index]['namaKetua']!)),
                      DataCell(Text(kandidatData[index]['namaWakil']!)),
                      DataCell(Text(kandidatData[index]['namaPartai']!)),
                      DataCell(Text(kandidatData[index]['visiMisi']!)),
                      DataCell(
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditDataKandidat(
                                      index: index,
                                      kandidatData: kandidatData[index],
                                      onUpdate: (updatedIndex, updatedData) {
                                        _updateKandidat(updatedIndex, updatedData);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showDeleteConfirmationDialog(context, index);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'Hapus',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ActionButton(
              text: 'Tambah',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TambahDataKandidat(onAddKandidat: _tambahKandidat),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus kandidat ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _deleteKandidat(index);
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF001A6E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
