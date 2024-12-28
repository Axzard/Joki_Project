import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_merchandise/model/model.dart';

class JerseyPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Jersey Malut United',
      image: 'assets/jes1.png',
      price: 'Rp. 200.000',
      description: 'Jersey di samping merupakan original, tersedia ukuran M, L, dan XL.',
      availableSizes: ['M', 'L', 'XL'],
    ),
    Product(
      name: 'Jersey Malut United',
      image: 'assets/jes2.png',
      price: 'Rp. 200.000',
      description: 'Jersey di samping merupakan original, tersedia ukuran M, L, dan XL.',
      availableSizes: ['M', 'L', 'XL'],
    ),
    Product(
      name: 'Jersey Malut United',
      image: 'assets/jes1.png',
      price: 'Rp. 200.000',
      description: 'Jersey di samping merupakan original, tersedia ukuran M, L, dan XL.',
      availableSizes: ['M', 'L', 'XL'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Belanja Jersey',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.06, // Responsif
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: screenWidth * 0.07), // Responsif
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.02,
              left: screenWidth * 0.05,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logomalut.jpg',
                  height: screenHeight * 0.2, // Responsif
                ),
                SizedBox(width: screenWidth * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Merchandise',
                      style: TextStyle(
                        fontSize: screenWidth * 0.08, // Responsif
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800],
                      ),
                    ),
                    Text(
                      'Malut United',
                      style: TextStyle(
                        fontSize: screenWidth * 0.09, // Responsif
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red[800],
              child: ListView.builder(
                padding: EdgeInsets.all(screenWidth * 0.04), // Responsif
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02), // Responsif
                    padding: EdgeInsets.all(screenWidth * 0.04), // Responsif
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.03), // Responsif
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: screenHeight * 0.2, // Responsif
                          width: screenWidth * 0.4, // Responsif
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(screenWidth * 0.02), // Responsif
                            image: DecorationImage(
                              image: AssetImage(product.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05), // Responsif
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05, // Responsif
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01), // Responsif
                              Text(
                                product.price,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045, // Responsif
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02), // Responsif
                              Text(
                                'Detail:\n${product.description}',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035, // Responsif
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02), // Responsif
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03,
                                    vertical: screenHeight * 0.01,
                                  ), // Responsif
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenWidth * 0.02), // Responsif
                                  ),
                                ),
                                items: product.availableSizes
                                    .map((size) => DropdownMenuItem(
                                          value: size,
                                          child: Text(size),
                                        ))
                                    .toList(),
                                onChanged: (value) {},
                                hint: Text('Pilih ukuran'),
                              ),
                              SizedBox(height: screenHeight * 0.02), // Responsif
                              ElevatedButton.icon(
                                onPressed: () {
                                  Provider.of<CartModel>(context, listen: false).addProduct(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.name} berhasil dimasukkan ke keranjang!'),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.shopping_cart, size: screenWidth * 0.07, color: Colors.black),
                                label: Text('Masukkan Keranjang'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[800],
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }
}
