import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import 'confirmation_dailogue.dart';
import '../provider/booking_provider.dart';

class CartScreen extends StatelessWidget {
 CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final cartItems = context.watch<CartProvider>().items;

    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        final cartItems = cartProvider.items;
        final selectedTotal = cartProvider.selectedTotal;
        final additionalFee = cartProvider.additionalFee;
        final convenienceFee = cartProvider.convenienceFee;
        final payableAmount = cartProvider.payableAmount;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text("Cart", style: TextStyle(color: Colors.black)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader("Your Services Order", actionText: "+ Add more"),
                  const SizedBox(height: 10),
                  ...cartItems.map((item) => _cartItemTile(context, item)).toList(),

                  const SizedBox(height: 20),
                  const Text("Offers & Discounts", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _couponTile(),

                  const SizedBox(height: 20),
                  const Text("Payment Summary", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _summaryBox(selectedTotal, additionalFee, convenienceFee, payableAmount),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _bottomBar(context, payableAmount),
        );
      },
    );
  }

  Widget _sectionHeader(String title, {String? actionText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        if (actionText != null)
          Text(actionText, style: const TextStyle(color: Color(0xFF9C733C), fontSize: 14)),
      ],
    );
  }

  Widget _cartItemTile(BuildContext context, CartItem item) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("For Male", style: TextStyle(fontSize: 13, color: Colors.grey)),
              Text("${item.price} • ${item.duration}", style: const TextStyle(fontSize: 13)),
            ],
          ),
          OutlinedButton(
            onPressed: () {
              cartProvider.removeItemByName(item.name);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF9C733C)),
              foregroundColor: const Color(0xFF9C733C),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text("Remove"),
          ),
        ],
      ),
    );
  }

  Widget _couponTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: const [
          Icon(Icons.local_offer_outlined, color: Colors.black),
          SizedBox(width: 10),
          Expanded(child: Text("Apply Coupon", style: TextStyle(fontSize: 15))),
          Icon(Icons.arrow_forward_ios, size: 14)
        ],
      ),
    );
  }

  Widget _summaryBox(int selectedTotal, int additional, int convenience, int payable) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _summaryRow("Selected Services", "₹$selectedTotal", showArrow: true),
          _summaryRow("Additional Fee", "₹$additional"),
          _summaryRow("Convenience Fee", "₹$convenience"),
          const Divider(height: 24),
          _summaryRow("Payable Amount", "₹$payable", isBold: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false, bool showArrow = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
              if (showArrow) const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
            ],
          ),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

 Widget _bottomBar(BuildContext context, int totalAmount) {
   final cartProvider = Provider.of<CartProvider>(context, listen: false);
   final bookingProvider = context.read<BookingProvider>();

   return Container(
     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
     decoration: const BoxDecoration(
       color: Colors.white,
       boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
     ),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text("Total ₹$totalAmount", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
         ElevatedButton(
           onPressed: () async {
             DateTime? selectedDate = await showDatePicker(
               context: context,
               initialDate: DateTime.now().add(const Duration(days: 1)),
               firstDate: DateTime.now(),
               lastDate: DateTime.now().add(const Duration(days: 365)),
             );

             if (selectedDate != null) {
               TimeOfDay? selectedTime = await showTimePicker(
                 context: context,
                 initialTime: const TimeOfDay(hour: 8, minute: 0),
               );

               if (selectedTime != null) {
                 DateTime finalDateTime = DateTime(
                   selectedDate.year,
                   selectedDate.month,
                   selectedDate.day,
                   selectedTime.hour,
                   selectedTime.minute,
                 );

                 bookingProvider.setBooking(
                   finalDateTime,
                   cartProvider.items.map((e) => e.name).toList(),
                 );

                 showDialog(
                   context: context,
                   builder: (_) => BookingConfirmationDialog(
                     bookingDateTime: finalDateTime,
                     services: cartProvider.items.map((e) => e.name).toList(),
                   ),
                 );
               }
             }
           },
           style: ElevatedButton.styleFrom(
             backgroundColor: const Color(0xFF9C733C),
             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
           ),
           child: const Text("Pay", style: TextStyle(fontWeight: FontWeight.bold)),
         ),
       ],
     ),
   );
 }

}
