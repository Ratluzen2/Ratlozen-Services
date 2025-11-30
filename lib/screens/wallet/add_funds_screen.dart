import 'package:flutter/material.dart';
import 'package:ratlozen_services/services/wallet_service.dart';
import 'package:ratlozen_services/services/auth_service.dart';

class AddFundsScreen extends StatefulWidget {
  final User currentUser;

  const AddFundsScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  AddFundsScreenState createState() => AddFundsScreenState();
}

class AddFundsScreenState extends State<AddFundsScreen> {
  final WalletService _walletService = WalletService();

  void _showAsiacellDialog() {
    final _asiacellController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Top up with Asiacell'),
          content: TextField(
            controller: _asiacellController,
            decoration: InputDecoration(labelText: 'Enter scratch card number'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Simulate payment processing
                final amount = 20.0; // Dummy amount
                final currentBalance = await _walletService.getBalance(widget.currentUser.id);
                await _walletService.updateBalance(widget.currentUser.id, currentBalance + amount);
                await _walletService.addTransaction(widget.currentUser.id, 'deposit', amount, 'Asiacell top-up');
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Top-up successful!')));
              },
              child: Text('Top up'),
            ),
          ],
        );
      },
    );
  }

  void _showCreditCardDialog() {
    final _cardNumberController = TextEditingController();
    final _expiryDateController = TextEditingController();
    final _cvvController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Top up with Credit Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _cardNumberController,
                decoration: InputDecoration(labelText: 'Card Number'),
              ),
              TextField(
                controller: _expiryDateController,
                decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
              ),
              TextField(
                controller: _cvvController,
                decoration: InputDecoration(labelText: 'CVV'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Simulate payment processing
                final amount = 50.0; // Dummy amount
                final currentBalance = await _walletService.getBalance(widget.currentUser.id);
                await _walletService.updateBalance(widget.currentUser.id, currentBalance + amount);
                await _walletService.addTransaction(widget.currentUser.id, 'deposit', amount, 'Credit card top-up');
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Top-up successful!')));
              },
              child: Text('Top up'),
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
        title: Text('Add Funds'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _showAsiacellDialog,
              child: Text('Top up with Asiacell'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showCreditCardDialog,
              child: Text('Top up with Credit Card'),
            ),
          ],
        ),
      ),
    );
  }
}
