import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String price;
  final String duration;

  CartItem({required this.name, required this.price, required this.duration});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }


  void removeItemByName(String name) {
    _items.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  int _parsePrice(String price) {
    return int.tryParse(price.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
  }

  bool contains(String name) {
    return _items.any((item) => item.name == name);}

  int get selectedTotal => _items.fold(0, (sum, item) => sum + _parsePrice(item.price));

  int get additionalFee => 50;

  int get convenienceFee => 100;

  int get payableAmount => selectedTotal + additionalFee + convenienceFee;
}
