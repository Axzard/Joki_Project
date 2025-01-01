import 'package:flutter/material.dart';

class VisiMisiPage extends StatelessWidget {
  final int candidateIndex;

  const VisiMisiPage({super.key, required this.candidateIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF001A6E),
        title: Text(
          "Visi & Misi Kandidat ${candidateIndex + 1}",
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // Warna ikon putih
        ),
      ),
      body: Container(
        color: const Color(0xFFE8F0FA), // Background color
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Visi Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF001A6E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Center(
                    child: Text(
                      "VISI",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "1. Pilih yang Cantik\n"
                    "2. Pilih juga yang manis\n"
                    "3. Pilih yang baik hati\n"
                    "4. Pilih yang murah senyum",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Misi Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF001A6E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Center(
                    child: Text(
                      "MISI",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "1. Menambah yang cantik\n"
                    "2. Membuat glowing\n"
                    "3. Menjauhkan yang tidak beretika\n"
                    "4. Menjauhkan yang susah senyum",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Vote Button
            ElevatedButton(
              onPressed: () {
                // Menampilkan notifikasi
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Kandidat ${candidateIndex + 1} berhasil dipilih!',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001A6E),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 32,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Vote",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
