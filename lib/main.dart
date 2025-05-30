import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa/provider/booking_provider.dart';
import 'package:spa/provider/cart_provider.dart';
import 'package:spa/provider/location_provider.dart';
import 'package:spa/provider/spa_provider.dart';
import 'screens/locationScreen.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SpaProvider()),
          ChangeNotifierProvider(create: (_) => LocationProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => BookingProvider()),
        ],

      child: const SpaApp(),
    ),
  );
}

class SpaApp extends StatelessWidget {
  const SpaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationScreen(),
    );
  }
}

