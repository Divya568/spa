import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa/provider/location_provider.dart';
import 'homeScreen.dart'; // create this file with the above provider code

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF2EAD8),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        width: double.infinity,
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 80,
                  color: Colors.black,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Enable Your Location",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Please allow to use your location to show\nnearby Saloons on the map.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF665027),
                        Color(0xFFD2B16A),
                      ],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Provider.of<LocationProvider>(context, listen: false)
                          .enableLocation();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SpaListScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Enable location",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
