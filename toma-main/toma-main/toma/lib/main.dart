import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_merchandise/login/login.dart'; // LoginPage
import 'package:app_merchandise/user/keranjang.dart'; // KeranjangPage
import 'package:app_merchandise/user/jersy.dart'; // JerseyPage
import 'package:app_merchandise/model/model.dart'; // CartModel

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    print("Flutter Error: ${details.exceptionAsString()}");
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartModel(),
        ),
        // Tambahkan provider lainnya di masa depan
      ],
      child: MaterialApp(
        title: 'Merchandise App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
        routes: {
          '/jersy': (context) => JerseyPage(),
          '/keranjang': (context) => KeranjangPage(),
        },
        builder: (context, child) {
          ErrorWidget.builder = (FlutterErrorDetails details) {
            return Center(
              child: Text(
                "Terjadi kesalahan!",
                style: TextStyle(color: Colors.red),
              ),
            );
          };
          return child!;
        },
      ),
    );
  }
}
