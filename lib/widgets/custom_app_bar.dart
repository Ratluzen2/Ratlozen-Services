import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final double balance;
  final String currency;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onNotificationPressed;

  const CustomAppBar({
    super.key,
    this.balance = 0.0,
    this.currency = 'د.ع',
    this.onSearchPressed,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Main AppBar with integrated balance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Search Icon (Left)
              GestureDetector(
                onTap: onSearchPressed,
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              // Title (Center)
              const Expanded(
                child: Center(
                  child: Text(
                    'خدمات راتلوزن',
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ),
              // Balance and Notification (Right side)
              Row(
                children: [
                  // Balance with Wallet Icon
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A3E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Color(0xFFFFC107),
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$currency ${balance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Notification Icon (Right)
                  GestureDetector(
                    onTap: onNotificationPressed,
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFC107),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
