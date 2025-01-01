import 'package:flutter/material.dart';
import 'package:pungutsuara/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3)); 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF001A6E),
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            
            Icon(
              Icons.how_to_vote,
              size: screenWidth * 0.4, 
              color: Colors.white,
            ),
            SizedBox(height: screenHeight * 0.05), 
            
            Text(
              'SISTEM',
              style: TextStyle(
                fontSize: screenWidth * 0.08, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            Text(
              'PEMUNGUTAN SUARA',
              style: TextStyle(
                fontSize: screenWidth * 0.05, 
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}