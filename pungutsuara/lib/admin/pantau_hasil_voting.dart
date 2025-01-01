import 'package:flutter/material.dart';

class HasilVotingPage extends StatelessWidget {
  const HasilVotingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // INI HANYA CONTO STATIS NANTI DIGANTI DARI BACKEND
    final List<Map<String, dynamic>> candidates = [
      {"name": "Calon 1", "percentage": 0.25}, 
      {"name": "Calon 2", "percentage": 0.45}, 
      {"name": "Calon 3", "percentage": 0.40}, 
    ];

    return Scaffold(
      backgroundColor: Color(0xFFE8F0FA),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF001A6E),
        title: Text(
          "Pantau Hasil Voting",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 55),
            Center(
              child: Text(
                "HASIL VOTING",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001A6E),
                ),
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (context, index) {
                  final candidate = candidates[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0xFF001A6E),
                            ),
                            Positioned(
                              top: 10,
                              child: Image.asset(
                                'assets/Calon.png', // Ganti dengan path gambar
                                width: 65,
                                height: 55,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${(candidate['percentage'] * 100).toStringAsFixed(2)}%", // Tampilkan persentase
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              LinearProgressIndicator(
                                value: candidate['percentage'], // Nilai progress
                                backgroundColor: Colors.grey[300],
                                color: Color(0xFF001A6E),
                                minHeight: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
