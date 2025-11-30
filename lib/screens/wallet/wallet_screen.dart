import 'package:flutter/material.dart';
import 'package:ratlozen_services/services/wallet_service.dart';

import 'package:ratlozen_services/screens/wallet/transaction_history_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  final WalletService _walletService = WalletService();
  late Future<double> _balance;

  @override
  void initState() {
    super.initState();
    _balance = _walletService.getBalance('default_user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Balance',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            FutureBuilder<double>(
              future: _balance,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Text(
                  '\$${snapshot.data?.toStringAsFixed(2) ?? '0.00'}',
                  style: Theme.of(context).textTheme.displaySmall,
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to a screen to add funds
              },
              child: const Text('Add Funds'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionHistoryScreen(),
                  ),
                );
              },
              child: const Text('View Transaction History'),
            ),
          ],
        ),
      ),
    );
  }
}
