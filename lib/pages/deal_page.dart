import 'package:flutter/material.dart';
import 'package:mylob_app/screens/deal/deal_screen.dart';

/// Page wrapper for Deal Screen with semantic routing
/// Route: /deal/:dealId
class DealPage extends StatelessWidget {
  final String dealId;

  const DealPage({
    super.key,
    required this.dealId,
  });

  @override
  Widget build(BuildContext context) {
    return DealScreen(dealId: dealId);
  }
}
