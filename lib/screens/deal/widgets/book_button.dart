import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';

class BookButton extends StatefulWidget {
  final Map<String, dynamic>? deal;
  final Map<String, dynamic>? hotel;
  final VoidCallback? onPressed;
  final bool isLoading;

  const BookButton({
    super.key,
    required this.deal,
    required this.hotel,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  State<BookButton> createState() => _BookButtonState();
}

class _BookButtonState extends State<BookButton> {
  bool _isBooking = false;

  Future<void> _handleBooking() async {
    if (widget.isLoading || _isBooking) return;

    setState(() {
      _isBooking = true;
    });

    // Simulate booking process
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() {
      _isBooking = false;
    });

    // Call the provided callback
    if (widget.onPressed != null) {
      widget.onPressed!();
    } else {
      // Default behavior - show a success message
      _showBookingDialog();
    }
  }

  void _showBookingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade600, size: 28),
            const SizedBox(width: 12),
            const Text('Booking Confirmed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your reservation at ${widget.hotel?['name'] ?? 'the hotel'} has been confirmed.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Final Price: £${widget.deal?['finalPrice'] ?? 0}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('View Reservations'),
          ),
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
    final isDisabled = widget.isLoading || widget.deal == null;
    final availableRooms = widget.deal?['availableRooms'] ?? 0;
    final isAvailable = availableRooms > 0;

    return Padding(
      padding: EdgeInsets.all(r.spacing),
      child: Column(
        children: [
          // Main book button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: isDisabled || !isAvailable ? null : _handleBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: isAvailable 
                    ? Colors.green.shade600 
                    : Colors.grey.shade400,
                disabledBackgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: isDisabled ? 0 : 4,
              ),
              child: _isBooking
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.bookmark, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          isAvailable ? 'Book Now' : 'Sold Out',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          
          if (isAvailable && !isDisabled) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 6),
                Text(
                  'Secure booking • No upfront payment',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
