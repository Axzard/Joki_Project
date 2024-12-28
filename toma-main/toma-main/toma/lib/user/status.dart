import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_merchandise/model/model.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<Product> localOrderedItems = [];

  @override
  void initState() {
    super.initState();
    // Menunda akses ke context sampai setelah widget selesai dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartModel = Provider.of<CartModel>(context, listen: false);
      setState(() {
        localOrderedItems = List.from(cartModel.getCartItems());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text(
          'Status Pembayaran',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: localOrderedItems.isEmpty
          ? Center(
              child: Text(
                'Tidak ada pesanan',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: localOrderedItems.length,
              itemBuilder: (context, index) {
                var product = localOrderedItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                product.image,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Detail: ${product.description}',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Harga: Rp ${product.price}',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Menampilkan dialog konfirmasi
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Konfirmasi'),
                                        content: Text(
                                            'Apakah Anda yakin ingin menghapus item ini?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Batal'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                localOrderedItems
                                                    .removeAt(index);
                                              });
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Item berhasil dihapus.'),
                                                ),
                                              );
                                            },
                                            child: Text('Hapus'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      'Ukuran: ',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    DropdownButton<String>(
                                      value: product.selectedSize ??
                                          product.availableSizes.first,
                                      onChanged: (newSize) {
                                        setState(() {
                                          product.selectedSize = newSize;
                                        });
                                      },
                                      items: product.availableSizes
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Jumlah: ',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: TextField(
                                        controller: TextEditingController(
                                          text: product.quantity.toString(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onSubmitted: (value) {
                                          int? newQuantity =
                                              int.tryParse(value);
                                          if (newQuantity != null &&
                                              newQuantity > 0) {
                                            setState(() {
                                              product.quantity = newQuantity;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
