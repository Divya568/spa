import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/booking_provider.dart';


class BookingConfirmationDialog extends StatelessWidget {
  final DateTime bookingDateTime;
  final List<String> services;

  const BookingConfirmationDialog({
    Key? key,
    required this.bookingDateTime,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, d MMM yyyy').format(bookingDateTime);
    final formattedTime = DateFormat('h:mm a').format(bookingDateTime);
    final servicesStr = services.join(" and ");

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Gold ring + white tick
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFB38C4D),
                    Color(0xFFD7BA84),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFB38C4D),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    size:36,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ✅ Confirmation text
            const Text(
              "Your Service Booking is\nConfirmed!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            // ✅ "Oasis Spa Haven" in golden-brown
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  color: Color(0xFF6C7AA1),
                  fontSize: 14,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(
                    text: "Thank you for choosing ",
                  ),
                  const TextSpan(
                    text: "Oasis Spa Haven",
                    style: TextStyle(
                      color: Color(0xFFB38C4D), // Golden brown
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(
                    text: ".\nYour appointment for ",
                  ),
                  TextSpan(
                    text: servicesStr,
                    style: const TextStyle(
                      color: Color(0xFF4A7FC1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const TextSpan(
                    text: "\nhas been successfully booked.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ✅ Light brown background container
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF4E9), // Very light warm beige
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Your appointment on $formattedDate\nat $formattedTime",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Done button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFB38C4D),
                      Color(0xFFD7BA84),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    context.read<BookingProvider>().clearBooking();
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
