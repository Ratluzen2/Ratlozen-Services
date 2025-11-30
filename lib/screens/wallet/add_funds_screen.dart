import 'package:flutter/material.dart';
import 'package:ratlozen_services/services/wallet_service.dart';

class AddFundsScreen extends StatefulWidget {
  const AddFundsScreen({Key? key}) : super(key: key);

  @override
  AddFundsScreenState createState() => AddFundsScreenState();
}

class AddFundsScreenState extends State<AddFundsScreen> {
  final WalletService _walletService = WalletService();

  void _showAsiacellDialog() {
    final asiacellController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Top up with Asiacell'),
          content: TextField(
            controller: asiacellController,
            decoration: const InputDecoration(labelText: 'Enter scratch card number'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Simulate payment processing
                const amount = 20.0; // Dummy amount
                final currentBalance = await _walletService.getBalance('default_user');
                await _walletService.updateBalance('default_user', currentBalance + amount);
                await _walletService.addTransaction('default_user', 'deposit', amount, 'Asiacell top-up');
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Top-up successful!')));
                }
              },
              child: const Text('Top up'),
            ),
          ],
        );
      },
    );
  }

  void _showCreditCardDialog() {
    final cardNumberController = TextEditingController();
    final expiryDateController = TextEditingController();
    final cvvController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Top up with Credit Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cardNumberController,
                decoration: const InputDecoration(labelText: 'Card Number'),
              ),
              TextField(
                controller: expiryDateController,
                decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
              ),
              TextField(
                controller: cvvController,
                decoration: const InputDecoration(labelText: 'CVV'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Simulate payment processing
                const amount = 50.0; // Dummy amount
                final currentBalance = await _walletService.getBalance('default_user');
                await _walletService.updateBalance('default_user', currentBalance + amount);
                await _walletService.addTransaction('default_user', 'deposit', amount, 'Credit card top-up');
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Top-up successful!')));
                }
              },
              child: const Text('Top up'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Funds'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _showAsiacellDialog,
              child: const Text('Top up with Asiacell'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showCreditCardDialog,
              child: const Text('Top up with Credit Card'),
            ),
          ],
        ),
      ),
    );
  }
}
