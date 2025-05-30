import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa/provider/spa_provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpaProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: provider.favorites.isEmpty
          ? const Center(child: Text("No favorites yet."))
          : ListView.builder(
        itemCount: provider.favorites.length,
        itemBuilder: (context, index) {
          final spa = provider.favorites[index];
          return ListTile(
            leading: Image.network(spa.image, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(spa.name),
            subtitle: Text(spa.location),
          );
        },
      ),
    );
  }
}
