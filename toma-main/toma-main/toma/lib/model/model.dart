import 'package:flutter/material.dart';

/// Model Produk
class Product {
  final String name;
  final String image;
  final String price;
  final String description;
  final List<String> availableSizes;
  String? selectedSize;
  int quantity;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.availableSizes,
    this.selectedSize,
    this.quantity = 1,
  });

  /// Konversi produk ke JSON untuk penyimpanan
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'availableSizes': availableSizes,
      'selectedSize': selectedSize,
      'quantity': quantity,
    };
  }

  /// Membuat produk dari JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      image: json['image'],
      price: json['price'],
      description: json['description'],
      availableSizes: List<String>.from(json['availableSizes']),
      selectedSize: json['selectedSize'],
      quantity: json['quantity'],
    );
  }
}

/// Model Keranjang Belanja
class CartModel extends ChangeNotifier {
  final List<Product> _cartItems = [];

  /// Mendapatkan daftar item di keranjang (salinan agar tidak dapat dimodifikasi langsung)
  List<Product> get cartItems => List.unmodifiable(_cartItems);

  /// Mendapatkan daftar item untuk tujuan eksternal
  List<Product> getCartItems() {
    return cartItems;
  }

  /// Menambahkan produk ke keranjang (dengan pengecekan duplikasi)
  void addProduct(Product product) {
    // Jika produk sudah ada, tingkatkan jumlahnya
    final existingIndex = _cartItems.indexWhere((item) => item.name == product.name);
    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += product.quantity;
    } else {
      _cartItems.add(product);
    }
    notifyListeners();
  }

  /// Menghapus item dari keranjang berdasarkan indeks
  void removeItem(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  /// Menghapus item dari keranjang berdasarkan produk
  void removeProductByName(String productName) {
    _cartItems.removeWhere((item) => item.name == productName);
    notifyListeners();
  }

  /// Mengubah ukuran produk
  void updateSize(int index, String size) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index].selectedSize = size;
      notifyListeners();
    }
  }

  /// Menambah jumlah produk
  void incrementQuantity(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  /// Mengurangi jumlah produk
  void decrementQuantity(int index) {
    if (index >= 0 && index < _cartItems.length && _cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      notifyListeners();
    }
  }

  /// Membersihkan semua item di keranjang
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  /// Menghitung total harga keranjang
  double calculateTotalPrice() {
    return _cartItems.fold(0.0, (sum, item) {
      return sum + (double.tryParse(item.price) ?? 0) * item.quantity;
    });
  }

  /// Mengonversi daftar produk di keranjang ke JSON
  List<Map<String, dynamic>> toJson() {
    return _cartItems.map((product) => product.toJson()).toList();
  }

  /// Mengisi keranjang dengan produk dari JSON
  void fromJson(List<Map<String, dynamic>> json) {
    _cartItems.clear();
    _cartItems.addAll(json.map((item) => Product.fromJson(item)));
    notifyListeners();
  }
}
