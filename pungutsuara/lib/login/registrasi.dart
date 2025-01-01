import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationPage> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF001A6E),
            hintColor: const Color(0xFF001A6E),
            colorScheme: const ColorScheme.light(primary: Color(0xFF001A6E)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = "${pickedDate.day.toString().padLeft(2, '0')}/"
            "${pickedDate.month.toString().padLeft(2, '0')}/"
            "${pickedDate.year}";
      });
    }
  }

  Future<void> _registerUser() async {
    final String nik = _nikController.text;
    final String dob = _dobController.text;
    final String fullName = _fullNameController.text;
    final String address = _addressController.text;
    final String phoneNumber = _phoneNumberController.text;
    final String password = _passwordController.text;

    if (!nik.startsWith("82")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NIK harus diawali dengan "82"')),
      );
      return;
    }

    if (_dobController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal lahir harus dipilih')),
      );
      return;
    }

    if (password != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kata sandi tidak cocok')),
      );
      return;
    }

    try {
      final url = Uri.parse(
          'https://pungutsuara-56dc7-default-rtdb.firebaseio.com/pengguna.json');
      final response = await http.post(
        url,
        body: json.encode({
          'nik': nik,
          'dob': dob,
          'fullName': fullName,
          'address': address,
          'phoneNumber': phoneNumber,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akun berhasil dibuat')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal membuat akun')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header hijau dengan tombol kembali
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
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                      'REGISTRASI AKUN!',
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
            // Form input
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Input NIK
                  TextField(
                    controller: _nikController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: 'NIK',
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
                  // Input Tanggal Lahir dengan DatePicker
                  TextField(
                    controller: _dobController,
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(
                          r'[0-9/]')), // Hanya angka dan '/' yang diizinkan
                      LengthLimitingTextInputFormatter(
                          10), // Maksimal 10 karakter
                    ],
                    decoration: InputDecoration(
                      hintText: 'dd/mm/yyyy',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF001A6E),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today,
                            color: Colors.grey),
                        onPressed: () => _selectDate(
                            context), // Memanggil fungsi _selectDate
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      // Validasi format tanggal saat pengguna mengetik
                      if (value.length == 10) {
                        final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                        if (!regex.hasMatch(value)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Format tanggal tidak valid (dd/mm/yyyy)')),
                          );
                        }
                      }
                    },
                    onTap: () {
                      // Pilihan opsional: jika ingin langsung membuka DatePicker ketika kolom di-tap
                      // _selectDate(context);
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Input Nama Lengkap
                  TextField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      hintText: 'Nama Lengkap',
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
                  // Input Alamat Lengkap
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: 'Alamat Lengkap',
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
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: 'Nomor Telepon',
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
                  // Input Kata Sandi
                  TextField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      hintText: 'Kata Sandi',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF001A6E),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Input Konfirmasi Kata Sandi
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: !_confirmPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Konfirmasi Kata Sandi',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF001A6E),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Tombol "Daftar"
                  ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF001A6E),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
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
