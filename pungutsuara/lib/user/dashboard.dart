import 'package:flutter/material.dart';
import 'package:pungutsuara/login/login.dart';
import 'package:pungutsuara/user/voting.dart';

class DashboardUser extends StatelessWidget {
  const DashboardUser({super.key});

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
          'Dashboard Pemilih',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.home),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 170),
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
            const SizedBox(height: 55), 
            MenuButton(
              icon: Icons.check_box_outlined,
              text: 'Voting',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VotingPage()),
                );
              },
            ),
            const Spacer(), // Membuat logout tetap di bagian bawah
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: const Color(0xFF001A6E),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
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
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
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
