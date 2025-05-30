import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/spa_model.dart'; // Separate model if needed

class SpaProvider extends ChangeNotifier {

  List<Spa> _spas = [];
  List<Spa> favorites = [];
  bool _isLoading = false;
  String? _error;

  List<Spa> get spas => _spas;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSpas() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/c/3647-7e39-4d74-b7a7'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List spaList = jsonData ?? [];
        _spas = spaList.map((data) => Spa.fromJson(data)).toList();
      } else {
        _error = 'Failed to load spas';
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
  void toggleFavorite(Spa spa) {
    if (favorites.contains(spa)) {
      favorites.remove(spa);
    } else {
      favorites.add(spa);
    }
    notifyListeners();
  }

  bool isFavorite(Spa spa) {
    return favorites.contains(spa);
  }

  int get favoriteCount => favorites.length;
}
