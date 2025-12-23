import 'package:flutter/material.dart';
import 'package:mylob_app/utils/responsive.dart';

class ConfirmButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final Map<String, dynamic>? deal;

  const ConfirmButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.deal,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final isDisabled = isLoading || deal == null;
    final finalPrice = deal?['finalPrice'] ?? 0;

    return Padding(
      padding: EdgeInsets.all(r.spacing),
      child: Column(
        children: [
          // Payment options info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200, width: 2),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: Colors.green.shade700,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Payment Options',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildPaymentOption(
                  Icons.hotel,
                  'Pay at Hotel',
                  'Preferred - No upfront payment required',
                  Colors.green.shade700,
                  true,
                ),
                const SizedBox(height: 8),
                _buildPaymentOption(
                  Icons.credit_card,
                  'Credit Card',
                  'Coming soon',
                  Colors.grey.shade600,
                  false,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Confirm button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: isDisabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                disabledBackgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: isDisabled ? 0 : 4,
              ),
              child: isLoading
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
                        const Icon(Icons.check_circle, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          'Confirm Booking (£$finalPrice)',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: 12),

          // Terms and conditions
          if (!isDisabled)
            Text(
              'By confirming, you agree to our Terms & Conditions',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    bool isSelected,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.green.shade400 : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: Colors.green.shade600,
              size: 20,
            ),
        ],
      ),
    );
  }
}
