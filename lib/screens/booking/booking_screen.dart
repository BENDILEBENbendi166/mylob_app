import 'package:flutter/material.dart';
import 'package:mylob_app/services/deal_service.dart';
import 'package:mylob_app/services/hotel_service.dart';
import 'package:mylob_app/services/city_service.dart';
import 'package:mylob_app/services/reservation_service.dart';
import 'package:mylob_app/utils/responsive.dart';
import 'package:mylob_app/screens/booking/widgets/booking_summary.dart';
import 'package:mylob_app/screens/booking/widgets/guest_form.dart';
import 'package:mylob_app/screens/booking/widgets/confirm_button.dart';
import 'dart:math';

class BookingScreen extends StatefulWidget {
  final String dealId;
  const BookingScreen({super.key, required this.dealId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Map<String, dynamic>? deal;
  Map<String, dynamic>? hotel;
  Map<String, dynamic>? city;
  bool isLoading = true;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch deal data
      final fetchedDeal = await DealService.fetchDealById(widget.dealId);
      
      if (!mounted) return;

      // Fetch hotel data if deal has hotelId
      Map<String, dynamic>? fetchedHotel;
      if (fetchedDeal != null && fetchedDeal['hotelId'] != null) {
        fetchedHotel = await HotelService.fetchHotelById(fetchedDeal['hotelId']);
      }

      if (!mounted) return;

      // Fetch city data if hotel has city name
      Map<String, dynamic>? fetchedCity;
      if (fetchedHotel != null && fetchedHotel['city'] != null) {
        final cities = await CityService.fetchCitiesFirestore();
        try {
          fetchedCity = cities.firstWhere(
            (c) => c['name'] == fetchedHotel!['city'],
          );
        } catch (e) {
          fetchedCity = null;
        }
      }

      if (!mounted) return;

      setState(() {
        deal = fetchedDeal;
        hotel = fetchedHotel;
        city = fetchedCity;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching booking data: $e');
    }
  }

  String _generateReservationCode() {
    final random = Random();
    final letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final numbers = '0123456789';
    
    String code = '';
    for (int i = 0; i < 3; i++) {
      code += letters[random.nextInt(letters.length)];
    }
    for (int i = 0; i < 4; i++) {
      code += numbers[random.nextInt(numbers.length)];
    }
    
    return code;
  }

  Future<void> _handleConfirmBooking() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      // Generate reservation code
      final reservationCode = _generateReservationCode();
      
      // Get deal date
      final dealDate = deal!['date'] is DateTime
          ? deal!['date'] as DateTime
          : DateTime.tryParse(deal!['date']?.toString() ?? '') ?? DateTime.now();
      
      final checkInDate = dealDate;
      final checkOutDate = dealDate.add(const Duration(days: 1));

      // Create reservation data
      final reservationData = {
        'code': reservationCode,
        'dealId': widget.dealId,
        'hotelId': hotel!['id'],
        'hotelName': hotel!['name'],
        'cityName': city?['name'] ?? hotel!['city'],
        'guestName': _nameController.text.trim(),
        'guestEmail': _emailController.text.trim(),
        'guestPhone': _phoneController.text.trim(),
        'checkIn': checkInDate.toIso8601String(),
        'checkOut': checkOutDate.toIso8601String(),
        'totalPrice': deal!['finalPrice'],
        'category': deal!['category'],
        'discountPercent': deal!['discountPercent'],
        'paymentMethod': 'Pay at Hotel',
        'status': 'confirmed',
        'createdAt': DateTime.now().toIso8601String(),
      };

      // Save reservation to Firestore
      await ReservationService.createReservation(reservationCode, reservationData);

      if (!mounted) return;

      // Show success dialog
      _showSuccessDialog(reservationCode);
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        isSubmitting = false;
      });

      // Show error dialog
      _showErrorDialog();
      debugPrint('Error creating reservation: $e');
    }
  }

  void _showSuccessDialog(String reservationCode) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade600, size: 32),
            const SizedBox(width: 12),
            const Expanded(child: Text('Booking Confirmed!')),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your reservation has been successfully confirmed.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reservation Code',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reservationCode,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'A confirmation email has been sent to ${_emailController.text.trim()}',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: const Text('Done'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to previous screen
              // In a real app, navigate to reservation details screen
            },
            child: const Text('View Booking'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red.shade600, size: 28),
            const SizedBox(width: 12),
            const Text('Booking Failed'),
          ],
        ),
        content: const Text(
          'Sorry, we couldn\'t complete your booking. Please try again.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Booking'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: r.spacing),

                  // 1. BookingSummary
                  BookingSummary(
                    deal: deal,
                    hotel: hotel,
                    city: city,
                    isLoading: isLoading,
                  ),
                  
                  SizedBox(height: r.spacing * 2),

                  // 2. GuestForm
                  GuestForm(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    isLoading: isSubmitting,
                  ),
                  
                  SizedBox(height: r.spacing * 2),
                ],
              ),
            ),
          ),

          // 3. ConfirmButton - Fixed at bottom
          ConfirmButton(
            deal: deal,
            isLoading: isSubmitting,
            onPressed: _handleConfirmBooking,
          ),
        ],
      ),
    );
  }
}
