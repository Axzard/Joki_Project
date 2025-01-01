import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pungutsuara/login/login.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // URL Firebase Realtime Database
  final String _firebaseUrl =
      'https://pungutsuara-56dc7-default-rtdb.firebaseio.com/pengguna.json';

  // Fungsi untuk mengubah password di Firebase Realtime Database
  Future<void> _changePassword(String usernameOrNik, String phoneNumber, String newPassword) async {
    try {
      // Request data pengguna dari Firebase berdasarkan NIK atau username
      final response = await http.get(Uri.parse(_firebaseUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        // Cari pengguna berdasarkan NIK dan nomor telepon
        String? userKey;
        String? existingPassword;

        data.forEach((key, value) {
          if ((value['username'] == usernameOrNik || value['nik'] == usernameOrNik) &&
              value['phoneNumber'] == phoneNumber) {
            userKey = key;
            existingPassword = value['password'];
          }
        });

        if (userKey != null) {
          // Validasi apakah password baru tidak sama dengan password lama
          if (existingPassword != newPassword) {
            // Update password
            final updateResponse = await http.patch(
              Uri.parse(
                'https://pungutsuara-56dc7-default-rtdb.firebaseio.com/pengguna/$userKey.json',
              ),
              body: json.encode({
                'password': newPassword,
              }),
            );

            if (updateResponse.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password berhasil diubah')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gagal mengubah password')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password baru tidak boleh sama dengan yang lama')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('NIK dan Nomor Telepon tidak ditemukan')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengakses data pengguna')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header dengan tombol kembali dan "LUPA PASSWORD"
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF001A6E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.07,
                horizontal: screenWidth * 0.05,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'LUPA PASSWORD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Center(
              child: const Icon(
                Icons.lock,
                size: 120,
                color: Color(0xFF001A6E),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            const Center(
              child: Text(
                'Atur Ulang Password Anda',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001A6E),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Input NIK atau Username
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'NIK atau Username',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF001A6E),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Input Nomor Telepon
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: 'No.Tlp',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF001A6E),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Input Password Baru
                  TextField(
                    controller: _newPasswordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password Baru',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF001A6E),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Input Konfirmasi Password
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Konfirmasi Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF001A6E),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Tombol "Atur"
                  ElevatedButton(
                    onPressed: () {
                      if (_newPasswordController.text ==
                          _confirmPasswordController.text) {
                        String usernameOrNik = _usernameController.text.trim();
                        String phoneNumber = _phoneController.text.trim();
                        String newPassword = _newPasswordController.text.trim();
                        _changePassword(usernameOrNik, phoneNumber, newPassword);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password tidak cocok')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF001A6E),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Atur Password',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
