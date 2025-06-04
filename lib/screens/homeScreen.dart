import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa/provider/spa_provider.dart';
import 'details_screen.dart';
import 'package:spa/screens/wishlist_screen.dart';

class SpaListScreen extends StatefulWidget {
  const SpaListScreen({super.key});

  @override
  State<SpaListScreen> createState() => _SpaListScreenState();
}

class _SpaListScreenState extends State<SpaListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SpaProvider>(context, listen: false).fetchSpas();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SpaProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F0),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar and Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: Colors.brown),
                      const SizedBox(width: 5),
                      DropdownButton<String>(
                        value: 'Madhapur',
                        items: ['Madhapur', 'Hitech City']
                            .map((val) =>
                                DropdownMenuItem(value: val, child: Text(val)))
                            .toList(),
                        onChanged: (_) {},
                        underline: const SizedBox(),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (_) => const WishlistScreen()),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFD3A965),
                                    Color(0xFFAC7B4F)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.favorite_outlined,
                                  color: Colors.white, size: 20),
                            ),
                            if (provider.favoriteCount > 0)
                              Positioned(
                                right: -3,
                                top: -3,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.brown,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                      minWidth: 20, minHeight: 20),
                                  child: Text(
                                    '${provider.favoriteCount}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: "Search Spa, Services...",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.error != null
                      ? Center(child: Text(provider.error!))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: provider.spas.length,
                          itemBuilder: (context, index) {
                            final spa = provider.spas[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        StoreProfileScreen(spa: spa),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        spa.image,
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            spa.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on,
                                                  size: 14, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  spa.location,
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  color: Colors.orange,
                                                  size: 16),
                                              const SizedBox(width: 4),
                                              Text(spa.rating),
                                              const SizedBox(width: 16),
                                              const Icon(Icons.place,
                                                  color: Colors.blueGrey,
                                                  size: 16),
                                              const SizedBox(width: 4),
                                              Text(spa.distance),
                                            ],
                                          ),
                                          if (spa.discount.isNotEmpty)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.local_offer,
                                                      color: Colors.green,
                                                      size: 14),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    spa.discount,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        provider.toggleFavorite(spa);
                                      },
                                      child: Icon(
                                        provider.isFavorite(spa)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: provider.isFavorite(spa)
                                            ? Colors.brown
                                            : Colors.brown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
