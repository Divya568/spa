import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spa/provider/cart_provider.dart';
import 'cart_screen.dart';
import '../model/spa_model.dart';

class StoreProfileScreen extends StatefulWidget {
  final Spa spa;
  const StoreProfileScreen({super.key, required this.spa});

  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  final Map<String, bool> _expanded = {
    "Massage Therapy": true,
    "Hair Cut Wash & Style": false,
    "Nail Bar": false,
  };
  List<CartItem> _cartItems = [];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwBVBqPbJl5YNbXAtNS_t8fYhLqCui-W-1hw&s',
                fit: BoxFit.cover,
              ),
            ),

            // Top & Bottom white gradient overlay
            Positioned.fill(
              child: Column(
                children: [
                  Container(
                      height: 200,
                      decoration: BoxDecoration(gradient: _whiteTopGradient())),
                  Expanded(
                      child: Container(color: Colors.white.withOpacity(0.95))),
                ],
              ),
            ),

            // Main Scroll Content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const Icon(Icons.arrow_back_ios,
                                  color: Color(0xFF9C733C), size: 20),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    _storeCard(),
                    const SizedBox(height: 16),
                    _buildChips(),
                    const SizedBox(height: 12),
                    _buildExpandableSection("Massage Therapy", services: [
                      _serviceTile(
                          "Swedish Massage", "₹4,000", "60 Mins", "Walk-in"),
                      _serviceTile("Deep Tissue Massage", "₹6,200", "60 Mins",
                          "Walk-in"),
                      _serviceTile("Hot Stone Massage", "₹8,500", "60 Mins",
                          "Homevisit"),
                    ]),
                    _buildExpandableSection("Hair Cut Wash & Style"),
                    _buildExpandableSection("Nail Bar"),
                  ],
                ),
              ),
            ),

            // Bottom Check out bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${context.watch<CartProvider>().items.length} Services added",
                        style: const TextStyle(fontWeight: FontWeight.w600)),

                    // Text("${_cartItems.length} Services added", style: const TextStyle(fontWeight: FontWeight.w600)),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9C733C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () async {
                        final removedItemName = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );

                        if (removedItemName != null) {
                          setState(() {
                            _cartItems.removeWhere(
                                (item) => item.name == removedItemName);
                          });
                        }
                      },
                      child: const Text("Check out"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  LinearGradient _whiteTopGradient() => const LinearGradient(
        colors: [Colors.white, Colors.white10],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  Widget _iconText(IconData icon, String text,
      {Color iconColor = Colors.grey}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _storeCard() {
    final spa = widget.spa;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(spa.image),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(spa.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 2,
                      runSpacing: 2,
                      children: [
                        _iconText(Icons.location_on, spa.location),
                        _iconText(Icons.route, spa.distance),
                        _iconText(Icons.star, spa.rating,
                            iconColor: Colors.amber),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (spa.discount.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F4EC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_offer, size: 18, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "Use code ",
                        style: const TextStyle(fontSize: 13),
                        children: [
                          TextSpan(
                            text: spa.discount,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const TextSpan(
                            text: "\nGet ₹500 off on orders above 100/-",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChips() {
    final filters = ["All", "Home-visit", "Walk-in", "Male", "Female"];
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        height: 36,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (_, i) {
            final isSelected = i == 0;
            return Chip(
              label: Text(filters[i],
                  style: TextStyle(
                      fontSize: 13,
                      color:
                          isSelected ? Color(0xFF9C733C) : Color(0xFF9C733C))),
              backgroundColor:
                  isSelected ? const Color(0xFFE8D5B5) : Colors.grey.shade200,
              shape: StadiumBorder(
                side: BorderSide(
                    color: isSelected
                        ? const Color(0xFF9C733C)
                        : Color(0xFF9C733C)),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 8),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(String title, {List<Widget>? services}) {
    final isOpen = _expanded[title] ?? false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _expanded[title] = !isOpen),
            child: Row(
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                AnimatedRotation(
                  turns: isOpen ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child:
                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (isOpen && services != null) ...services,
        ],
      ),
    );
  }

  Widget _serviceTile(String name, String price, String duration, String type) {
    return Consumer<CartProvider>(
      builder: (_, cartProvider, __) {
        final selected = cartProvider.contains(name);
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.brown.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text(
                "Experience relaxation and stress relief with long, flowing strokes and gentle kneading tech...",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$price · $duration · $type",
                      style: const TextStyle(fontSize: 13)),
                  ElevatedButton(
                    onPressed: () {
                      final item = CartItem(
                          name: name, price: price, duration: duration);
                      if (selected) {
                        cartProvider.removeItemByName(name);
                      } else {
                        cartProvider.addItem(item);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selected
                          ? Colors.grey.shade300
                          : const Color(0xFF9C733C),
                      foregroundColor: selected ? Colors.black : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text(selected ? "Remove" : "Add"),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
