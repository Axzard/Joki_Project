import 'package:flutter/material.dart';
import 'package:pungutsuara/admin/kelola_kandidat.dart';
import 'package:pungutsuara/admin/kelola_pemilih.dart';
import 'package:pungutsuara/admin/pantau_hasil_voting.dart';
import 'package:pungutsuara/login/login.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FA),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 40, 
        ),
        backgroundColor: const Color(0xFF001A6E),
        title: const Text(
          'Dashboard Admin',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0), 
          child: Icon(Icons.home), 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'MENU',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001A6E),
                ),
              ),
            ),
            Column(
              children: [
                MenuButton(
                  icon: Icons.list_alt,
                  text: 'Kelola Kandidat',
                  onTap: () {
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => const KelolaKandidatPage()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                MenuButton(
                  icon: Icons.note_alt,
                  text: 'Kelola Pemilih',
                  onTap: () {
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => const KelolaPemilihPage()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                MenuButton(
                  icon: Icons.bar_chart,
                  text: 'Pantau Hasil Voting',
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HasilVotingPage()),
                    );
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: const Color(0xFF001A6E),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false
                    );
                  },
                  child: const Icon(Icons.logout, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
          color: const Color(0xFF001A6E), 
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 35,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
